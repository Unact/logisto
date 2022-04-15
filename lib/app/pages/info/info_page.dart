import 'dart:async';

import 'package:drift/drift.dart' show TableUpdateQuery;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/orders/orders_page.dart';
import '/app/pages/person/person_page.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/services/api.dart';
import '/app/utils/format.dart';

part 'info_state.dart';
part 'info_view_model.dart';

class InfoPage extends StatelessWidget {
  InfoPage({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InfoViewModel>(
      create: (context) => InfoViewModel(context),
      child: _InfoView(),
    );
  }
}

class _InfoView extends StatefulWidget {
  @override
  _InfoViewState createState() => _InfoViewState();
}

class _InfoViewState extends State<_InfoView> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  Completer<void> _refresherCompleter = Completer();

  Future<void> openRefresher() async {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState!.show();
    });
  }

  void closeRefresher() {
    _refresherCompleter.complete();
    _refresherCompleter = Completer();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.ruAppName),
        actions: <Widget>[
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.person),
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
      body: BlocConsumer<InfoViewModel, InfoState>(
        builder: (context, state) {
          InfoViewModel vm = context.read<InfoViewModel>();

          return RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () async {
              vm.getData();
              return _refresherCompleter.future;
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 24, left: 8, right: 8, bottom: 24),
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildInfoCards(context)
                )
              ],
            )
          );
        },
        listener: (context, state) {
          switch (state.status) {
            case InfoStateStatus.startLoad:
              openRefresher();
              break;
            case InfoStateStatus.failure:
            case InfoStateStatus.success:
              showMessage(state.message);
              closeRefresher();
              break;
            default:
              break;
          }
        },
      )
    );
  }

  List<Widget> _buildInfoCards(BuildContext context) {
    return <Widget>[
      _buildOrdersCard(context),
      _buildInfoCard(context),
      _buildUserCard(context)
    ];
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
              TextSpan(text: 'Кол-во: ${vm.state.ordersWithLines.length}\n', style: const TextStyle(fontSize: 12.0)),
            ]
          )
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    InfoViewModel vm = context.read<InfoViewModel>();

    if (vm.state.newVersionAvailable) {
      return const Card(
        child: ListTile(
          isThreeLine: true,
          title: Text('Информация'),
          subtitle: Text('Доступна новая версия приложения'),
        )
      );
    } else {
      return Container();
    }
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
