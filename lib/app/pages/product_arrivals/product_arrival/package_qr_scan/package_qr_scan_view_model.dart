part of 'package_qr_scan_page.dart';

class PackageQRScanViewModel extends PageViewModel<PackageQRScanState, PackageQRScanStateStatus> {
  PackageQRScanViewModel(BuildContext context, { required List<ProductArrivalPackageEx> packages }) :
    super(context, PackageQRScanState(packages: packages));

  @override
  PackageQRScanStateStatus get status => state.status;

  @override
  Future<void> loadData() async {}

  Future<void> readQRCode(String? qrCode) async {
    if (qrCode == null) return;

    List<String> qrCodeData = qrCode.split(' ');
    String version = qrCodeData[0];

    if (version != Strings.qrCodeVersion) {
      emit(state.copyWith(status: PackageQRScanStateStatus.failure, message: 'Считан не поддерживаемый QR код'));
      return;
    }

    if (qrCodeData[3] != QRType.productArrivalPackage.typeName) {
      emit(state.copyWith(status: PackageQRScanStateStatus.failure, message: 'QR код не от места приемки'));
      return;
    }

    _processQR(int.parse(qrCodeData[1]));
  }

  void _processQR(int packageId) {
    ProductArrivalPackageEx? packageEx = state.packages.firstWhereOrNull((e) => e.package.id == packageId);

    emit(state.copyWith(status: PackageQRScanStateStatus.finished, packageEx: packageEx));
  }
}
