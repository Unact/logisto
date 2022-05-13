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

class Orders extends Table {
  IntColumn get id => integer()();
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
  IntColumn get storageFromId => integer().nullable().references(OrderStorages, #id)();
  IntColumn get storageToId => integer().nullable().references(OrderStorages, #id)();
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
  IntColumn get orderId => integer().references(Orders, #id)();

  TextColumn get name => text()();
  IntColumn get amount => integer()();
  RealColumn get price => real()();
  IntColumn get factAmount => integer().nullable()();
}

class OrderStorages extends Table {
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
