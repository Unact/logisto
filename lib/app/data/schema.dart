part of 'database.dart';

class Prefs extends Table {
  DateTimeColumn get lastLogin => dateTime().nullable()();
}

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text()();
  TextColumn get name => text()();
  TextColumn get email => text()();
  IntColumn get pickupStorageId => integer().nullable()();
  TextColumn get storageIds => text().map(const JsonIntListConverter())();
  TextColumn get version => text()();
  RealColumn get total => real()();
}

class ApiCredentials extends Table {
  TextColumn get accessToken => text()();
  TextColumn get refreshToken => text()();
  TextColumn get url => text()();
}

class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get article => text().nullable()();
  TextColumn get barcodeCode => text().nullable()();
  TextColumn get barcodeType => text().nullable()();
}

class ProductArrivals extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get arrivalDate => dateTime()();
  TextColumn get number => text()();
  DateTimeColumn get unloadStart => dateTime().nullable()();
  DateTimeColumn get unloadEnd => dateTime().nullable()();
  IntColumn get storageId => integer().nullable().references(Storages, #id)();
  TextColumn get storeName => text()();
  TextColumn get sellerName => text()();
  TextColumn get statusName => text()();
  TextColumn get orderTrackingNumber => text().nullable()();
  TextColumn get comment => text().nullable()();
}

class ProductArrivalPackages extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productArrivalId => integer()
    .references(ProductArrivals, #id, onDelete: KeyAction.cascade)();
  TextColumn get number => text()();
  TextColumn get typeName => text()();
  TextColumn get qr => text()();
  DateTimeColumn get acceptStart => dateTime().nullable()();
  DateTimeColumn get acceptEnd => dateTime().nullable()();
  DateTimeColumn get placed => dateTime().nullable()();
}

class ProductArrivalUnloadPackages extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productArrivalId => integer()
    .references(ProductArrivals, #id, onDelete: KeyAction.cascade)();
  IntColumn get amount => integer()();
  TextColumn get typeName => text()();
}

class ProductArrivalPackageTypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

class ProductArrivalPackageLines extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productArrivalPackageId => integer()
    .references(ProductArrivalPackages, #id, onDelete: KeyAction.cascade)();
  IntColumn get productId => integer()
    .references(Products, #id, onDelete: KeyAction.cascade)();
  IntColumn get amount => integer()();
}

class ProductArrivalPackageNewLines extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productArrivalPackageId => integer()
    .references(ProductArrivalPackages, #id, onDelete: KeyAction.cascade)();
  IntColumn get productId => integer()
    .references(Products, #id, onDelete: KeyAction.cascade)();
  IntColumn get amount => integer()();
}

class ProductArrivalPackageNewCells extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productArrivalPackageId => integer()
    .references(ProductArrivalPackages, #id, onDelete: KeyAction.cascade)();
  IntColumn get productId => integer()
    .references(Products, #id, onDelete: KeyAction.cascade)();
  IntColumn get storageCellId => integer()();
  TextColumn get storageCellName => text()();
  IntColumn get amount => integer()();
}

class ProductArrivalNewPackages extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productArrivalId => integer()
    .references(ProductArrivals, #id, onDelete: KeyAction.cascade)();
  IntColumn get typeId => integer()();
  TextColumn get typeName => text()();
  TextColumn get number => text()();
}

class ProductArrivalNewUnloadPackages extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productArrivalId => integer()
    .references(ProductArrivals, #id, onDelete: KeyAction.cascade)();
  IntColumn get amount => integer()();
  IntColumn get typeId => integer()();
  TextColumn get typeName => text()();
}

class Orders extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get courierName => text().nullable()();
  TextColumn get trackingNumber => text()();
  TextColumn get number => text()();
  DateTimeColumn get deliveryDate => dateTime()();
  DateTimeColumn get deliveryDateTimeFrom => dateTime().nullable()();
  DateTimeColumn get deliveryDateTimeTo => dateTime().nullable()();
  TextColumn get statusName => text()();
  IntColumn get packages => integer()();
  IntColumn get weight => integer().nullable()();
  IntColumn get volume => integer().nullable()();
  TextColumn get deliveryAddressName => text()();
  TextColumn get pickupAddressName => text()();
  IntColumn get storageFromId => integer().nullable().references(Storages, #id)();
  IntColumn get storageToId => integer().nullable().references(Storages, #id)();
  DateTimeColumn get storageIssued => dateTime().nullable()();
  DateTimeColumn get storageAccepted => dateTime().nullable()();
  DateTimeColumn get firstMovementDate => dateTime().nullable()();
  DateTimeColumn get delivered => dateTime().nullable()();
  BoolColumn get documentsReturn => boolean()();
  RealColumn get paidSum => real()();
  RealColumn get paySum => real()();
}

class OrderLines extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get orderId => integer()
    .references(Orders, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
  IntColumn get amount => integer()();
  RealColumn get price => real()();
  IntColumn get factAmount => integer().nullable()();
}

class Storages extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get sequenceNumber => integer()();
}

class JsonIntListConverter extends TypeConverter<List<int>, String> {
  const JsonIntListConverter();

  @override
  List<int> mapToDart(String? fromDb) {
    return (json.decode(fromDb!) as List).cast<int>();
  }

  @override
  String mapToSql(List<int>? value) {
    return json.encode(value!);
  }
}
