part of '../product_arrival_qr_scan/product_arrival_qr_scan_page.dart';

class ProductArrivalQRScanViewModel extends PageViewModel<ProductArrivalQRScanState, ProductArrivalQRScanStateStatus> {
  ProductArrivalQRScanViewModel(BuildContext context, { required List<ProductArrivalPackageEx> packages }) :
    super(context, ProductArrivalQRScanState(packages: packages));

  @override
  ProductArrivalQRScanStateStatus get status => state.status;

  @override
  Future<void> loadData() async {
    emit(state.copyWith(
      status: ProductArrivalQRScanStateStatus.dataLoaded
    ));
  }

  Future<void> readQRCode(String? qrCode) async {
    if (qrCode == null) return;

    List<String> qrCodeData = qrCode.split(' ');
    String version = qrCodeData[0];

    if (version != Strings.newQRCodeVersion) {
      emit(state.copyWith(status: ProductArrivalQRScanStateStatus.failure, message: 'Считан не поддерживаемый QR код'));
      return;
    }

    if (qrCodeData[3] != QRTypes.productArrivalPackage.typeName) {
      emit(state.copyWith(status: ProductArrivalQRScanStateStatus.failure, message: 'QR код не от места приемки'));
      return;
    }

    _processQR(int.parse(qrCodeData[1]));
  }

  void _processQR(int packageId) {
    ProductArrivalPackageEx? packageEx = state.packages.firstWhereOrNull((e) => e.package.id == packageId);

    emit(state.copyWith(status: ProductArrivalQRScanStateStatus.finished, packageEx: packageEx));
  }
}
