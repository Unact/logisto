// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class User extends DataClass implements Insertable<User> {
  final int id;
  final String username;
  final String name;
  final String email;
  final int? pickupStorageId;
  final List<int> storageIds;
  final String version;
  final double total;
  User(
      {required this.id,
      required this.username,
      required this.name,
      required this.email,
      this.pickupStorageId,
      required this.storageIds,
      required this.version,
      required this.total});
  factory User.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return User(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      username: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}username'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      email: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email'])!,
      pickupStorageId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}pickup_storage_id']),
      storageIds: $UsersTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}storage_ids']))!,
      version: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}version'])!,
      total: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}total'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    if (!nullToAbsent || pickupStorageId != null) {
      map['pickup_storage_id'] = Variable<int?>(pickupStorageId);
    }
    {
      final converter = $UsersTable.$converter0;
      map['storage_ids'] = Variable<String>(converter.mapToSql(storageIds)!);
    }
    map['version'] = Variable<String>(version);
    map['total'] = Variable<double>(total);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      username: Value(username),
      name: Value(name),
      email: Value(email),
      pickupStorageId: pickupStorageId == null && nullToAbsent
          ? const Value.absent()
          : Value(pickupStorageId),
      storageIds: Value(storageIds),
      version: Value(version),
      total: Value(total),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      pickupStorageId: serializer.fromJson<int?>(json['pickupStorageId']),
      storageIds: serializer.fromJson<List<int>>(json['storageIds']),
      version: serializer.fromJson<String>(json['version']),
      total: serializer.fromJson<double>(json['total']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'pickupStorageId': serializer.toJson<int?>(pickupStorageId),
      'storageIds': serializer.toJson<List<int>>(storageIds),
      'version': serializer.toJson<String>(version),
      'total': serializer.toJson<double>(total),
    };
  }

  User copyWith(
          {int? id,
          String? username,
          String? name,
          String? email,
          int? pickupStorageId,
          List<int>? storageIds,
          String? version,
          double? total}) =>
      User(
        id: id ?? this.id,
        username: username ?? this.username,
        name: name ?? this.name,
        email: email ?? this.email,
        pickupStorageId: pickupStorageId ?? this.pickupStorageId,
        storageIds: storageIds ?? this.storageIds,
        version: version ?? this.version,
        total: total ?? this.total,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('pickupStorageId: $pickupStorageId, ')
          ..write('storageIds: $storageIds, ')
          ..write('version: $version, ')
          ..write('total: $total')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, username, name, email, pickupStorageId, storageIds, version, total);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.username == this.username &&
          other.name == this.name &&
          other.email == this.email &&
          other.pickupStorageId == this.pickupStorageId &&
          other.storageIds == this.storageIds &&
          other.version == this.version &&
          other.total == this.total);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> name;
  final Value<String> email;
  final Value<int?> pickupStorageId;
  final Value<List<int>> storageIds;
  final Value<String> version;
  final Value<double> total;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.pickupStorageId = const Value.absent(),
    this.storageIds = const Value.absent(),
    this.version = const Value.absent(),
    this.total = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String name,
    required String email,
    this.pickupStorageId = const Value.absent(),
    required List<int> storageIds,
    required String version,
    required double total,
  })  : username = Value(username),
        name = Value(name),
        email = Value(email),
        storageIds = Value(storageIds),
        version = Value(version),
        total = Value(total);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? name,
    Expression<String>? email,
    Expression<int?>? pickupStorageId,
    Expression<List<int>>? storageIds,
    Expression<String>? version,
    Expression<double>? total,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (pickupStorageId != null) 'pickup_storage_id': pickupStorageId,
      if (storageIds != null) 'storage_ids': storageIds,
      if (version != null) 'version': version,
      if (total != null) 'total': total,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String>? username,
      Value<String>? name,
      Value<String>? email,
      Value<int?>? pickupStorageId,
      Value<List<int>>? storageIds,
      Value<String>? version,
      Value<double>? total}) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      email: email ?? this.email,
      pickupStorageId: pickupStorageId ?? this.pickupStorageId,
      storageIds: storageIds ?? this.storageIds,
      version: version ?? this.version,
      total: total ?? this.total,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (pickupStorageId.present) {
      map['pickup_storage_id'] = Variable<int?>(pickupStorageId.value);
    }
    if (storageIds.present) {
      final converter = $UsersTable.$converter0;
      map['storage_ids'] =
          Variable<String>(converter.mapToSql(storageIds.value)!);
    }
    if (version.present) {
      map['version'] = Variable<String>(version.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('pickupStorageId: $pickupStorageId, ')
          ..write('storageIds: $storageIds, ')
          ..write('version: $version, ')
          ..write('total: $total')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  @override
  late final GeneratedColumn<String?> username = GeneratedColumn<String?>(
      'username', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String?> email = GeneratedColumn<String?>(
      'email', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _pickupStorageIdMeta =
      const VerificationMeta('pickupStorageId');
  @override
  late final GeneratedColumn<int?> pickupStorageId = GeneratedColumn<int?>(
      'pickup_storage_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _storageIdsMeta = const VerificationMeta('storageIds');
  @override
  late final GeneratedColumnWithTypeConverter<List<int>, String?> storageIds =
      GeneratedColumn<String?>('storage_ids', aliasedName, false,
              type: const StringType(), requiredDuringInsert: true)
          .withConverter<List<int>>($UsersTable.$converter0);
  final VerificationMeta _versionMeta = const VerificationMeta('version');
  @override
  late final GeneratedColumn<String?> version = GeneratedColumn<String?>(
      'version', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double?> total = GeneratedColumn<double?>(
      'total', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, username, name, email, pickupStorageId, storageIds, version, total];
  @override
  String get aliasedName => _alias ?? 'users';
  @override
  String get actualTableName => 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('pickup_storage_id')) {
      context.handle(
          _pickupStorageIdMeta,
          pickupStorageId.isAcceptableOrUnknown(
              data['pickup_storage_id']!, _pickupStorageIdMeta));
    }
    context.handle(_storageIdsMeta, const VerificationResult.success());
    if (data.containsKey('version')) {
      context.handle(_versionMeta,
          version.isAcceptableOrUnknown(data['version']!, _versionMeta));
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
          _totalMeta, total.isAcceptableOrUnknown(data['total']!, _totalMeta));
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    return User.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }

  static TypeConverter<List<int>, String> $converter0 =
      const JsonIntListConverter();
}

class OrderStorage extends DataClass implements Insertable<OrderStorage> {
  final int id;
  final String name;
  final int sequenceNumber;
  OrderStorage(
      {required this.id, required this.name, required this.sequenceNumber});
  factory OrderStorage.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return OrderStorage(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      sequenceNumber: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}sequence_number'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['sequence_number'] = Variable<int>(sequenceNumber);
    return map;
  }

  OrderStoragesCompanion toCompanion(bool nullToAbsent) {
    return OrderStoragesCompanion(
      id: Value(id),
      name: Value(name),
      sequenceNumber: Value(sequenceNumber),
    );
  }

  factory OrderStorage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderStorage(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      sequenceNumber: serializer.fromJson<int>(json['sequenceNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'sequenceNumber': serializer.toJson<int>(sequenceNumber),
    };
  }

  OrderStorage copyWith({int? id, String? name, int? sequenceNumber}) =>
      OrderStorage(
        id: id ?? this.id,
        name: name ?? this.name,
        sequenceNumber: sequenceNumber ?? this.sequenceNumber,
      );
  @override
  String toString() {
    return (StringBuffer('OrderStorage(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sequenceNumber: $sequenceNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, sequenceNumber);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderStorage &&
          other.id == this.id &&
          other.name == this.name &&
          other.sequenceNumber == this.sequenceNumber);
}

class OrderStoragesCompanion extends UpdateCompanion<OrderStorage> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> sequenceNumber;
  const OrderStoragesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.sequenceNumber = const Value.absent(),
  });
  OrderStoragesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int sequenceNumber,
  })  : name = Value(name),
        sequenceNumber = Value(sequenceNumber);
  static Insertable<OrderStorage> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? sequenceNumber,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (sequenceNumber != null) 'sequence_number': sequenceNumber,
    });
  }

  OrderStoragesCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<int>? sequenceNumber}) {
    return OrderStoragesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      sequenceNumber: sequenceNumber ?? this.sequenceNumber,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sequenceNumber.present) {
      map['sequence_number'] = Variable<int>(sequenceNumber.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrderStoragesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sequenceNumber: $sequenceNumber')
          ..write(')'))
        .toString();
  }
}

