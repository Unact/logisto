part of 'entities.dart';

class ApiProductArrival {
  final int id;
  final String number;
  final DateTime arrivalDate;
  final DateTime? unloadStart;
  final DateTime? unloadEnd;
  final List<ApiProductArrivalPackage> packages;
  final ApiStorage storage;

  const ApiProductArrival({
    required this.id,
    required this.number,
    required this.arrivalDate,
    this.unloadStart,
    this.unloadEnd,
    required this.packages,
    required this.storage,
  });

  factory ApiProductArrival.fromJson(dynamic json) {
    return ApiProductArrival(
      id: json['id'],
      number: json['number'],
      arrivalDate: Parsing.parseDate(json['arrivalDate'])!,
      unloadStart: Parsing.parseDate(json['unloadStart']),
      unloadEnd: Parsing.parseDate(json['unloadEnd']),
      packages: json['packages'].map<ApiProductArrivalPackage>((e) => ApiProductArrivalPackage.fromJson(e)).toList(),
      storage: ApiStorage.fromJson(json['storage'])
    );
  }

  ProductArrivalEx toDatabaseEnt() {
    ProductArrival productArrival = ProductArrival(
      id: id,
      number: number,
      arrivalDate: arrivalDate,
      unloadStart: unloadStart,
      unloadEnd: unloadEnd,
      storageId: storage.id
    );
    List<ProductArrivalPackageEx> productArrivalPackages = packages.map((e) {
      final productArrivalPackage = ProductArrivalPackage(
        id: e.id,
        productArrivalId: id,
        number: e.number,
        acceptStart: e.acceptStart,
        acceptEnd: e.acceptEnd,
      );
      final lines = e.lines.map((line) => ProductArrivalPackageLine(
        id: line.id,
        productArrivalPackageId: e.id,
        productName: line.productName,
        amount: line.amount
      )).toList();

      return ProductArrivalPackageEx(productArrivalPackage, lines);
    }).toList();
    Storage dbStorage = Storage(id: storage.id, name: storage.name, sequenceNumber: storage.sequenceNumber);

    return ProductArrivalEx(
      productArrival,
      dbStorage,
      productArrivalPackages,
    );
  }
}