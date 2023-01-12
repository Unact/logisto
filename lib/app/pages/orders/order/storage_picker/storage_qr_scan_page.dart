part of 'storage_picker.dart';

class StorageQRScanPage extends StatelessWidget {
  final List<Storage> storages;

  StorageQRScanPage({
    Key? key,
    required this.storages
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StorageQRScanViewModel>(
      create: (context) => StorageQRScanViewModel(context, storages: storages),
      child: _StorageQRScanView(),
    );
  }
}

class _StorageQRScanView extends StatefulWidget {
  @override
  _StorageQRScanViewState createState() => _StorageQRScanViewState();
}

class _StorageQRScanViewState extends State<_StorageQRScanView> {
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StorageQRScanViewModel, StorageQRScanState>(
      builder: (context, state) {
        StorageQRScanViewModel vm = context.read<StorageQRScanViewModel>();

        return ScanView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: const Text('Отсканируйте склад', style: Style.qrScanTitleText)
              )
            ]
          ),
          onRead: vm.readQRCode
        );
      },
      listener: (context, state) {
        switch (state.status) {
          case StorageQRScanStateStatus.failure:
            showMessage(state.message);
            break;
          case StorageQRScanStateStatus.finished:
            Navigator.of(context).pop(state.storage);
            break;
          default:
        }
      }
    );
  }
}