class $OrderStoragesTable extends OrderStorages
    with TableInfo<$OrderStoragesTable, OrderStorage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrderStoragesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _sequenceNumberMeta =
      const VerificationMeta('sequenceNumber');
  @override
  late final GeneratedColumn<int?> sequenceNumber = GeneratedColumn<int?>(
      'sequence_number', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, sequenceNumber];
  @override
  String get aliasedName => _alias ?? 'order_storages';
  @override
  String get actualTableName => 'order_storages';
  @override
  VerificationContext validateIntegrity(Insertable<OrderStorage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sequence_number')) {
      context.handle(
          _sequenceNumberMeta,
          sequenceNumber.isAcceptableOrUnknown(
              data['sequence_number']!, _sequenceNumberMeta));
    } else if (isInserting) {
      context.missing(_sequenceNumberMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrderStorage map(Map<String, dynamic> data, {String? tablePrefix}) {
    return OrderStorage.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $OrderStoragesTable createAlias(String alias) {
    return $OrderStoragesTable(attachedDatabase, alias);
  }
}

class Order extends DataClass implements Insertable<Order> {
  final int id;
  final String? courierName;
  final String trackingNumber;
  final String number;
  final DateTime deliveryDate;
  final DateTime? deliveryDateTimeFrom;
  final DateTime? deliveryDateTimeTo;
  final String statusName;
  final int packages;
  final int? weight;
  final int? volume;
  final String deliveryAddressName;
  final String pickupAddressName;
  final int? storageFromId;
  final int? storageToId;
  final DateTime? storageIssued;
  final DateTime? storageAccepted;
  final DateTime? firstMovementDate;
  final DateTime? delivered;
  final bool documentsReturn;
  final double paidSum;
  final double paySum;
  Order(
      {required this.id,
      this.courierName,
      required this.trackingNumber,
      required this.number,
      required this.deliveryDate,
      this.deliveryDateTimeFrom,
      this.deliveryDateTimeTo,
      required this.statusName,
      required this.packages,
      this.weight,
      this.volume,
      required this.deliveryAddressName,
      required this.pickupAddressName,
      this.storageFromId,
      this.storageToId,
      this.storageIssued,
      this.storageAccepted,
      this.firstMovementDate,
      this.delivered,
      required this.documentsReturn,
      required this.paidSum,
      required this.paySum});
  factory Order.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Order(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      courierName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}courier_name']),
      trackingNumber: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}tracking_number'])!,
      number: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}number'])!,
      deliveryDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}delivery_date'])!,
      deliveryDateTimeFrom: const DateTimeType().mapFromDatabaseResponse(
          data['${effectivePrefix}delivery_date_time_from']),
      deliveryDateTimeTo: const DateTimeType().mapFromDatabaseResponse(
          data['${effectivePrefix}delivery_date_time_to']),
      statusName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}status_name'])!,
      packages: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}packages'])!,
      weight: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}weight']),
      volume: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}volume']),
      deliveryAddressName: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}delivery_address_name'])!,
      pickupAddressName: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}pickup_address_name'])!,
      storageFromId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}storage_from_id']),
      storageToId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}storage_to_id']),
      storageIssued: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}storage_issued']),
      storageAccepted: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}storage_accepted']),
      firstMovementDate: const DateTimeType().mapFromDatabaseResponse(
          data['${effectivePrefix}first_movement_date']),
      delivered: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}delivered']),
      documentsReturn: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}documents_return'])!,
      paidSum: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}paid_sum'])!,
      paySum: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}pay_sum'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || courierName != null) {
      map['courier_name'] = Variable<String?>(courierName);
    }
    map['tracking_number'] = Variable<String>(trackingNumber);
    map['number'] = Variable<String>(number);
    map['delivery_date'] = Variable<DateTime>(deliveryDate);
    if (!nullToAbsent || deliveryDateTimeFrom != null) {
      map['delivery_date_time_from'] =
          Variable<DateTime?>(deliveryDateTimeFrom);
    }
    if (!nullToAbsent || deliveryDateTimeTo != null) {
      map['delivery_date_time_to'] = Variable<DateTime?>(deliveryDateTimeTo);
    }
    map['status_name'] = Variable<String>(statusName);
    map['packages'] = Variable<int>(packages);
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<int?>(weight);
    }
    if (!nullToAbsent || volume != null) {
      map['volume'] = Variable<int?>(volume);
    }
    map['delivery_address_name'] = Variable<String>(deliveryAddressName);
    map['pickup_address_name'] = Variable<String>(pickupAddressName);
    if (!nullToAbsent || storageFromId != null) {
      map['storage_from_id'] = Variable<int?>(storageFromId);
    }
    if (!nullToAbsent || storageToId != null) {
      map['storage_to_id'] = Variable<int?>(storageToId);
    }
    if (!nullToAbsent || storageIssued != null) {
      map['storage_issued'] = Variable<DateTime?>(storageIssued);
    }
    if (!nullToAbsent || storageAccepted != null) {
      map['storage_accepted'] = Variable<DateTime?>(storageAccepted);
    }
    if (!nullToAbsent || firstMovementDate != null) {
      map['first_movement_date'] = Variable<DateTime?>(firstMovementDate);
    }
    if (!nullToAbsent || delivered != null) {
      map['delivered'] = Variable<DateTime?>(delivered);
    }
    map['documents_return'] = Variable<bool>(documentsReturn);
    map['paid_sum'] = Variable<double>(paidSum);
    map['pay_sum'] = Variable<double>(paySum);
    return map;
  }

  OrdersCompanion toCompanion(bool nullToAbsent) {
    return OrdersCompanion(
      id: Value(id),
      courierName: courierName == null && nullToAbsent
          ? const Value.absent()
          : Value(courierName),
      trackingNumber: Value(trackingNumber),
      number: Value(number),
      deliveryDate: Value(deliveryDate),
      deliveryDateTimeFrom: deliveryDateTimeFrom == null && nullToAbsent
          ? const Value.absent()
          : Value(deliveryDateTimeFrom),
      deliveryDateTimeTo: deliveryDateTimeTo == null && nullToAbsent
          ? const Value.absent()
          : Value(deliveryDateTimeTo),
      statusName: Value(statusName),
      packages: Value(packages),
      weight:
          weight == null && nullToAbsent ? const Value.absent() : Value(weight),
      volume:
          volume == null && nullToAbsent ? const Value.absent() : Value(volume),
      deliveryAddressName: Value(deliveryAddressName),
      pickupAddressName: Value(pickupAddressName),
      storageFromId: storageFromId == null && nullToAbsent
          ? const Value.absent()
          : Value(storageFromId),
      storageToId: storageToId == null && nullToAbsent
          ? const Value.absent()
          : Value(storageToId),
      storageIssued: storageIssued == null && nullToAbsent
          ? const Value.absent()
          : Value(storageIssued),
      storageAccepted: storageAccepted == null && nullToAbsent
          ? const Value.absent()
          : Value(storageAccepted),
      firstMovementDate: firstMovementDate == null && nullToAbsent
          ? const Value.absent()
          : Value(firstMovementDate),
      delivered: delivered == null && nullToAbsent
          ? const Value.absent()
          : Value(delivered),
      documentsReturn: Value(documentsReturn),
      paidSum: Value(paidSum),
      paySum: Value(paySum),
    );
  }

  factory Order.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Order(
      id: serializer.fromJson<int>(json['id']),
      courierName: serializer.fromJson<String?>(json['courierName']),
      trackingNumber: serializer.fromJson<String>(json['trackingNumber']),
      number: serializer.fromJson<String>(json['number']),
      deliveryDate: serializer.fromJson<DateTime>(json['deliveryDate']),
      deliveryDateTimeFrom:
          serializer.fromJson<DateTime?>(json['deliveryDateTimeFrom']),
      deliveryDateTimeTo:
          serializer.fromJson<DateTime?>(json['deliveryDateTimeTo']),
      statusName: serializer.fromJson<String>(json['statusName']),
      packages: serializer.fromJson<int>(json['packages']),
      weight: serializer.fromJson<int?>(json['weight']),
      volume: serializer.fromJson<int?>(json['volume']),
      deliveryAddressName:
          serializer.fromJson<String>(json['deliveryAddressName']),
      pickupAddressName: serializer.fromJson<String>(json['pickupAddressName']),
      storageFromId: serializer.fromJson<int?>(json['storageFromId']),
      storageToId: serializer.fromJson<int?>(json['storageToId']),
      storageIssued: serializer.fromJson<DateTime?>(json['storageIssued']),
      storageAccepted: serializer.fromJson<DateTime?>(json['storageAccepted']),
      firstMovementDate:
          serializer.fromJson<DateTime?>(json['firstMovementDate']),
      delivered: serializer.fromJson<DateTime?>(json['delivered']),
      documentsReturn: serializer.fromJson<bool>(json['documentsReturn']),
      paidSum: serializer.fromJson<double>(json['paidSum']),
      paySum: serializer.fromJson<double>(json['paySum']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'courierName': serializer.toJson<String?>(courierName),
      'trackingNumber': serializer.toJson<String>(trackingNumber),
      'number': serializer.toJson<String>(number),
      'deliveryDate': serializer.toJson<DateTime>(deliveryDate),
      'deliveryDateTimeFrom':
          serializer.toJson<DateTime?>(deliveryDateTimeFrom),
      'deliveryDateTimeTo': serializer.toJson<DateTime?>(deliveryDateTimeTo),
      'statusName': serializer.toJson<String>(statusName),
      'packages': serializer.toJson<int>(packages),
      'weight': serializer.toJson<int?>(weight),
      'volume': serializer.toJson<int?>(volume),
      'deliveryAddressName': serializer.toJson<String>(deliveryAddressName),
      'pickupAddressName': serializer.toJson<String>(pickupAddressName),
      'storageFromId': serializer.toJson<int?>(storageFromId),
      'storageToId': serializer.toJson<int?>(storageToId),
      'storageIssued': serializer.toJson<DateTime?>(storageIssued),
      'storageAccepted': serializer.toJson<DateTime?>(storageAccepted),
      'firstMovementDate': serializer.toJson<DateTime?>(firstMovementDate),
      'delivered': serializer.toJson<DateTime?>(delivered),
      'documentsReturn': serializer.toJson<bool>(documentsReturn),
      'paidSum': serializer.toJson<double>(paidSum),
      'paySum': serializer.toJson<double>(paySum),
    };
  }

  Order copyWith(
          {int? id,
          String? courierName,
          String? trackingNumber,
          String? number,
          DateTime? deliveryDate,
          DateTime? deliveryDateTimeFrom,
          DateTime? deliveryDateTimeTo,
          String? statusName,
          int? packages,
          int? weight,
          int? volume,
          String? deliveryAddressName,
          String? pickupAddressName,
          int? storageFromId,
          int? storageToId,
          DateTime? storageIssued,
          DateTime? storageAccepted,
          DateTime? firstMovementDate,
          DateTime? delivered,
          bool? documentsReturn,
          double? paidSum,
          double? paySum}) =>
      Order(
        id: id ?? this.id,
        courierName: courierName ?? this.courierName,
        trackingNumber: trackingNumber ?? this.trackingNumber,
        number: number ?? this.number,
        deliveryDate: deliveryDate ?? this.deliveryDate,
        deliveryDateTimeFrom: deliveryDateTimeFrom ?? this.deliveryDateTimeFrom,
        deliveryDateTimeTo: deliveryDateTimeTo ?? this.deliveryDateTimeTo,
        statusName: statusName ?? this.statusName,
        packages: packages ?? this.packages,
        weight: weight ?? this.weight,
        volume: volume ?? this.volume,
        deliveryAddressName: deliveryAddressName ?? this.deliveryAddressName,
        pickupAddressName: pickupAddressName ?? this.pickupAddressName,
        storageFromId: storageFromId ?? this.storageFromId,
        storageToId: storageToId ?? this.storageToId,
        storageIssued: storageIssued ?? this.storageIssued,
        storageAccepted: storageAccepted ?? this.storageAccepted,
        firstMovementDate: firstMovementDate ?? this.firstMovementDate,
        delivered: delivered ?? this.delivered,
        documentsReturn: documentsReturn ?? this.documentsReturn,
        paidSum: paidSum ?? this.paidSum,
        paySum: paySum ?? this.paySum,
      );
  @override
  String toString() {
    return (StringBuffer('Order(')
          ..write('id: $id, ')
          ..write('courierName: $courierName, ')
          ..write('trackingNumber: $trackingNumber, ')
          ..write('number: $number, ')
          ..write('deliveryDate: $deliveryDate, ')
          ..write('deliveryDateTimeFrom: $deliveryDateTimeFrom, ')
          ..write('deliveryDateTimeTo: $deliveryDateTimeTo, ')
          ..write('statusName: $statusName, ')
          ..write('packages: $packages, ')
          ..write('weight: $weight, ')
          ..write('volume: $volume, ')
          ..write('deliveryAddressName: $deliveryAddressName, ')
          ..write('pickupAddressName: $pickupAddressName, ')
          ..write('storageFromId: $storageFromId, ')
          ..write('storageToId: $storageToId, ')
          ..write('storageIssued: $storageIssued, ')
          ..write('storageAccepted: $storageAccepted, ')
          ..write('firstMovementDate: $firstMovementDate, ')
          ..write('delivered: $delivered, ')
          ..write('documentsReturn: $documentsReturn, ')
          ..write('paidSum: $paidSum, ')
          ..write('paySum: $paySum')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        courierName,
        trackingNumber,
        number,
        deliveryDate,
        deliveryDateTimeFrom,
        deliveryDateTimeTo,
        statusName,
        packages,
        weight,
        volume,
        deliveryAddressName,
        pickupAddressName,
        storageFromId,
        storageToId,
        storageIssued,
        storageAccepted,
        firstMovementDate,
        delivered,
        documentsReturn,
        paidSum,
        paySum
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Order &&
          other.id == this.id &&
          other.courierName == this.courierName &&
          other.trackingNumber == this.trackingNumber &&
          other.number == this.number &&
          other.deliveryDate == this.deliveryDate &&
          other.deliveryDateTimeFrom == this.deliveryDateTimeFrom &&
          other.deliveryDateTimeTo == this.deliveryDateTimeTo &&
          other.statusName == this.statusName &&
          other.packages == this.packages &&
          other.weight == this.weight &&
          other.volume == this.volume &&
          other.deliveryAddressName == this.deliveryAddressName &&
          other.pickupAddressName == this.pickupAddressName &&
          other.storageFromId == this.storageFromId &&
          other.storageToId == this.storageToId &&
          other.storageIssued == this.storageIssued &&
          other.storageAccepted == this.storageAccepted &&
          other.firstMovementDate == this.firstMovementDate &&
          other.delivered == this.delivered &&
          other.documentsReturn == this.documentsReturn &&
          other.paidSum == this.paidSum &&
          other.paySum == this.paySum);
}

