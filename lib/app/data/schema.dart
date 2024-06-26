part of 'database.dart';

class Prefs extends Table {
  DateTimeColumn get logoutAfter => dateTime()();
  DateTimeColumn get lastLoadTime => dateTime().nullable()();
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

class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get groupName => text()();
  TextColumn get article => text().nullable()();
  IntColumn get length => integer().nullable()();
  IntColumn get width => integer().nullable()();
  IntColumn get height => integer().nullable()();
  IntColumn get weight => integer().nullable()();
  BoolColumn get archived => boolean()();
  BoolColumn get needMarking => boolean()();
  BoolColumn get inPackage => boolean()();
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

class ProductArrivalLines extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productArrivalId => integer()
    .references(ProductArrivalPackages, #id, onDelete: KeyAction.cascade)();
  IntColumn get productId => integer()
    .references(Products, #id, onDelete: KeyAction.cascade)();
  IntColumn get amount => integer()();
  BoolColumn get enumeratePiece => boolean()();
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
  DateTimeColumn get markingScanned => dateTime().nullable()();
  BoolColumn get needMarkingScan => boolean()();
}

class ProductArrivalUnloadPackages extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productArrivalId => integer()
    .references(ProductArrivals, #id, onDelete: KeyAction.cascade)();
  IntColumn get amount => integer()();
  TextColumn get typeName => text()();
}

class PackageTypes extends Table {
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

class ProductArrivalPackageNewCodes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productArrivalPackageId => integer()
    .references(ProductArrivalPackages, #id, onDelete: KeyAction.cascade)();
  IntColumn get productId => integer()
    .references(Products, #id, onDelete: KeyAction.cascade)();
  TextColumn get code => text()();
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
  IntColumn get storageCellId => integer()
    .references(StorageCells, #id, onDelete: KeyAction.cascade)();
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

class ProductStores extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class ProductTransfers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get storeFromId => text().nullable()
    .references(ProductStores, #id, onDelete: KeyAction.cascade)();
  TextColumn get storeToId => text().nullable()
    .references(ProductStores, #id, onDelete: KeyAction.cascade)();
  TextColumn get comment => text().nullable()();
  BoolColumn get gatherFinished => boolean()();
}

class ProductTransferFromCells extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productTransferId => integer()
    .references(ProductTransfers, #id, onDelete: KeyAction.cascade)();
  IntColumn get productId => integer()
    .references(Products, #id, onDelete: KeyAction.cascade)();
  IntColumn get storageCellId => integer()
    .references(StorageCells, #id, onDelete: KeyAction.cascade)();
  IntColumn get amount => integer()();
}

class ProductTransferToCells extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productTransferId => integer()
    .references(ProductTransfers, #id, onDelete: KeyAction.cascade)();
  IntColumn get productId => integer()
    .references(Products, #id, onDelete: KeyAction.cascade)();
  IntColumn get storageCellId => integer()
    .references(StorageCells, #id, onDelete: KeyAction.cascade)();
  IntColumn get amount => integer()();
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
  DateTimeColumn get markingScanned => dateTime().nullable()();
  BoolColumn get needMarkingScan => boolean()();
}

class OrderLines extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get orderId => integer()
    .references(Orders, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
  IntColumn get amount => integer()();
  RealColumn get price => real()();
  IntColumn get factAmount => integer().nullable()();
  IntColumn get productId => integer().nullable()
    .references(Products, #id, onDelete: KeyAction.cascade)();
}

class OrderLineNewCodes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get orderLineId => integer()
    .references(OrderLines, #id, onDelete: KeyAction.cascade)();
  TextColumn get code => text()();
}

class Storages extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get sequenceNumber => integer()();
}

class StorageCells extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

class JsonIntListConverter extends TypeConverter<List<int>, String> {
  const JsonIntListConverter();

  @override
  List<int> fromSql(String? fromDb) {
    return (json.decode(fromDb!) as List).cast<int>();
  }

  @override
  String toSql(List<int>? value) {
    return json.encode(value!);
  }
}
