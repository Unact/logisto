import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/core.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/orders/orders_page.dart';
import '/app/pages/product_arrivals/product_arrivals_page.dart';
import '/app/pages/person/person_page.dart';
import '/app/pages/product/product_page.dart';
import '/app/pages/product_transfer/product_transfer_page.dart';
import '/app/pages/shared/product_search_field/product_search_field.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/repositories/app_repository.dart';
import '/app/repositories/product_transfers_repository.dart';
import '/app/repositories/users_repository.dart';

part 'info_state.dart';
part 'info_view_model.dart';

class InfoPage extends StatelessWidget {
  InfoPage({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InfoViewModel>(
      create: (context) => InfoViewModel(
        RepositoryProvider.of<AppRepository>(context),
        RepositoryProvider.of<ProductTransfersRepository>(context),
        RepositoryProvider.of<UsersRepository>(context),
      ),
      child: _InfoView(),
    );
  }
}

class _InfoView extends StatefulWidget {
  @override
  _InfoViewState createState() => _InfoViewState();
}

class _InfoViewState extends State<_InfoView> {
  final ScrollController scrollController = ScrollController();
  final EasyRefreshController refreshController = EasyRefreshController();

  Future<void> showProductSearch() async {
    Product? product = await showDialog<Product?>(
      context: context,
      builder: (BuildContext context) {
        Product? newProduct;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              alignment: Alignment.topCenter,
              title: const Text('Поиск товара'),
              content: ProductSearchField(
                onProductSelect: (product) => setState(() => newProduct = product),
                product: newProduct,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: newProduct == null ? null : () => Navigator.of(context).pop(newProduct),
                  child: const Text(Strings.ok)
                ),
                TextButton(
                  child: const Text(Strings.cancel),
                  onPressed: () => Navigator.of(context).pop(null)
                )
              ],
            );
          }
        );
      }
    );

    if (product == null) return;

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => ProductPage(product: product),
        fullscreenDialog: true
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InfoViewModel, InfoState>(
      builder: (context, state) {
        InfoViewModel vm = context.read<InfoViewModel>();
        final lastLoadTime = state.appInfo?.lastLoadTime != null ?
          Format.dateTimeStr(state.appInfo?.lastLoadTime) :
          'Загрузка не проводилась';

        return Scaffold(
          appBar: AppBar(
            title: const Text(Strings.ruAppName),
            actions: <Widget>[
              IconButton(
                color: Colors.white,
                icon: const Icon(Icons.search),
                tooltip: 'Поиск товара',
                onPressed: showProductSearch
              ),
              IconButton(
                color: Colors.white,
                icon: const Icon(Icons.compare_arrows),
                tooltip: 'Перемещение',
                onPressed: vm.startTransfer
              ),
              IconButton(
                color: Colors.white,
                icon: const Icon(Icons.person),
                tooltip: 'Пользователь',
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => PersonPage(),
                      fullscreenDialog: true
                    )
                  );
                }
              )
            ]
          ),
          body: Refreshable(
            scrollController: scrollController,
            refreshController: refreshController,
            confirmRefresh: false,
            messageText: 'Последнее обновление: $lastLoadTime',
            onRefresh: vm.getData,
            onError: (error, stackTrace) {
              if (error is! AppError) Misc.reportError(error, stackTrace);
            },
            childBuilder: (context, physics) => ListView(
              physics: physics,
              padding: const EdgeInsets.only(top: 24, left: 8, right: 8, bottom: 24),
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildInfoCards(context)
                )
              ],
            )
          )
        );
      },
      listener: (context, state) {
        switch (state.status) {
          case InfoStateStatus.startLoad:
            refreshController.callRefresh(scrollController: scrollController);
            break;
          case InfoStateStatus.startTransfer:
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ProductTransferPage(productTransferEx: state.productTransferEx!)
                )
              );
            });
            break;
          default:
            break;
        }
      },
    );
  }

  List<Widget> _buildInfoCards(BuildContext context) {
    return <Widget>[
      _buildOrdersCard(context),
      _buildProductArrivalsCard(context),
      _buildUserCard(context),
      _buildInfoCard(context),
    ];
  }

  Widget _buildProductArrivalsCard(BuildContext context) {
    InfoViewModel vm = context.read<InfoViewModel>();

    return Card(
      child: ListTile(
        onTap: () {
          if (vm.state.loading) return;

          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProductArrivalsPage()));
        },
        isThreeLine: true,
        title: const Text('Разгрузки'),
        subtitle: RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.grey),
            children: <TextSpan>[
              TextSpan(
                text: 'Кол-во: ${vm.state.appInfo?.productArrivalsTotal ?? 0}\n',
                style: const TextStyle(fontSize: 12.0)
              ),
            ]
          )
        ),
      ),
    );
  }

  Widget _buildOrdersCard(BuildContext context) {
    InfoViewModel vm = context.read<InfoViewModel>();

    return Card(
      child: ListTile(
        onTap: () {
          if (vm.state.loading) return;

          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OrdersPage()));
        },
        isThreeLine: true,
        title: const Text('Заказы'),
        subtitle: RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.grey),
            children: <TextSpan>[
              TextSpan(text: 'Кол-во: ${vm.state.appInfo?.ordersTotal ?? 0}\n', style: const TextStyle(fontSize: 12.0)),
            ]
          )
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    InfoViewModel vm = context.read<InfoViewModel>();

    return FutureBuilder(
      future: vm.state.user?.newVersionAvailable,
      builder: (context, snapshot) {
        if (!(snapshot.data ?? false)) return Container();

        return const Card(
          child: ListTile(
            isThreeLine: true,
            title: Text('Информация'),
            subtitle: Text('Доступна новая версия приложения'),
          )
        );
      }
    );
  }

  Widget _buildUserCard(BuildContext context) {
    InfoViewModel vm = context.read<InfoViewModel>();

    return Card(
      child: ListTile(
        isThreeLine: true,
        title: const Text('Касса'),
        subtitle: RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.grey),
            children: <TextSpan>[
              TextSpan(
                text: 'Остаток в кассе: ${Format.numberStr(vm.state.total)}',
                style: const TextStyle(fontSize: 12.0)
              ),
            ]
          )
        ),
      ),
    );
  }
}
