part of 'entities.dart';

class ApiProductArrival extends Equatable {
  final int id;
  final String number;
  final DateTime arrivalDate;
  final DateTime? unloadStart;
  final DateTime? unloadEnd;
  final List<ApiProductArrivalPackage> packages;
  final List<ApiProductArrivalUnloadPackage> unloadPackages;
  final ApiStorage storage;
  final String storeName;
  final String sellerName;
  final String statusName;
  final String? orderTrackingNumber;
  final String? comment;

  const ApiProductArrival({
    required this.id,
    required this.number,
    required this.arrivalDate,
    this.unloadStart,
    this.unloadEnd,
    required this.packages,
    required this.unloadPackages,
    required this.storage,
    required this.storeName,
    required this.sellerName,
    required this.statusName,
    required this.orderTrackingNumber,
    required this.comment
  });

  factory ApiProductArrival.fromJson(dynamic json) {
    return ApiProductArrival(
      id: json['id'],
      number: json['number'],
      arrivalDate: Parsing.parseDate(json['arrivalDate'])!,
      unloadStart: Parsing.parseDate(json['unloadStart']),
      unloadEnd: Parsing.parseDate(json['unloadEnd']),
      packages: json['packages'].map<ApiProductArrivalPackage>((e) => ApiProductArrivalPackage.fromJson(e)).toList(),
      unloadPackages: json['unloadPackages'].map<ApiProductArrivalUnloadPackage>(
        (e) => ApiProductArrivalUnloadPackage.fromJson(e)
      ).toList(),
      storage: ApiStorage.fromJson(json['storage']),
      storeName: json['storeName'],
      sellerName: json['sellerName'],
      statusName: json['statusName'],
      orderTrackingNumber: json['orderTrackingNumber'],
      comment: json['comment']
    );
  }

  ProductArrivalEx toDatabaseEnt() {
    ProductArrival productArrival = ProductArrival(
      id: id,
      number: number,
      arrivalDate: arrivalDate,
      unloadStart: unloadStart,
      unloadEnd: unloadEnd,
      storageId: storage.id,
      storeName: storeName,
      sellerName: sellerName,
      statusName: statusName,
      orderTrackingNumber: orderTrackingNumber,
      comment: comment
    );
    List<ProductArrivalPackageEx> productArrivalPackages = packages.map((e) {
      final productArrivalPackage = ProductArrivalPackage(
        id: e.id,
        productArrivalId: id,
        number: e.number,
        typeName: e.typeName,
        acceptStart: e.acceptStart,
        acceptEnd: e.acceptEnd,
        placed: e.placed
      );
      final lines = e.lines.map((line) => ProductArrivalPackageLine(
        id: line.id,
        productArrivalPackageId: e.id,
        productId: line.productId,
        productName: line.productName,
        amount: line.amount
      )).toList();

      return ProductArrivalPackageEx(productArrivalPackage, lines);
    }).toList();
    List<ProductArrivalUnloadPackage> productArrivalUnloadPackages = unloadPackages.map((e) {
      return ProductArrivalUnloadPackage(
        id: e.id,
        productArrivalId: id,
        amount: e.amount,
        typeName: e.typeName
      );
    }).toList();
    Storage dbStorage = Storage(id: storage.id, name: storage.name, sequenceNumber: storage.sequenceNumber);

    return ProductArrivalEx(
      productArrival,
      dbStorage,
      productArrivalPackages,
      productArrivalUnloadPackages
    );
  }

  @override
  List<Object?> get props => [
    id,
    number,
    arrivalDate,
    unloadStart,
    unloadEnd,
    packages,
    unloadPackages,
    storage,
    storeName,
    sellerName,
    statusName,
    orderTrackingNumber,
    comment
  ];
}