class OrdersCompanion extends UpdateCompanion<Order> {
  final Value<int> id;
  final Value<String?> courierName;
  final Value<String> trackingNumber;
  final Value<String> number;
  final Value<DateTime> deliveryDate;
  final Value<DateTime?> deliveryDateTimeFrom;
  final Value<DateTime?> deliveryDateTimeTo;
  final Value<String> statusName;
  final Value<int> packages;
  final Value<int?> weight;
  final Value<int?> volume;
  final Value<String> deliveryAddressName;
  final Value<String> pickupAddressName;
  final Value<int?> storageFromId;
  final Value<int?> storageToId;
  final Value<DateTime?> storageIssued;
  final Value<DateTime?> storageAccepted;
  final Value<DateTime?> firstMovementDate;
  final Value<DateTime?> delivered;
  final Value<bool> documentsReturn;
  final Value<double> paidSum;
  final Value<double> paySum;
  const OrdersCompanion({
    this.id = const Value.absent(),
    this.courierName = const Value.absent(),
    this.trackingNumber = const Value.absent(),
    this.number = const Value.absent(),
    this.deliveryDate = const Value.absent(),
    this.deliveryDateTimeFrom = const Value.absent(),
    this.deliveryDateTimeTo = const Value.absent(),
    this.statusName = const Value.absent(),
    this.packages = const Value.absent(),
    this.weight = const Value.absent(),
    this.volume = const Value.absent(),
    this.deliveryAddressName = const Value.absent(),
    this.pickupAddressName = const Value.absent(),
    this.storageFromId = const Value.absent(),
    this.storageToId = const Value.absent(),
    this.storageIssued = const Value.absent(),
    this.storageAccepted = const Value.absent(),
    this.firstMovementDate = const Value.absent(),
    this.delivered = const Value.absent(),
    this.documentsReturn = const Value.absent(),
    this.paidSum = const Value.absent(),
    this.paySum = const Value.absent(),
  });
  OrdersCompanion.insert({
    required int id,
    this.courierName = const Value.absent(),
    required String trackingNumber,
    required String number,
    required DateTime deliveryDate,
    this.deliveryDateTimeFrom = const Value.absent(),
    this.deliveryDateTimeTo = const Value.absent(),
    required String statusName,
    required int packages,
    this.weight = const Value.absent(),
    this.volume = const Value.absent(),
    required String deliveryAddressName,
    required String pickupAddressName,
    this.storageFromId = const Value.absent(),
    this.storageToId = const Value.absent(),
    this.storageIssued = const Value.absent(),
    this.storageAccepted = const Value.absent(),
    this.firstMovementDate = const Value.absent(),
    this.delivered = const Value.absent(),
    required bool documentsReturn,
    required double paidSum,
    required double paySum,
  })  : id = Value(id),
        trackingNumber = Value(trackingNumber),
        number = Value(number),
        deliveryDate = Value(deliveryDate),
        statusName = Value(statusName),
        packages = Value(packages),
        deliveryAddressName = Value(deliveryAddressName),
        pickupAddressName = Value(pickupAddressName),
        documentsReturn = Value(documentsReturn),
        paidSum = Value(paidSum),
        paySum = Value(paySum);
  static Insertable<Order> custom({
    Expression<int>? id,
    Expression<String?>? courierName,
    Expression<String>? trackingNumber,
    Expression<String>? number,
    Expression<DateTime>? deliveryDate,
    Expression<DateTime?>? deliveryDateTimeFrom,
    Expression<DateTime?>? deliveryDateTimeTo,
    Expression<String>? statusName,
    Expression<int>? packages,
    Expression<int?>? weight,
    Expression<int?>? volume,
    Expression<String>? deliveryAddressName,
    Expression<String>? pickupAddressName,
    Expression<int?>? storageFromId,
    Expression<int?>? storageToId,
    Expression<DateTime?>? storageIssued,
    Expression<DateTime?>? storageAccepted,
    Expression<DateTime?>? firstMovementDate,
    Expression<DateTime?>? delivered,
    Expression<bool>? documentsReturn,
    Expression<double>? paidSum,
    Expression<double>? paySum,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (courierName != null) 'courier_name': courierName,
      if (trackingNumber != null) 'tracking_number': trackingNumber,
      if (number != null) 'number': number,
      if (deliveryDate != null) 'delivery_date': deliveryDate,
      if (deliveryDateTimeFrom != null)
        'delivery_date_time_from': deliveryDateTimeFrom,
      if (deliveryDateTimeTo != null)
        'delivery_date_time_to': deliveryDateTimeTo,
      if (statusName != null) 'status_name': statusName,
      if (packages != null) 'packages': packages,
      if (weight != null) 'weight': weight,
      if (volume != null) 'volume': volume,
      if (deliveryAddressName != null)
        'delivery_address_name': deliveryAddressName,
      if (pickupAddressName != null) 'pickup_address_name': pickupAddressName,
      if (storageFromId != null) 'storage_from_id': storageFromId,
      if (storageToId != null) 'storage_to_id': storageToId,
      if (storageIssued != null) 'storage_issued': storageIssued,
      if (storageAccepted != null) 'storage_accepted': storageAccepted,
      if (firstMovementDate != null) 'first_movement_date': firstMovementDate,
      if (delivered != null) 'delivered': delivered,
      if (documentsReturn != null) 'documents_return': documentsReturn,
      if (paidSum != null) 'paid_sum': paidSum,
      if (paySum != null) 'pay_sum': paySum,
    });
  }

  OrdersCompanion copyWith(
      {Value<int>? id,
      Value<String?>? courierName,
      Value<String>? trackingNumber,
      Value<String>? number,
      Value<DateTime>? deliveryDate,
      Value<DateTime?>? deliveryDateTimeFrom,
      Value<DateTime?>? deliveryDateTimeTo,
      Value<String>? statusName,
      Value<int>? packages,
      Value<int?>? weight,
      Value<int?>? volume,
      Value<String>? deliveryAddressName,
      Value<String>? pickupAddressName,
      Value<int?>? storageFromId,
      Value<int?>? storageToId,
      Value<DateTime?>? storageIssued,
      Value<DateTime?>? storageAccepted,
      Value<DateTime?>? firstMovementDate,
      Value<DateTime?>? delivered,
      Value<bool>? documentsReturn,
      Value<double>? paidSum,
      Value<double>? paySum}) {
    return OrdersCompanion(
      id: id ?? this.id,
      courierName: courierName ?? this.courierName,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      number: number ?? this.number,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      deliveryDateTimeFrom: deliveryDateTimeFrom ?? this.deliveryDateTimeFrom,
      deliveryDateTimeTo: deliveryDateTimeTo ?? this.deliveryDateTimeTo,
      statusName: statusName ?? this.statusName,
      packages: packages ?? this.packages,
      weight: weight ?? this.weight,
      volume: volume ?? this.volume,
      deliveryAddressName: deliveryAddressName ?? this.deliveryAddressName,
      pickupAddressName: pickupAddressName ?? this.pickupAddressName,
      storageFromId: storageFromId ?? this.storageFromId,
      storageToId: storageToId ?? this.storageToId,
      storageIssued: storageIssued ?? this.storageIssued,
      storageAccepted: storageAccepted ?? this.storageAccepted,
      firstMovementDate: firstMovementDate ?? this.firstMovementDate,
      delivered: delivered ?? this.delivered,
      documentsReturn: documentsReturn ?? this.documentsReturn,
      paidSum: paidSum ?? this.paidSum,
      paySum: paySum ?? this.paySum,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (courierName.present) {
      map['courier_name'] = Variable<String?>(courierName.value);
    }
    if (trackingNumber.present) {
      map['tracking_number'] = Variable<String>(trackingNumber.value);
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    if (deliveryDate.present) {
      map['delivery_date'] = Variable<DateTime>(deliveryDate.value);
    }
    if (deliveryDateTimeFrom.present) {
      map['delivery_date_time_from'] =
          Variable<DateTime?>(deliveryDateTimeFrom.value);
    }
    if (deliveryDateTimeTo.present) {
      map['delivery_date_time_to'] =
          Variable<DateTime?>(deliveryDateTimeTo.value);
    }
    if (statusName.present) {
      map['status_name'] = Variable<String>(statusName.value);
    }
    if (packages.present) {
      map['packages'] = Variable<int>(packages.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int?>(weight.value);
    }
    if (volume.present) {
      map['volume'] = Variable<int?>(volume.value);
    }
    if (deliveryAddressName.present) {
      map['delivery_address_name'] =
          Variable<String>(deliveryAddressName.value);
    }
    if (pickupAddressName.present) {
      map['pickup_address_name'] = Variable<String>(pickupAddressName.value);
    }
    if (storageFromId.present) {
      map['storage_from_id'] = Variable<int?>(storageFromId.value);
    }
    if (storageToId.present) {
      map['storage_to_id'] = Variable<int?>(storageToId.value);
    }
    if (storageIssued.present) {
      map['storage_issued'] = Variable<DateTime?>(storageIssued.value);
    }
    if (storageAccepted.present) {
      map['storage_accepted'] = Variable<DateTime?>(storageAccepted.value);
    }
    if (firstMovementDate.present) {
      map['first_movement_date'] = Variable<DateTime?>(firstMovementDate.value);
    }
    if (delivered.present) {
      map['delivered'] = Variable<DateTime?>(delivered.value);
    }
    if (documentsReturn.present) {
      map['documents_return'] = Variable<bool>(documentsReturn.value);
    }
    if (paidSum.present) {
      map['paid_sum'] = Variable<double>(paidSum.value);
    }
    if (paySum.present) {
      map['pay_sum'] = Variable<double>(paySum.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdersCompanion(')
          ..write('id: $id, ')
          ..write('courierName: $courierName, ')
          ..write('trackingNumber: $trackingNumber, ')
          ..write('number: $number, ')
          ..write('deliveryDate: $deliveryDate, ')
          ..write('deliveryDateTimeFrom: $deliveryDateTimeFrom, ')
          ..write('deliveryDateTimeTo: $deliveryDateTimeTo, ')
          ..write('statusName: $statusName, ')
          ..write('packages: $packages, ')
          ..write('weight: $weight, ')
          ..write('volume: $volume, ')
          ..write('deliveryAddressName: $deliveryAddressName, ')
          ..write('pickupAddressName: $pickupAddressName, ')
          ..write('storageFromId: $storageFromId, ')
          ..write('storageToId: $storageToId, ')
          ..write('storageIssued: $storageIssued, ')
          ..write('storageAccepted: $storageAccepted, ')
          ..write('firstMovementDate: $firstMovementDate, ')
          ..write('delivered: $delivered, ')
          ..write('documentsReturn: $documentsReturn, ')
          ..write('paidSum: $paidSum, ')
          ..write('paySum: $paySum')
          ..write(')'))
        .toString();
  }
}

class $OrdersTable extends Orders with TableInfo<$OrdersTable, Order> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdersTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _courierNameMeta =
      const VerificationMeta('courierName');
  @override
  late final GeneratedColumn<String?> courierName = GeneratedColumn<String?>(
      'courier_name', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _trackingNumberMeta =
      const VerificationMeta('trackingNumber');
  @override
  late final GeneratedColumn<String?> trackingNumber = GeneratedColumn<String?>(
      'tracking_number', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String?> number = GeneratedColumn<String?>(
      'number', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _deliveryDateMeta =
      const VerificationMeta('deliveryDate');
  @override
  late final GeneratedColumn<DateTime?> deliveryDate =
      GeneratedColumn<DateTime?>('delivery_date', aliasedName, false,
          type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _deliveryDateTimeFromMeta =
      const VerificationMeta('deliveryDateTimeFrom');
  @override
  late final GeneratedColumn<DateTime?> deliveryDateTimeFrom =
      GeneratedColumn<DateTime?>('delivery_date_time_from', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _deliveryDateTimeToMeta =
      const VerificationMeta('deliveryDateTimeTo');
  @override
  late final GeneratedColumn<DateTime?> deliveryDateTimeTo =
      GeneratedColumn<DateTime?>('delivery_date_time_to', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _statusNameMeta = const VerificationMeta('statusName');
  @override
  late final GeneratedColumn<String?> statusName = GeneratedColumn<String?>(
      'status_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _packagesMeta = const VerificationMeta('packages');
  @override
  late final GeneratedColumn<int?> packages = GeneratedColumn<int?>(
      'packages', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int?> weight = GeneratedColumn<int?>(
      'weight', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _volumeMeta = const VerificationMeta('volume');
  @override
  late final GeneratedColumn<int?> volume = GeneratedColumn<int?>(
      'volume', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _deliveryAddressNameMeta =
      const VerificationMeta('deliveryAddressName');
  @override
  late final GeneratedColumn<String?> deliveryAddressName =
      GeneratedColumn<String?>('delivery_address_name', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _pickupAddressNameMeta =
      const VerificationMeta('pickupAddressName');
  @override
  late final GeneratedColumn<String?> pickupAddressName =
      GeneratedColumn<String?>('pickup_address_name', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _storageFromIdMeta =
      const VerificationMeta('storageFromId');
  @override
  late final GeneratedColumn<int?> storageFromId = GeneratedColumn<int?>(
      'storage_from_id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES order_storages (id)');
  final VerificationMeta _storageToIdMeta =
      const VerificationMeta('storageToId');
  @override
  late final GeneratedColumn<int?> storageToId = GeneratedColumn<int?>(
      'storage_to_id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES order_storages (id)');
  final VerificationMeta _storageIssuedMeta =
      const VerificationMeta('storageIssued');
  @override
  late final GeneratedColumn<DateTime?> storageIssued =
      GeneratedColumn<DateTime?>('storage_issued', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _storageAcceptedMeta =
      const VerificationMeta('storageAccepted');
  @override
  late final GeneratedColumn<DateTime?> storageAccepted =
      GeneratedColumn<DateTime?>('storage_accepted', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _firstMovementDateMeta =
      const VerificationMeta('firstMovementDate');
  @override
  late final GeneratedColumn<DateTime?> firstMovementDate =
      GeneratedColumn<DateTime?>('first_movement_date', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _deliveredMeta = const VerificationMeta('delivered');
  @override
  late final GeneratedColumn<DateTime?> delivered = GeneratedColumn<DateTime?>(
      'delivered', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _documentsReturnMeta =
      const VerificationMeta('documentsReturn');
  @override
  late final GeneratedColumn<bool?> documentsReturn = GeneratedColumn<bool?>(
      'documents_return', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (documents_return IN (0, 1))');
  final VerificationMeta _paidSumMeta = const VerificationMeta('paidSum');
  @override
  late final GeneratedColumn<double?> paidSum = GeneratedColumn<double?>(
      'paid_sum', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _paySumMeta = const VerificationMeta('paySum');
  @override
  late final GeneratedColumn<double?> paySum = GeneratedColumn<double?>(
      'pay_sum', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        courierName,
        trackingNumber,
        number,
        deliveryDate,
        deliveryDateTimeFrom,
        deliveryDateTimeTo,
        statusName,
        packages,
        weight,
        volume,
        deliveryAddressName,
        pickupAddressName,
        storageFromId,
        storageToId,
        storageIssued,
        storageAccepted,
        firstMovementDate,
        delivered,
        documentsReturn,
        paidSum,
        paySum
      ];
  @override
  String get aliasedName => _alias ?? 'orders';
  @override
  String get actualTableName => 'orders';
  @override
  VerificationContext validateIntegrity(Insertable<Order> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('courier_name')) {
      context.handle(
          _courierNameMeta,
          courierName.isAcceptableOrUnknown(
              data['courier_name']!, _courierNameMeta));
    }
    if (data.containsKey('tracking_number')) {
      context.handle(
          _trackingNumberMeta,
          trackingNumber.isAcceptableOrUnknown(
              data['tracking_number']!, _trackingNumberMeta));
    } else if (isInserting) {
      context.missing(_trackingNumberMeta);
    }
    if (data.containsKey('number')) {
      context.handle(_numberMeta,
          number.isAcceptableOrUnknown(data['number']!, _numberMeta));
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('delivery_date')) {
      context.handle(
          _deliveryDateMeta,
          deliveryDate.isAcceptableOrUnknown(
              data['delivery_date']!, _deliveryDateMeta));
    } else if (isInserting) {
      context.missing(_deliveryDateMeta);
    }
    if (data.containsKey('delivery_date_time_from')) {
      context.handle(
          _deliveryDateTimeFromMeta,
          deliveryDateTimeFrom.isAcceptableOrUnknown(
              data['delivery_date_time_from']!, _deliveryDateTimeFromMeta));
    }
    if (data.containsKey('delivery_date_time_to')) {
      context.handle(
          _deliveryDateTimeToMeta,
          deliveryDateTimeTo.isAcceptableOrUnknown(
              data['delivery_date_time_to']!, _deliveryDateTimeToMeta));
    }
    if (data.containsKey('status_name')) {
      context.handle(
          _statusNameMeta,
          statusName.isAcceptableOrUnknown(
              data['status_name']!, _statusNameMeta));
    } else if (isInserting) {
      context.missing(_statusNameMeta);
    }
    if (data.containsKey('packages')) {
      context.handle(_packagesMeta,
          packages.isAcceptableOrUnknown(data['packages']!, _packagesMeta));
    } else if (isInserting) {
      context.missing(_packagesMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    if (data.containsKey('volume')) {
      context.handle(_volumeMeta,
          volume.isAcceptableOrUnknown(data['volume']!, _volumeMeta));
    }
    if (data.containsKey('delivery_address_name')) {
      context.handle(
          _deliveryAddressNameMeta,
          deliveryAddressName.isAcceptableOrUnknown(
              data['delivery_address_name']!, _deliveryAddressNameMeta));
    } else if (isInserting) {
      context.missing(_deliveryAddressNameMeta);
    }
    if (data.containsKey('pickup_address_name')) {
      context.handle(
          _pickupAddressNameMeta,
          pickupAddressName.isAcceptableOrUnknown(
              data['pickup_address_name']!, _pickupAddressNameMeta));
    } else if (isInserting) {
      context.missing(_pickupAddressNameMeta);
    }
    if (data.containsKey('storage_from_id')) {
      context.handle(
          _storageFromIdMeta,
          storageFromId.isAcceptableOrUnknown(
              data['storage_from_id']!, _storageFromIdMeta));
    }
    if (data.containsKey('storage_to_id')) {
      context.handle(
          _storageToIdMeta,
          storageToId.isAcceptableOrUnknown(
              data['storage_to_id']!, _storageToIdMeta));
    }
    if (data.containsKey('storage_issued')) {
      context.handle(
          _storageIssuedMeta,
          storageIssued.isAcceptableOrUnknown(
              data['storage_issued']!, _storageIssuedMeta));
    }
    if (data.containsKey('storage_accepted')) {
      context.handle(
          _storageAcceptedMeta,
          storageAccepted.isAcceptableOrUnknown(
              data['storage_accepted']!, _storageAcceptedMeta));
    }
    if (data.containsKey('first_movement_date')) {
      context.handle(
          _firstMovementDateMeta,
          firstMovementDate.isAcceptableOrUnknown(
              data['first_movement_date']!, _firstMovementDateMeta));
    }
    if (data.containsKey('delivered')) {
      context.handle(_deliveredMeta,
          delivered.isAcceptableOrUnknown(data['delivered']!, _deliveredMeta));
    }
    if (data.containsKey('documents_return')) {
      context.handle(
          _documentsReturnMeta,
          documentsReturn.isAcceptableOrUnknown(
              data['documents_return']!, _documentsReturnMeta));
    } else if (isInserting) {
      context.missing(_documentsReturnMeta);
    }
    if (data.containsKey('paid_sum')) {
      context.handle(_paidSumMeta,
          paidSum.isAcceptableOrUnknown(data['paid_sum']!, _paidSumMeta));
    } else if (isInserting) {
      context.missing(_paidSumMeta);
    }
    if (data.containsKey('pay_sum')) {
      context.handle(_paySumMeta,
          paySum.isAcceptableOrUnknown(data['pay_sum']!, _paySumMeta));
    } else if (isInserting) {
      context.missing(_paySumMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Order map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Order.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $OrdersTable createAlias(String alias) {
    return $OrdersTable(attachedDatabase, alias);
  }
}

class OrderLine extends DataClass implements Insertable<OrderLine> {
  final int id;
  final int orderId;
  final String name;
  final int amount;
  final double price;
  final int? factAmount;
  OrderLine(
      {required this.id,
      required this.orderId,
      required this.name,
      required this.amount,
      required this.price,
      this.factAmount});
  factory OrderLine.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return OrderLine(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      orderId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}order_id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      amount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount'])!,
      price: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}price'])!,
      factAmount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}fact_amount']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['order_id'] = Variable<int>(orderId);
    map['name'] = Variable<String>(name);
    map['amount'] = Variable<int>(amount);
    map['price'] = Variable<double>(price);
    if (!nullToAbsent || factAmount != null) {
      map['fact_amount'] = Variable<int?>(factAmount);
    }
    return map;
  }

  OrderLinesCompanion toCompanion(bool nullToAbsent) {
    return OrderLinesCompanion(
      id: Value(id),
      orderId: Value(orderId),
      name: Value(name),
      amount: Value(amount),
      price: Value(price),
      factAmount: factAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(factAmount),
    );
  }

  factory OrderLine.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderLine(
      id: serializer.fromJson<int>(json['id']),
      orderId: serializer.fromJson<int>(json['orderId']),
      name: serializer.fromJson<String>(json['name']),
      amount: serializer.fromJson<int>(json['amount']),
      price: serializer.fromJson<double>(json['price']),
      factAmount: serializer.fromJson<int?>(json['factAmount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'orderId': serializer.toJson<int>(orderId),
      'name': serializer.toJson<String>(name),
      'amount': serializer.toJson<int>(amount),
      'price': serializer.toJson<double>(price),
      'factAmount': serializer.toJson<int?>(factAmount),
    };
  }

  OrderLine copyWith(
          {int? id,
          int? orderId,
          String? name,
          int? amount,
          double? price,
          int? factAmount}) =>
      OrderLine(
        id: id ?? this.id,
        orderId: orderId ?? this.orderId,
        name: name ?? this.name,
        amount: amount ?? this.amount,
        price: price ?? this.price,
        factAmount: factAmount ?? this.factAmount,
      );
  @override
  String toString() {
    return (StringBuffer('OrderLine(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('price: $price, ')
          ..write('factAmount: $factAmount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, orderId, name, amount, price, factAmount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderLine &&
          other.id == this.id &&
          other.orderId == this.orderId &&
          other.name == this.name &&
          other.amount == this.amount &&
          other.price == this.price &&
          other.factAmount == this.factAmount);
}

class OrderLinesCompanion extends UpdateCompanion<OrderLine> {
  final Value<int> id;
  final Value<int> orderId;
  final Value<String> name;
  final Value<int> amount;
  final Value<double> price;
  final Value<int?> factAmount;
  const OrderLinesCompanion({
    this.id = const Value.absent(),
    this.orderId = const Value.absent(),
    this.name = const Value.absent(),
    this.amount = const Value.absent(),
    this.price = const Value.absent(),
    this.factAmount = const Value.absent(),
  });
  OrderLinesCompanion.insert({
    this.id = const Value.absent(),
    required int orderId,
    required String name,
    required int amount,
    required double price,
    this.factAmount = const Value.absent(),
  })  : orderId = Value(orderId),
        name = Value(name),
        amount = Value(amount),
        price = Value(price);
  static Insertable<OrderLine> custom({
    Expression<int>? id,
    Expression<int>? orderId,
    Expression<String>? name,
    Expression<int>? amount,
    Expression<double>? price,
    Expression<int?>? factAmount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      if (name != null) 'name': name,
      if (amount != null) 'amount': amount,
      if (price != null) 'price': price,
      if (factAmount != null) 'fact_amount': factAmount,
    });
  }

  OrderLinesCompanion copyWith(
      {Value<int>? id,
      Value<int>? orderId,
      Value<String>? name,
      Value<int>? amount,
      Value<double>? price,
      Value<int?>? factAmount}) {
    return OrderLinesCompanion(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      price: price ?? this.price,
      factAmount: factAmount ?? this.factAmount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (factAmount.present) {
      map['fact_amount'] = Variable<int?>(factAmount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrderLinesCompanion(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('price: $price, ')
          ..write('factAmount: $factAmount')
          ..write(')'))
        .toString();
  }
}

class $OrderLinesTable extends OrderLines
    with TableInfo<$OrderLinesTable, OrderLine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrderLinesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _orderIdMeta = const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<int?> orderId = GeneratedColumn<int?>(
      'order_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES orders (id)');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int?> amount = GeneratedColumn<int?>(
      'amount', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double?> price = GeneratedColumn<double?>(
      'price', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _factAmountMeta = const VerificationMeta('factAmount');
  @override
  late final GeneratedColumn<int?> factAmount = GeneratedColumn<int?>(
      'fact_amount', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, orderId, name, amount, price, factAmount];
  @override
  String get aliasedName => _alias ?? 'order_lines';
  @override
  String get actualTableName => 'order_lines';
  @override
  VerificationContext validateIntegrity(Insertable<OrderLine> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('fact_amount')) {
      context.handle(
          _factAmountMeta,
          factAmount.isAcceptableOrUnknown(
              data['fact_amount']!, _factAmountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrderLine map(Map<String, dynamic> data, {String? tablePrefix}) {
    return OrderLine.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $OrderLinesTable createAlias(String alias) {
    return $OrderLinesTable(attachedDatabase, alias);
  }
}

class ApiCredential extends DataClass implements Insertable<ApiCredential> {
  final String accessToken;
  final String refreshToken;
  final String url;
  ApiCredential(
      {required this.accessToken,
      required this.refreshToken,
      required this.url});
  factory ApiCredential.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ApiCredential(
      accessToken: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}access_token'])!,
      refreshToken: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}refresh_token'])!,
      url: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}url'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['access_token'] = Variable<String>(accessToken);
    map['refresh_token'] = Variable<String>(refreshToken);
    map['url'] = Variable<String>(url);
    return map;
  }

  ApiCredentialsCompanion toCompanion(bool nullToAbsent) {
    return ApiCredentialsCompanion(
      accessToken: Value(accessToken),
      refreshToken: Value(refreshToken),
      url: Value(url),
    );
  }

  factory ApiCredential.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ApiCredential(
      accessToken: serializer.fromJson<String>(json['accessToken']),
      refreshToken: serializer.fromJson<String>(json['refreshToken']),
      url: serializer.fromJson<String>(json['url']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'accessToken': serializer.toJson<String>(accessToken),
      'refreshToken': serializer.toJson<String>(refreshToken),
      'url': serializer.toJson<String>(url),
    };
  }

  ApiCredential copyWith(
          {String? accessToken, String? refreshToken, String? url}) =>
      ApiCredential(
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
        url: url ?? this.url,
      );
  @override
  String toString() {
    return (StringBuffer('ApiCredential(')
          ..write('accessToken: $accessToken, ')
          ..write('refreshToken: $refreshToken, ')
          ..write('url: $url')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(accessToken, refreshToken, url);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ApiCredential &&
          other.accessToken == this.accessToken &&
          other.refreshToken == this.refreshToken &&
          other.url == this.url);
}

class ApiCredentialsCompanion extends UpdateCompanion<ApiCredential> {
  final Value<String> accessToken;
  final Value<String> refreshToken;
  final Value<String> url;
  const ApiCredentialsCompanion({
    this.accessToken = const Value.absent(),
    this.refreshToken = const Value.absent(),
    this.url = const Value.absent(),
  });
  ApiCredentialsCompanion.insert({
    required String accessToken,
    required String refreshToken,
    required String url,
  })  : accessToken = Value(accessToken),
        refreshToken = Value(refreshToken),
        url = Value(url);
  static Insertable<ApiCredential> custom({
    Expression<String>? accessToken,
    Expression<String>? refreshToken,
    Expression<String>? url,
  }) {
    return RawValuesInsertable({
      if (accessToken != null) 'access_token': accessToken,
      if (refreshToken != null) 'refresh_token': refreshToken,
      if (url != null) 'url': url,
    });
  }

  ApiCredentialsCompanion copyWith(
      {Value<String>? accessToken,
      Value<String>? refreshToken,
      Value<String>? url}) {
    return ApiCredentialsCompanion(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      url: url ?? this.url,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (accessToken.present) {
      map['access_token'] = Variable<String>(accessToken.value);
    }
    if (refreshToken.present) {
      map['refresh_token'] = Variable<String>(refreshToken.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ApiCredentialsCompanion(')
          ..write('accessToken: $accessToken, ')
          ..write('refreshToken: $refreshToken, ')
          ..write('url: $url')
          ..write(')'))
        .toString();
  }
}

class $ApiCredentialsTable extends ApiCredentials
    with TableInfo<$ApiCredentialsTable, ApiCredential> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ApiCredentialsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _accessTokenMeta =
      const VerificationMeta('accessToken');
  @override
  late final GeneratedColumn<String?> accessToken = GeneratedColumn<String?>(
      'access_token', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _refreshTokenMeta =
      const VerificationMeta('refreshToken');
  @override
  late final GeneratedColumn<String?> refreshToken = GeneratedColumn<String?>(
      'refresh_token', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String?> url = GeneratedColumn<String?>(
      'url', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [accessToken, refreshToken, url];
  @override
  String get aliasedName => _alias ?? 'api_credentials';
  @override
  String get actualTableName => 'api_credentials';
  @override
  VerificationContext validateIntegrity(Insertable<ApiCredential> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('access_token')) {
      context.handle(
          _accessTokenMeta,
          accessToken.isAcceptableOrUnknown(
              data['access_token']!, _accessTokenMeta));
    } else if (isInserting) {
      context.missing(_accessTokenMeta);
    }
    if (data.containsKey('refresh_token')) {
      context.handle(
          _refreshTokenMeta,
          refreshToken.isAcceptableOrUnknown(
              data['refresh_token']!, _refreshTokenMeta));
    } else if (isInserting) {
      context.missing(_refreshTokenMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  ApiCredential map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ApiCredential.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ApiCredentialsTable createAlias(String alias) {
    return $ApiCredentialsTable(attachedDatabase, alias);
  }
}

class Pref extends DataClass implements Insertable<Pref> {
  final DateTime? lastLogin;
  Pref({this.lastLogin});
  factory Pref.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Pref(
      lastLogin: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_login']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || lastLogin != null) {
      map['last_login'] = Variable<DateTime?>(lastLogin);
    }
    return map;
  }

  PrefsCompanion toCompanion(bool nullToAbsent) {
    return PrefsCompanion(
      lastLogin: lastLogin == null && nullToAbsent
          ? const Value.absent()
          : Value(lastLogin),
    );
  }

  factory Pref.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pref(
      lastLogin: serializer.fromJson<DateTime?>(json['lastLogin']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'lastLogin': serializer.toJson<DateTime?>(lastLogin),
    };
  }

  Pref copyWith({DateTime? lastLogin}) => Pref(
        lastLogin: lastLogin ?? this.lastLogin,
      );
  @override
  String toString() {
    return (StringBuffer('Pref(')
          ..write('lastLogin: $lastLogin')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => lastLogin.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pref && other.lastLogin == this.lastLogin);
}

class PrefsCompanion extends UpdateCompanion<Pref> {
  final Value<DateTime?> lastLogin;
  const PrefsCompanion({
    this.lastLogin = const Value.absent(),
  });
  PrefsCompanion.insert({
    this.lastLogin = const Value.absent(),
  });
  static Insertable<Pref> custom({
    Expression<DateTime?>? lastLogin,
  }) {
    return RawValuesInsertable({
      if (lastLogin != null) 'last_login': lastLogin,
    });
  }

  PrefsCompanion copyWith({Value<DateTime?>? lastLogin}) {
    return PrefsCompanion(
      lastLogin: lastLogin ?? this.lastLogin,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (lastLogin.present) {
      map['last_login'] = Variable<DateTime?>(lastLogin.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrefsCompanion(')
          ..write('lastLogin: $lastLogin')
          ..write(')'))
        .toString();
  }
}

class $PrefsTable extends Prefs with TableInfo<$PrefsTable, Pref> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrefsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _lastLoginMeta = const VerificationMeta('lastLogin');
  @override
  late final GeneratedColumn<DateTime?> lastLogin = GeneratedColumn<DateTime?>(
      'last_login', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [lastLogin];
  @override
  String get aliasedName => _alias ?? 'prefs';
  @override
  String get actualTableName => 'prefs';
  @override
  VerificationContext validateIntegrity(Insertable<Pref> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('last_login')) {
      context.handle(_lastLoginMeta,
          lastLogin.isAcceptableOrUnknown(data['last_login']!, _lastLoginMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Pref map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Pref.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PrefsTable createAlias(String alias) {
    return $PrefsTable(attachedDatabase, alias);
  }
}

abstract class _$AppStorage extends GeneratedDatabase {
  _$AppStorage(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $UsersTable users = $UsersTable(this);
  late final $OrderStoragesTable orderStorages = $OrderStoragesTable(this);
  late final $OrdersTable orders = $OrdersTable(this);
  late final $OrderLinesTable orderLines = $OrderLinesTable(this);
  late final $ApiCredentialsTable apiCredentials = $ApiCredentialsTable(this);
  late final $PrefsTable prefs = $PrefsTable(this);
  late final ApiCredentialsDao apiCredentialsDao =
      ApiCredentialsDao(this as AppStorage);
  late final OrderStoragesDao orderStoragesDao =
      OrderStoragesDao(this as AppStorage);
  late final OrdersDao ordersDao = OrdersDao(this as AppStorage);
  late final UsersDao usersDao = UsersDao(this as AppStorage);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [users, orderStorages, orders, orderLines, apiCredentials, prefs];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$ApiCredentialsDaoMixin on DatabaseAccessor<AppStorage> {
  $ApiCredentialsTable get apiCredentials => attachedDatabase.apiCredentials;
}
mixin _$OrderStoragesDaoMixin on DatabaseAccessor<AppStorage> {
  $OrderStoragesTable get orderStorages => attachedDatabase.orderStorages;
}
mixin _$OrdersDaoMixin on DatabaseAccessor<AppStorage> {
  $OrderStoragesTable get orderStorages => attachedDatabase.orderStorages;
  $OrdersTable get orders => attachedDatabase.orders;
  $OrderLinesTable get orderLines => attachedDatabase.orderLines;
}
mixin _$UsersDaoMixin on DatabaseAccessor<AppStorage> {
  $UsersTable get users => attachedDatabase.users;
}
