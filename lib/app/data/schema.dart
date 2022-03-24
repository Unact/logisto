part of 'database.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text()();
  TextColumn get name => text()();
  TextColumn get email => text()();
  TextColumn get storageName => text()();
  TextColumn get roles => text().map(const JsonConverter())();
  TextColumn get version => text()();
}

class ApiCredentials extends Table {
  IntColumn get id => integer().autoIncrement()();
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
  TextColumn get storageName => text().nullable()();
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
}

class JsonConverter extends TypeConverter<List<String>, String> {
  const JsonConverter();

  @override
  List<String> mapToDart(String? fromDb) {
    return (json.decode(fromDb!) as List).cast<String>();
  }

  @override
  String mapToSql(List<String>? value) {
    return json.encode(value!);
  }
}
