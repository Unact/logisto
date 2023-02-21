// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
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

class Product extends DataClass implements Insertable<Product> {
  final int id;
  final String name;
  final String? article;
  final String? barcodeCode;
  final String? barcodeType;
  Product(
      {required this.id,
      required this.name,
      this.article,
      this.barcodeCode,
      this.barcodeType});
  factory Product.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Product(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      article: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}article']),
      barcodeCode: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}barcode_code']),
      barcodeType: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}barcode_type']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || article != null) {
      map['article'] = Variable<String?>(article);
    }
    if (!nullToAbsent || barcodeCode != null) {
      map['barcode_code'] = Variable<String?>(barcodeCode);
    }
    if (!nullToAbsent || barcodeType != null) {
      map['barcode_type'] = Variable<String?>(barcodeType);
    }
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      name: Value(name),
      article: article == null && nullToAbsent
          ? const Value.absent()
          : Value(article),
      barcodeCode: barcodeCode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcodeCode),
      barcodeType: barcodeType == null && nullToAbsent
          ? const Value.absent()
          : Value(barcodeType),
    );
  }

  factory Product.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      article: serializer.fromJson<String?>(json['article']),
      barcodeCode: serializer.fromJson<String?>(json['barcodeCode']),
      barcodeType: serializer.fromJson<String?>(json['barcodeType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'article': serializer.toJson<String?>(article),
      'barcodeCode': serializer.toJson<String?>(barcodeCode),
      'barcodeType': serializer.toJson<String?>(barcodeType),
    };
  }

  Product copyWith(
          {int? id,
          String? name,
          String? article,
          String? barcodeCode,
          String? barcodeType}) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        article: article ?? this.article,
        barcodeCode: barcodeCode ?? this.barcodeCode,
        barcodeType: barcodeType ?? this.barcodeType,
      );
  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('article: $article, ')
          ..write('barcodeCode: $barcodeCode, ')
          ..write('barcodeType: $barcodeType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, article, barcodeCode, barcodeType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.name == this.name &&
          other.article == this.article &&
          other.barcodeCode == this.barcodeCode &&
          other.barcodeType == this.barcodeType);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> article;
  final Value<String?> barcodeCode;
  final Value<String?> barcodeType;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.article = const Value.absent(),
    this.barcodeCode = const Value.absent(),
    this.barcodeType = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.article = const Value.absent(),
    this.barcodeCode = const Value.absent(),
    this.barcodeType = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Product> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String?>? article,
    Expression<String?>? barcodeCode,
    Expression<String?>? barcodeType,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (article != null) 'article': article,
      if (barcodeCode != null) 'barcode_code': barcodeCode,
      if (barcodeType != null) 'barcode_type': barcodeType,
    });
  }

  ProductsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? article,
      Value<String?>? barcodeCode,
      Value<String?>? barcodeType}) {
    return ProductsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      article: article ?? this.article,
      barcodeCode: barcodeCode ?? this.barcodeCode,
      barcodeType: barcodeType ?? this.barcodeType,
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
    if (article.present) {
      map['article'] = Variable<String?>(article.value);
    }
    if (barcodeCode.present) {
      map['barcode_code'] = Variable<String?>(barcodeCode.value);
    }
    if (barcodeType.present) {
      map['barcode_type'] = Variable<String?>(barcodeType.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('article: $article, ')
          ..write('barcodeCode: $barcodeCode, ')
          ..write('barcodeType: $barcodeType')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
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
  final VerificationMeta _articleMeta = const VerificationMeta('article');
  @override
  late final GeneratedColumn<String?> article = GeneratedColumn<String?>(
      'article', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _barcodeCodeMeta =
      const VerificationMeta('barcodeCode');
  @override
  late final GeneratedColumn<String?> barcodeCode = GeneratedColumn<String?>(
      'barcode_code', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _barcodeTypeMeta =
      const VerificationMeta('barcodeType');
  @override
  late final GeneratedColumn<String?> barcodeType = GeneratedColumn<String?>(
      'barcode_type', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, article, barcodeCode, barcodeType];
  @override
  String get aliasedName => _alias ?? 'products';
  @override
  String get actualTableName => 'products';
  @override
  VerificationContext validateIntegrity(Insertable<Product> instance,
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
    if (data.containsKey('article')) {
      context.handle(_articleMeta,
          article.isAcceptableOrUnknown(data['article']!, _articleMeta));
    }
    if (data.containsKey('barcode_code')) {
      context.handle(
          _barcodeCodeMeta,
          barcodeCode.isAcceptableOrUnknown(
              data['barcode_code']!, _barcodeCodeMeta));
    }
    if (data.containsKey('barcode_type')) {
      context.handle(
          _barcodeTypeMeta,
          barcodeType.isAcceptableOrUnknown(
              data['barcode_type']!, _barcodeTypeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Product.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Storage extends DataClass implements Insertable<Storage> {
  final int id;
  final String name;
  final int sequenceNumber;
  Storage({required this.id, required this.name, required this.sequenceNumber});
  factory Storage.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Storage(
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

  StoragesCompanion toCompanion(bool nullToAbsent) {
    return StoragesCompanion(
      id: Value(id),
      name: Value(name),
      sequenceNumber: Value(sequenceNumber),
    );
  }

  factory Storage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Storage(
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

  Storage copyWith({int? id, String? name, int? sequenceNumber}) => Storage(
        id: id ?? this.id,
        name: name ?? this.name,
        sequenceNumber: sequenceNumber ?? this.sequenceNumber,
      );
  @override
  String toString() {
    return (StringBuffer('Storage(')
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
      (other is Storage &&
          other.id == this.id &&
          other.name == this.name &&
          other.sequenceNumber == this.sequenceNumber);
}

class StoragesCompanion extends UpdateCompanion<Storage> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> sequenceNumber;
  const StoragesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.sequenceNumber = const Value.absent(),
  });
  StoragesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int sequenceNumber,
  })  : name = Value(name),
        sequenceNumber = Value(sequenceNumber);
  static Insertable<Storage> custom({
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

  StoragesCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<int>? sequenceNumber}) {
    return StoragesCompanion(
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
    return (StringBuffer('StoragesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sequenceNumber: $sequenceNumber')
          ..write(')'))
        .toString();
  }
}

class $StoragesTable extends Storages with TableInfo<$StoragesTable, Storage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StoragesTable(this.attachedDatabase, [this._alias]);
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
  String get aliasedName => _alias ?? 'storages';
  @override
  String get actualTableName => 'storages';
  @override
  VerificationContext validateIntegrity(Insertable<Storage> instance,
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
  Storage map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Storage.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $StoragesTable createAlias(String alias) {
    return $StoragesTable(attachedDatabase, alias);
  }
}

class ProductArrival extends DataClass implements Insertable<ProductArrival> {
  final int id;
  final DateTime arrivalDate;
  final String number;
  final DateTime? unloadStart;
  final DateTime? unloadEnd;
  final int? storageId;
  final String storeName;
  final String sellerName;
  final String statusName;
  final String? orderTrackingNumber;
  final String? comment;
  ProductArrival(
      {required this.id,
      required this.arrivalDate,
      required this.number,
      this.unloadStart,
      this.unloadEnd,
      this.storageId,
      required this.storeName,
      required this.sellerName,
      required this.statusName,
      this.orderTrackingNumber,
      this.comment});
  factory ProductArrival.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ProductArrival(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      arrivalDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}arrival_date'])!,
      number: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}number'])!,
      unloadStart: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}unload_start']),
      unloadEnd: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}unload_end']),
      storageId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}storage_id']),
      storeName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}store_name'])!,
      sellerName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}seller_name'])!,
      statusName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}status_name'])!,
      orderTrackingNumber: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}order_tracking_number']),
      comment: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}comment']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['arrival_date'] = Variable<DateTime>(arrivalDate);
    map['number'] = Variable<String>(number);
    if (!nullToAbsent || unloadStart != null) {
      map['unload_start'] = Variable<DateTime?>(unloadStart);
    }
    if (!nullToAbsent || unloadEnd != null) {
      map['unload_end'] = Variable<DateTime?>(unloadEnd);
    }
    if (!nullToAbsent || storageId != null) {
      map['storage_id'] = Variable<int?>(storageId);
    }
    map['store_name'] = Variable<String>(storeName);
    map['seller_name'] = Variable<String>(sellerName);
    map['status_name'] = Variable<String>(statusName);
    if (!nullToAbsent || orderTrackingNumber != null) {
      map['order_tracking_number'] = Variable<String?>(orderTrackingNumber);
    }
    if (!nullToAbsent || comment != null) {
      map['comment'] = Variable<String?>(comment);
    }
    return map;
  }

  ProductArrivalsCompanion toCompanion(bool nullToAbsent) {
    return ProductArrivalsCompanion(
      id: Value(id),
      arrivalDate: Value(arrivalDate),
      number: Value(number),
      unloadStart: unloadStart == null && nullToAbsent
          ? const Value.absent()
          : Value(unloadStart),
      unloadEnd: unloadEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(unloadEnd),
      storageId: storageId == null && nullToAbsent
          ? const Value.absent()
          : Value(storageId),
      storeName: Value(storeName),
      sellerName: Value(sellerName),
      statusName: Value(statusName),
      orderTrackingNumber: orderTrackingNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(orderTrackingNumber),
      comment: comment == null && nullToAbsent
          ? const Value.absent()
          : Value(comment),
    );
  }

  factory ProductArrival.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductArrival(
      id: serializer.fromJson<int>(json['id']),
      arrivalDate: serializer.fromJson<DateTime>(json['arrivalDate']),
      number: serializer.fromJson<String>(json['number']),
      unloadStart: serializer.fromJson<DateTime?>(json['unloadStart']),
      unloadEnd: serializer.fromJson<DateTime?>(json['unloadEnd']),
      storageId: serializer.fromJson<int?>(json['storageId']),
      storeName: serializer.fromJson<String>(json['storeName']),
      sellerName: serializer.fromJson<String>(json['sellerName']),
      statusName: serializer.fromJson<String>(json['statusName']),
      orderTrackingNumber:
          serializer.fromJson<String?>(json['orderTrackingNumber']),
      comment: serializer.fromJson<String?>(json['comment']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'arrivalDate': serializer.toJson<DateTime>(arrivalDate),
      'number': serializer.toJson<String>(number),
      'unloadStart': serializer.toJson<DateTime?>(unloadStart),
      'unloadEnd': serializer.toJson<DateTime?>(unloadEnd),
      'storageId': serializer.toJson<int?>(storageId),
      'storeName': serializer.toJson<String>(storeName),
      'sellerName': serializer.toJson<String>(sellerName),
      'statusName': serializer.toJson<String>(statusName),
      'orderTrackingNumber': serializer.toJson<String?>(orderTrackingNumber),
      'comment': serializer.toJson<String?>(comment),
    };
  }

  ProductArrival copyWith(
          {int? id,
          DateTime? arrivalDate,
          String? number,
          DateTime? unloadStart,
          DateTime? unloadEnd,
          int? storageId,
          String? storeName,
          String? sellerName,
          String? statusName,
          String? orderTrackingNumber,
          String? comment}) =>
      ProductArrival(
        id: id ?? this.id,
        arrivalDate: arrivalDate ?? this.arrivalDate,
        number: number ?? this.number,
        unloadStart: unloadStart ?? this.unloadStart,
        unloadEnd: unloadEnd ?? this.unloadEnd,
        storageId: storageId ?? this.storageId,
        storeName: storeName ?? this.storeName,
        sellerName: sellerName ?? this.sellerName,
        statusName: statusName ?? this.statusName,
        orderTrackingNumber: orderTrackingNumber ?? this.orderTrackingNumber,
        comment: comment ?? this.comment,
      );
  @override
  String toString() {
    return (StringBuffer('ProductArrival(')
          ..write('id: $id, ')
          ..write('arrivalDate: $arrivalDate, ')
          ..write('number: $number, ')
          ..write('unloadStart: $unloadStart, ')
          ..write('unloadEnd: $unloadEnd, ')
          ..write('storageId: $storageId, ')
          ..write('storeName: $storeName, ')
          ..write('sellerName: $sellerName, ')
          ..write('statusName: $statusName, ')
          ..write('orderTrackingNumber: $orderTrackingNumber, ')
          ..write('comment: $comment')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      arrivalDate,
      number,
      unloadStart,
      unloadEnd,
      storageId,
      storeName,
      sellerName,
      statusName,
      orderTrackingNumber,
      comment);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductArrival &&
          other.id == this.id &&
          other.arrivalDate == this.arrivalDate &&
          other.number == this.number &&
          other.unloadStart == this.unloadStart &&
          other.unloadEnd == this.unloadEnd &&
          other.storageId == this.storageId &&
          other.storeName == this.storeName &&
          other.sellerName == this.sellerName &&
          other.statusName == this.statusName &&
          other.orderTrackingNumber == this.orderTrackingNumber &&
          other.comment == this.comment);
}

class ProductArrivalsCompanion extends UpdateCompanion<ProductArrival> {
  final Value<int> id;
  final Value<DateTime> arrivalDate;
  final Value<String> number;
  final Value<DateTime?> unloadStart;
  final Value<DateTime?> unloadEnd;
  final Value<int?> storageId;
  final Value<String> storeName;
  final Value<String> sellerName;
  final Value<String> statusName;
  final Value<String?> orderTrackingNumber;
  final Value<String?> comment;
  const ProductArrivalsCompanion({
    this.id = const Value.absent(),
    this.arrivalDate = const Value.absent(),
    this.number = const Value.absent(),
    this.unloadStart = const Value.absent(),
    this.unloadEnd = const Value.absent(),
    this.storageId = const Value.absent(),
    this.storeName = const Value.absent(),
    this.sellerName = const Value.absent(),
    this.statusName = const Value.absent(),
    this.orderTrackingNumber = const Value.absent(),
    this.comment = const Value.absent(),
  });
  ProductArrivalsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime arrivalDate,
    required String number,
    this.unloadStart = const Value.absent(),
    this.unloadEnd = const Value.absent(),
    this.storageId = const Value.absent(),
    required String storeName,
    required String sellerName,
    required String statusName,
    this.orderTrackingNumber = const Value.absent(),
    this.comment = const Value.absent(),
  })  : arrivalDate = Value(arrivalDate),
        number = Value(number),
        storeName = Value(storeName),
        sellerName = Value(sellerName),
        statusName = Value(statusName);
  static Insertable<ProductArrival> custom({
    Expression<int>? id,
    Expression<DateTime>? arrivalDate,
    Expression<String>? number,
    Expression<DateTime?>? unloadStart,
    Expression<DateTime?>? unloadEnd,
    Expression<int?>? storageId,
    Expression<String>? storeName,
    Expression<String>? sellerName,
    Expression<String>? statusName,
    Expression<String?>? orderTrackingNumber,
    Expression<String?>? comment,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (arrivalDate != null) 'arrival_date': arrivalDate,
      if (number != null) 'number': number,
      if (unloadStart != null) 'unload_start': unloadStart,
      if (unloadEnd != null) 'unload_end': unloadEnd,
      if (storageId != null) 'storage_id': storageId,
      if (storeName != null) 'store_name': storeName,
      if (sellerName != null) 'seller_name': sellerName,
      if (statusName != null) 'status_name': statusName,
      if (orderTrackingNumber != null)
        'order_tracking_number': orderTrackingNumber,
      if (comment != null) 'comment': comment,
    });
  }

  ProductArrivalsCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? arrivalDate,
      Value<String>? number,
      Value<DateTime?>? unloadStart,
      Value<DateTime?>? unloadEnd,
      Value<int?>? storageId,
      Value<String>? storeName,
      Value<String>? sellerName,
      Value<String>? statusName,
      Value<String?>? orderTrackingNumber,
      Value<String?>? comment}) {
    return ProductArrivalsCompanion(
      id: id ?? this.id,
      arrivalDate: arrivalDate ?? this.arrivalDate,
      number: number ?? this.number,
      unloadStart: unloadStart ?? this.unloadStart,
      unloadEnd: unloadEnd ?? this.unloadEnd,
      storageId: storageId ?? this.storageId,
      storeName: storeName ?? this.storeName,
      sellerName: sellerName ?? this.sellerName,
      statusName: statusName ?? this.statusName,
      orderTrackingNumber: orderTrackingNumber ?? this.orderTrackingNumber,
      comment: comment ?? this.comment,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (arrivalDate.present) {
      map['arrival_date'] = Variable<DateTime>(arrivalDate.value);
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    if (unloadStart.present) {
      map['unload_start'] = Variable<DateTime?>(unloadStart.value);
    }
    if (unloadEnd.present) {
      map['unload_end'] = Variable<DateTime?>(unloadEnd.value);
    }
    if (storageId.present) {
      map['storage_id'] = Variable<int?>(storageId.value);
    }
    if (storeName.present) {
      map['store_name'] = Variable<String>(storeName.value);
    }
    if (sellerName.present) {
      map['seller_name'] = Variable<String>(sellerName.value);
    }
    if (statusName.present) {
      map['status_name'] = Variable<String>(statusName.value);
    }
    if (orderTrackingNumber.present) {
      map['order_tracking_number'] =
          Variable<String?>(orderTrackingNumber.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String?>(comment.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductArrivalsCompanion(')
          ..write('id: $id, ')
          ..write('arrivalDate: $arrivalDate, ')
          ..write('number: $number, ')
          ..write('unloadStart: $unloadStart, ')
          ..write('unloadEnd: $unloadEnd, ')
          ..write('storageId: $storageId, ')
          ..write('storeName: $storeName, ')
          ..write('sellerName: $sellerName, ')
          ..write('statusName: $statusName, ')
          ..write('orderTrackingNumber: $orderTrackingNumber, ')
          ..write('comment: $comment')
          ..write(')'))
        .toString();
  }
}

class $ProductArrivalsTable extends ProductArrivals
    with TableInfo<$ProductArrivalsTable, ProductArrival> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductArrivalsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _arrivalDateMeta =
      const VerificationMeta('arrivalDate');
  @override
  late final GeneratedColumn<DateTime?> arrivalDate =
      GeneratedColumn<DateTime?>('arrival_date', aliasedName, false,
          type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String?> number = GeneratedColumn<String?>(
      'number', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _unloadStartMeta =
      const VerificationMeta('unloadStart');
  @override
  late final GeneratedColumn<DateTime?> unloadStart =
      GeneratedColumn<DateTime?>('unload_start', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _unloadEndMeta = const VerificationMeta('unloadEnd');
  @override
  late final GeneratedColumn<DateTime?> unloadEnd = GeneratedColumn<DateTime?>(
      'unload_end', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _storageIdMeta = const VerificationMeta('storageId');
  @override
  late final GeneratedColumn<int?> storageId = GeneratedColumn<int?>(
      'storage_id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES storages (id)');
  final VerificationMeta _storeNameMeta = const VerificationMeta('storeName');
  @override
  late final GeneratedColumn<String?> storeName = GeneratedColumn<String?>(
      'store_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _sellerNameMeta = const VerificationMeta('sellerName');
  @override
  late final GeneratedColumn<String?> sellerName = GeneratedColumn<String?>(
      'seller_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _statusNameMeta = const VerificationMeta('statusName');
  @override
  late final GeneratedColumn<String?> statusName = GeneratedColumn<String?>(
      'status_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _orderTrackingNumberMeta =
      const VerificationMeta('orderTrackingNumber');
  @override
  late final GeneratedColumn<String?> orderTrackingNumber =
      GeneratedColumn<String?>('order_tracking_number', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _commentMeta = const VerificationMeta('comment');
  @override
  late final GeneratedColumn<String?> comment = GeneratedColumn<String?>(
      'comment', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        arrivalDate,
        number,
        unloadStart,
        unloadEnd,
        storageId,
        storeName,
        sellerName,
        statusName,
        orderTrackingNumber,
        comment
      ];
  @override
  String get aliasedName => _alias ?? 'product_arrivals';
  @override
  String get actualTableName => 'product_arrivals';
  @override
  VerificationContext validateIntegrity(Insertable<ProductArrival> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('arrival_date')) {
      context.handle(
          _arrivalDateMeta,
          arrivalDate.isAcceptableOrUnknown(
              data['arrival_date']!, _arrivalDateMeta));
    } else if (isInserting) {
      context.missing(_arrivalDateMeta);
    }
    if (data.containsKey('number')) {
      context.handle(_numberMeta,
          number.isAcceptableOrUnknown(data['number']!, _numberMeta));
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('unload_start')) {
      context.handle(
          _unloadStartMeta,
          unloadStart.isAcceptableOrUnknown(
              data['unload_start']!, _unloadStartMeta));
    }
    if (data.containsKey('unload_end')) {
      context.handle(_unloadEndMeta,
          unloadEnd.isAcceptableOrUnknown(data['unload_end']!, _unloadEndMeta));
    }
    if (data.containsKey('storage_id')) {
      context.handle(_storageIdMeta,
          storageId.isAcceptableOrUnknown(data['storage_id']!, _storageIdMeta));
    }
    if (data.containsKey('store_name')) {
      context.handle(_storeNameMeta,
          storeName.isAcceptableOrUnknown(data['store_name']!, _storeNameMeta));
    } else if (isInserting) {
      context.missing(_storeNameMeta);
    }
    if (data.containsKey('seller_name')) {
      context.handle(
          _sellerNameMeta,
          sellerName.isAcceptableOrUnknown(
              data['seller_name']!, _sellerNameMeta));
    } else if (isInserting) {
      context.missing(_sellerNameMeta);
    }
    if (data.containsKey('status_name')) {
      context.handle(
          _statusNameMeta,
          statusName.isAcceptableOrUnknown(
              data['status_name']!, _statusNameMeta));
    } else if (isInserting) {
      context.missing(_statusNameMeta);
    }
    if (data.containsKey('order_tracking_number')) {
      context.handle(
          _orderTrackingNumberMeta,
          orderTrackingNumber.isAcceptableOrUnknown(
              data['order_tracking_number']!, _orderTrackingNumberMeta));
    }
    if (data.containsKey('comment')) {
      context.handle(_commentMeta,
          comment.isAcceptableOrUnknown(data['comment']!, _commentMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductArrival map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ProductArrival.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ProductArrivalsTable createAlias(String alias) {
    return $ProductArrivalsTable(attachedDatabase, alias);
  }
}

class ProductArrivalPackage extends DataClass
    implements Insertable<ProductArrivalPackage> {
  final int id;
  final int productArrivalId;
  final String number;
  final String typeName;
  final String qr;
  final DateTime? acceptStart;
  final DateTime? acceptEnd;
  final DateTime? placed;
  ProductArrivalPackage(
      {required this.id,
      required this.productArrivalId,
      required this.number,
      required this.typeName,
      required this.qr,
      this.acceptStart,
      this.acceptEnd,
      this.placed});
  factory ProductArrivalPackage.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ProductArrivalPackage(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      productArrivalId: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}product_arrival_id'])!,
      number: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}number'])!,
      typeName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type_name'])!,
      qr: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}qr'])!,
      acceptStart: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}accept_start']),
      acceptEnd: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}accept_end']),
      placed: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}placed']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_arrival_id'] = Variable<int>(productArrivalId);
    map['number'] = Variable<String>(number);
    map['type_name'] = Variable<String>(typeName);
    map['qr'] = Variable<String>(qr);
    if (!nullToAbsent || acceptStart != null) {
      map['accept_start'] = Variable<DateTime?>(acceptStart);
    }
    if (!nullToAbsent || acceptEnd != null) {
      map['accept_end'] = Variable<DateTime?>(acceptEnd);
    }
    if (!nullToAbsent || placed != null) {
      map['placed'] = Variable<DateTime?>(placed);
    }
    return map;
  }

  ProductArrivalPackagesCompanion toCompanion(bool nullToAbsent) {
    return ProductArrivalPackagesCompanion(
      id: Value(id),
      productArrivalId: Value(productArrivalId),
      number: Value(number),
      typeName: Value(typeName),
      qr: Value(qr),
      acceptStart: acceptStart == null && nullToAbsent
          ? const Value.absent()
          : Value(acceptStart),
      acceptEnd: acceptEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(acceptEnd),
      placed:
          placed == null && nullToAbsent ? const Value.absent() : Value(placed),
    );
  }

  factory ProductArrivalPackage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductArrivalPackage(
      id: serializer.fromJson<int>(json['id']),
      productArrivalId: serializer.fromJson<int>(json['productArrivalId']),
      number: serializer.fromJson<String>(json['number']),
      typeName: serializer.fromJson<String>(json['typeName']),
      qr: serializer.fromJson<String>(json['qr']),
      acceptStart: serializer.fromJson<DateTime?>(json['acceptStart']),
      acceptEnd: serializer.fromJson<DateTime?>(json['acceptEnd']),
      placed: serializer.fromJson<DateTime?>(json['placed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productArrivalId': serializer.toJson<int>(productArrivalId),
      'number': serializer.toJson<String>(number),
      'typeName': serializer.toJson<String>(typeName),
      'qr': serializer.toJson<String>(qr),
      'acceptStart': serializer.toJson<DateTime?>(acceptStart),
      'acceptEnd': serializer.toJson<DateTime?>(acceptEnd),
      'placed': serializer.toJson<DateTime?>(placed),
    };
  }

  ProductArrivalPackage copyWith(
          {int? id,
          int? productArrivalId,
          String? number,
          String? typeName,
          String? qr,
          DateTime? acceptStart,
          DateTime? acceptEnd,
          DateTime? placed}) =>
      ProductArrivalPackage(
        id: id ?? this.id,
        productArrivalId: productArrivalId ?? this.productArrivalId,
        number: number ?? this.number,
        typeName: typeName ?? this.typeName,
        qr: qr ?? this.qr,
        acceptStart: acceptStart ?? this.acceptStart,
        acceptEnd: acceptEnd ?? this.acceptEnd,
        placed: placed ?? this.placed,
      );
  @override
  String toString() {
    return (StringBuffer('ProductArrivalPackage(')
          ..write('id: $id, ')
          ..write('productArrivalId: $productArrivalId, ')
          ..write('number: $number, ')
          ..write('typeName: $typeName, ')
          ..write('qr: $qr, ')
          ..write('acceptStart: $acceptStart, ')
          ..write('acceptEnd: $acceptEnd, ')
          ..write('placed: $placed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, productArrivalId, number, typeName, qr,
      acceptStart, acceptEnd, placed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductArrivalPackage &&
          other.id == this.id &&
          other.productArrivalId == this.productArrivalId &&
          other.number == this.number &&
          other.typeName == this.typeName &&
          other.qr == this.qr &&
          other.acceptStart == this.acceptStart &&
          other.acceptEnd == this.acceptEnd &&
          other.placed == this.placed);
}

class ProductArrivalPackagesCompanion
    extends UpdateCompanion<ProductArrivalPackage> {
  final Value<int> id;
  final Value<int> productArrivalId;
  final Value<String> number;
  final Value<String> typeName;
  final Value<String> qr;
  final Value<DateTime?> acceptStart;
  final Value<DateTime?> acceptEnd;
  final Value<DateTime?> placed;
  const ProductArrivalPackagesCompanion({
    this.id = const Value.absent(),
    this.productArrivalId = const Value.absent(),
    this.number = const Value.absent(),
    this.typeName = const Value.absent(),
    this.qr = const Value.absent(),
    this.acceptStart = const Value.absent(),
    this.acceptEnd = const Value.absent(),
    this.placed = const Value.absent(),
  });
  ProductArrivalPackagesCompanion.insert({
    this.id = const Value.absent(),
    required int productArrivalId,
    required String number,
    required String typeName,
    required String qr,
    this.acceptStart = const Value.absent(),
    this.acceptEnd = const Value.absent(),
    this.placed = const Value.absent(),
  })  : productArrivalId = Value(productArrivalId),
        number = Value(number),
        typeName = Value(typeName),
        qr = Value(qr);
  static Insertable<ProductArrivalPackage> custom({
    Expression<int>? id,
    Expression<int>? productArrivalId,
    Expression<String>? number,
    Expression<String>? typeName,
    Expression<String>? qr,
    Expression<DateTime?>? acceptStart,
    Expression<DateTime?>? acceptEnd,
    Expression<DateTime?>? placed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productArrivalId != null) 'product_arrival_id': productArrivalId,
      if (number != null) 'number': number,
      if (typeName != null) 'type_name': typeName,
      if (qr != null) 'qr': qr,
      if (acceptStart != null) 'accept_start': acceptStart,
      if (acceptEnd != null) 'accept_end': acceptEnd,
      if (placed != null) 'placed': placed,
    });
  }

  ProductArrivalPackagesCompanion copyWith(
      {Value<int>? id,
      Value<int>? productArrivalId,
      Value<String>? number,
      Value<String>? typeName,
      Value<String>? qr,
      Value<DateTime?>? acceptStart,
      Value<DateTime?>? acceptEnd,
      Value<DateTime?>? placed}) {
    return ProductArrivalPackagesCompanion(
      id: id ?? this.id,
      productArrivalId: productArrivalId ?? this.productArrivalId,
      number: number ?? this.number,
      typeName: typeName ?? this.typeName,
      qr: qr ?? this.qr,
      acceptStart: acceptStart ?? this.acceptStart,
      acceptEnd: acceptEnd ?? this.acceptEnd,
      placed: placed ?? this.placed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productArrivalId.present) {
      map['product_arrival_id'] = Variable<int>(productArrivalId.value);
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    if (typeName.present) {
      map['type_name'] = Variable<String>(typeName.value);
    }
    if (qr.present) {
      map['qr'] = Variable<String>(qr.value);
    }
    if (acceptStart.present) {
      map['accept_start'] = Variable<DateTime?>(acceptStart.value);
    }
    if (acceptEnd.present) {
      map['accept_end'] = Variable<DateTime?>(acceptEnd.value);
    }
    if (placed.present) {
      map['placed'] = Variable<DateTime?>(placed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductArrivalPackagesCompanion(')
          ..write('id: $id, ')
          ..write('productArrivalId: $productArrivalId, ')
          ..write('number: $number, ')
          ..write('typeName: $typeName, ')
          ..write('qr: $qr, ')
          ..write('acceptStart: $acceptStart, ')
          ..write('acceptEnd: $acceptEnd, ')
          ..write('placed: $placed')
          ..write(')'))
        .toString();
  }
}

class $ProductArrivalPackagesTable extends ProductArrivalPackages
    with TableInfo<$ProductArrivalPackagesTable, ProductArrivalPackage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductArrivalPackagesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _productArrivalIdMeta =
      const VerificationMeta('productArrivalId');
  @override
  late final GeneratedColumn<int?> productArrivalId = GeneratedColumn<int?>(
      'product_arrival_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES product_arrivals (id) ON DELETE CASCADE');
  final VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String?> number = GeneratedColumn<String?>(
      'number', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _typeNameMeta = const VerificationMeta('typeName');
  @override
  late final GeneratedColumn<String?> typeName = GeneratedColumn<String?>(
      'type_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _qrMeta = const VerificationMeta('qr');
  @override
  late final GeneratedColumn<String?> qr = GeneratedColumn<String?>(
      'qr', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _acceptStartMeta =
      const VerificationMeta('acceptStart');
  @override
  late final GeneratedColumn<DateTime?> acceptStart =
      GeneratedColumn<DateTime?>('accept_start', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _acceptEndMeta = const VerificationMeta('acceptEnd');
  @override
  late final GeneratedColumn<DateTime?> acceptEnd = GeneratedColumn<DateTime?>(
      'accept_end', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _placedMeta = const VerificationMeta('placed');
  @override
  late final GeneratedColumn<DateTime?> placed = GeneratedColumn<DateTime?>(
      'placed', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        productArrivalId,
        number,
        typeName,
        qr,
        acceptStart,
        acceptEnd,
        placed
      ];
  @override
  String get aliasedName => _alias ?? 'product_arrival_packages';
  @override
  String get actualTableName => 'product_arrival_packages';
  @override
  VerificationContext validateIntegrity(
      Insertable<ProductArrivalPackage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_arrival_id')) {
      context.handle(
          _productArrivalIdMeta,
          productArrivalId.isAcceptableOrUnknown(
              data['product_arrival_id']!, _productArrivalIdMeta));
    } else if (isInserting) {
      context.missing(_productArrivalIdMeta);
    }
    if (data.containsKey('number')) {
      context.handle(_numberMeta,
          number.isAcceptableOrUnknown(data['number']!, _numberMeta));
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('type_name')) {
      context.handle(_typeNameMeta,
          typeName.isAcceptableOrUnknown(data['type_name']!, _typeNameMeta));
    } else if (isInserting) {
      context.missing(_typeNameMeta);
    }
    if (data.containsKey('qr')) {
      context.handle(_qrMeta, qr.isAcceptableOrUnknown(data['qr']!, _qrMeta));
    } else if (isInserting) {
      context.missing(_qrMeta);
    }
    if (data.containsKey('accept_start')) {
      context.handle(
          _acceptStartMeta,
          acceptStart.isAcceptableOrUnknown(
              data['accept_start']!, _acceptStartMeta));
    }
    if (data.containsKey('accept_end')) {
      context.handle(_acceptEndMeta,
          acceptEnd.isAcceptableOrUnknown(data['accept_end']!, _acceptEndMeta));
    }
    if (data.containsKey('placed')) {
      context.handle(_placedMeta,
          placed.isAcceptableOrUnknown(data['placed']!, _placedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductArrivalPackage map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ProductArrivalPackage.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ProductArrivalPackagesTable createAlias(String alias) {
    return $ProductArrivalPackagesTable(attachedDatabase, alias);
  }
}

class ProductArrivalLine extends DataClass
    implements Insertable<ProductArrivalLine> {
  final int id;
  final int productArrivalId;
  final int productId;
  final int amount;
  final bool enumeratePiece;
  ProductArrivalLine(
      {required this.id,
      required this.productArrivalId,
      required this.productId,
      required this.amount,
      required this.enumeratePiece});
  factory ProductArrivalLine.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ProductArrivalLine(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      productArrivalId: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}product_arrival_id'])!,
      productId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}product_id'])!,
      amount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount'])!,
      enumeratePiece: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}enumerate_piece'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_arrival_id'] = Variable<int>(productArrivalId);
    map['product_id'] = Variable<int>(productId);
    map['amount'] = Variable<int>(amount);
    map['enumerate_piece'] = Variable<bool>(enumeratePiece);
    return map;
  }

  ProductArrivalLinesCompanion toCompanion(bool nullToAbsent) {
    return ProductArrivalLinesCompanion(
      id: Value(id),
      productArrivalId: Value(productArrivalId),
      productId: Value(productId),
      amount: Value(amount),
      enumeratePiece: Value(enumeratePiece),
    );
  }

  factory ProductArrivalLine.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductArrivalLine(
      id: serializer.fromJson<int>(json['id']),
      productArrivalId: serializer.fromJson<int>(json['productArrivalId']),
      productId: serializer.fromJson<int>(json['productId']),
      amount: serializer.fromJson<int>(json['amount']),
      enumeratePiece: serializer.fromJson<bool>(json['enumeratePiece']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productArrivalId': serializer.toJson<int>(productArrivalId),
      'productId': serializer.toJson<int>(productId),
      'amount': serializer.toJson<int>(amount),
      'enumeratePiece': serializer.toJson<bool>(enumeratePiece),
    };
  }

  ProductArrivalLine copyWith(
          {int? id,
          int? productArrivalId,
          int? productId,
          int? amount,
          bool? enumeratePiece}) =>
      ProductArrivalLine(
        id: id ?? this.id,
        productArrivalId: productArrivalId ?? this.productArrivalId,
        productId: productId ?? this.productId,
        amount: amount ?? this.amount,
        enumeratePiece: enumeratePiece ?? this.enumeratePiece,
      );
  @override
  String toString() {
    return (StringBuffer('ProductArrivalLine(')
          ..write('id: $id, ')
          ..write('productArrivalId: $productArrivalId, ')
          ..write('productId: $productId, ')
          ..write('amount: $amount, ')
          ..write('enumeratePiece: $enumeratePiece')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, productArrivalId, productId, amount, enumeratePiece);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductArrivalLine &&
          other.id == this.id &&
          other.productArrivalId == this.productArrivalId &&
          other.productId == this.productId &&
          other.amount == this.amount &&
          other.enumeratePiece == this.enumeratePiece);
}

class ProductArrivalLinesCompanion extends UpdateCompanion<ProductArrivalLine> {
  final Value<int> id;
  final Value<int> productArrivalId;
  final Value<int> productId;
  final Value<int> amount;
  final Value<bool> enumeratePiece;
  const ProductArrivalLinesCompanion({
    this.id = const Value.absent(),
    this.productArrivalId = const Value.absent(),
    this.productId = const Value.absent(),
    this.amount = const Value.absent(),
    this.enumeratePiece = const Value.absent(),
  });
  ProductArrivalLinesCompanion.insert({
    this.id = const Value.absent(),
    required int productArrivalId,
    required int productId,
    required int amount,
    required bool enumeratePiece,
  })  : productArrivalId = Value(productArrivalId),
        productId = Value(productId),
        amount = Value(amount),
        enumeratePiece = Value(enumeratePiece);
  static Insertable<ProductArrivalLine> custom({
    Expression<int>? id,
    Expression<int>? productArrivalId,
    Expression<int>? productId,
    Expression<int>? amount,
    Expression<bool>? enumeratePiece,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productArrivalId != null) 'product_arrival_id': productArrivalId,
      if (productId != null) 'product_id': productId,
      if (amount != null) 'amount': amount,
      if (enumeratePiece != null) 'enumerate_piece': enumeratePiece,
    });
  }

  ProductArrivalLinesCompanion copyWith(
      {Value<int>? id,
      Value<int>? productArrivalId,
      Value<int>? productId,
      Value<int>? amount,
      Value<bool>? enumeratePiece}) {
    return ProductArrivalLinesCompanion(
      id: id ?? this.id,
      productArrivalId: productArrivalId ?? this.productArrivalId,
      productId: productId ?? this.productId,
      amount: amount ?? this.amount,
      enumeratePiece: enumeratePiece ?? this.enumeratePiece,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productArrivalId.present) {
      map['product_arrival_id'] = Variable<int>(productArrivalId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (enumeratePiece.present) {
      map['enumerate_piece'] = Variable<bool>(enumeratePiece.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductArrivalLinesCompanion(')
          ..write('id: $id, ')
          ..write('productArrivalId: $productArrivalId, ')
          ..write('productId: $productId, ')
          ..write('amount: $amount, ')
          ..write('enumeratePiece: $enumeratePiece')
          ..write(')'))
        .toString();
  }
}

class $ProductArrivalLinesTable extends ProductArrivalLines
    with TableInfo<$ProductArrivalLinesTable, ProductArrivalLine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductArrivalLinesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _productArrivalIdMeta =
      const VerificationMeta('productArrivalId');
  @override
  late final GeneratedColumn<int?> productArrivalId = GeneratedColumn<int?>(
      'product_arrival_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints:
          'REFERENCES product_arrival_packages (id) ON DELETE CASCADE');
  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int?> productId = GeneratedColumn<int?>(
      'product_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES products (id) ON DELETE CASCADE');
  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int?> amount = GeneratedColumn<int?>(
      'amount', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _enumeratePieceMeta =
      const VerificationMeta('enumeratePiece');
  @override
  late final GeneratedColumn<bool?> enumeratePiece = GeneratedColumn<bool?>(
      'enumerate_piece', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (enumerate_piece IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns =>
      [id, productArrivalId, productId, amount, enumeratePiece];
  @override
  String get aliasedName => _alias ?? 'product_arrival_lines';
  @override
  String get actualTableName => 'product_arrival_lines';
  @override
  VerificationContext validateIntegrity(Insertable<ProductArrivalLine> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_arrival_id')) {
      context.handle(
          _productArrivalIdMeta,
          productArrivalId.isAcceptableOrUnknown(
              data['product_arrival_id']!, _productArrivalIdMeta));
    } else if (isInserting) {
      context.missing(_productArrivalIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('enumerate_piece')) {
      context.handle(
          _enumeratePieceMeta,
          enumeratePiece.isAcceptableOrUnknown(
              data['enumerate_piece']!, _enumeratePieceMeta));
    } else if (isInserting) {
      context.missing(_enumeratePieceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductArrivalLine map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ProductArrivalLine.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ProductArrivalLinesTable createAlias(String alias) {
    return $ProductArrivalLinesTable(attachedDatabase, alias);
  }
}

class ProductArrivalUnloadPackage extends DataClass
    implements Insertable<ProductArrivalUnloadPackage> {
  final int id;
  final int productArrivalId;
  final int amount;
  final String typeName;
  ProductArrivalUnloadPackage(
      {required this.id,
      required this.productArrivalId,
      required this.amount,
      required this.typeName});
  factory ProductArrivalUnloadPackage.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ProductArrivalUnloadPackage(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      productArrivalId: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}product_arrival_id'])!,
      amount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount'])!,
      typeName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type_name'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_arrival_id'] = Variable<int>(productArrivalId);
    map['amount'] = Variable<int>(amount);
    map['type_name'] = Variable<String>(typeName);
    return map;
  }

  ProductArrivalUnloadPackagesCompanion toCompanion(bool nullToAbsent) {
    return ProductArrivalUnloadPackagesCompanion(
      id: Value(id),
      productArrivalId: Value(productArrivalId),
      amount: Value(amount),
      typeName: Value(typeName),
    );
  }

  factory ProductArrivalUnloadPackage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductArrivalUnloadPackage(
      id: serializer.fromJson<int>(json['id']),
      productArrivalId: serializer.fromJson<int>(json['productArrivalId']),
      amount: serializer.fromJson<int>(json['amount']),
      typeName: serializer.fromJson<String>(json['typeName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productArrivalId': serializer.toJson<int>(productArrivalId),
      'amount': serializer.toJson<int>(amount),
      'typeName': serializer.toJson<String>(typeName),
    };
  }

  ProductArrivalUnloadPackage copyWith(
          {int? id, int? productArrivalId, int? amount, String? typeName}) =>
      ProductArrivalUnloadPackage(
        id: id ?? this.id,
        productArrivalId: productArrivalId ?? this.productArrivalId,
        amount: amount ?? this.amount,
        typeName: typeName ?? this.typeName,
      );
  @override
  String toString() {
    return (StringBuffer('ProductArrivalUnloadPackage(')
          ..write('id: $id, ')
          ..write('productArrivalId: $productArrivalId, ')
          ..write('amount: $amount, ')
          ..write('typeName: $typeName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, productArrivalId, amount, typeName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductArrivalUnloadPackage &&
          other.id == this.id &&
          other.productArrivalId == this.productArrivalId &&
          other.amount == this.amount &&
          other.typeName == this.typeName);
}

class ProductArrivalUnloadPackagesCompanion
    extends UpdateCompanion<ProductArrivalUnloadPackage> {
  final Value<int> id;
  final Value<int> productArrivalId;
  final Value<int> amount;
  final Value<String> typeName;
  const ProductArrivalUnloadPackagesCompanion({
    this.id = const Value.absent(),
    this.productArrivalId = const Value.absent(),
    this.amount = const Value.absent(),
    this.typeName = const Value.absent(),
  });
  ProductArrivalUnloadPackagesCompanion.insert({
    this.id = const Value.absent(),
    required int productArrivalId,
    required int amount,
    required String typeName,
  })  : productArrivalId = Value(productArrivalId),
        amount = Value(amount),
        typeName = Value(typeName);
  static Insertable<ProductArrivalUnloadPackage> custom({
    Expression<int>? id,
    Expression<int>? productArrivalId,
    Expression<int>? amount,
    Expression<String>? typeName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productArrivalId != null) 'product_arrival_id': productArrivalId,
      if (amount != null) 'amount': amount,
      if (typeName != null) 'type_name': typeName,
    });
  }

  ProductArrivalUnloadPackagesCompanion copyWith(
      {Value<int>? id,
      Value<int>? productArrivalId,
      Value<int>? amount,
      Value<String>? typeName}) {
    return ProductArrivalUnloadPackagesCompanion(
      id: id ?? this.id,
      productArrivalId: productArrivalId ?? this.productArrivalId,
      amount: amount ?? this.amount,
      typeName: typeName ?? this.typeName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productArrivalId.present) {
      map['product_arrival_id'] = Variable<int>(productArrivalId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (typeName.present) {
      map['type_name'] = Variable<String>(typeName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductArrivalUnloadPackagesCompanion(')
          ..write('id: $id, ')
          ..write('productArrivalId: $productArrivalId, ')
          ..write('amount: $amount, ')
          ..write('typeName: $typeName')
          ..write(')'))
        .toString();
  }
}

class $ProductArrivalUnloadPackagesTable extends ProductArrivalUnloadPackages
    with
        TableInfo<$ProductArrivalUnloadPackagesTable,
            ProductArrivalUnloadPackage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductArrivalUnloadPackagesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _productArrivalIdMeta =
      const VerificationMeta('productArrivalId');
  @override
  late final GeneratedColumn<int?> productArrivalId = GeneratedColumn<int?>(
      'product_arrival_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES product_arrivals (id) ON DELETE CASCADE');
  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int?> amount = GeneratedColumn<int?>(
      'amount', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _typeNameMeta = const VerificationMeta('typeName');
  @override
  late final GeneratedColumn<String?> typeName = GeneratedColumn<String?>(
      'type_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, productArrivalId, amount, typeName];
  @override
  String get aliasedName => _alias ?? 'product_arrival_unload_packages';
  @override
  String get actualTableName => 'product_arrival_unload_packages';
  @override
  VerificationContext validateIntegrity(
      Insertable<ProductArrivalUnloadPackage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_arrival_id')) {
      context.handle(
          _productArrivalIdMeta,
          productArrivalId.isAcceptableOrUnknown(
              data['product_arrival_id']!, _productArrivalIdMeta));
    } else if (isInserting) {
      context.missing(_productArrivalIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('type_name')) {
      context.handle(_typeNameMeta,
          typeName.isAcceptableOrUnknown(data['type_name']!, _typeNameMeta));
    } else if (isInserting) {
      context.missing(_typeNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductArrivalUnloadPackage map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    return ProductArrivalUnloadPackage.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ProductArrivalUnloadPackagesTable createAlias(String alias) {
    return $ProductArrivalUnloadPackagesTable(attachedDatabase, alias);
  }
}

class ProductArrivalPackageType extends DataClass
    implements Insertable<ProductArrivalPackageType> {
  final int id;
  final String name;
  ProductArrivalPackageType({required this.id, required this.name});
  factory ProductArrivalPackageType.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ProductArrivalPackageType(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  ProductArrivalPackageTypesCompanion toCompanion(bool nullToAbsent) {
    return ProductArrivalPackageTypesCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory ProductArrivalPackageType.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductArrivalPackageType(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  ProductArrivalPackageType copyWith({int? id, String? name}) =>
      ProductArrivalPackageType(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('ProductArrivalPackageType(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductArrivalPackageType &&
          other.id == this.id &&
          other.name == this.name);
}

class ProductArrivalPackageTypesCompanion
    extends UpdateCompanion<ProductArrivalPackageType> {
  final Value<int> id;
  final Value<String> name;
  const ProductArrivalPackageTypesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  ProductArrivalPackageTypesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<ProductArrivalPackageType> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  ProductArrivalPackageTypesCompanion copyWith(
      {Value<int>? id, Value<String>? name}) {
    return ProductArrivalPackageTypesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductArrivalPackageTypesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $ProductArrivalPackageTypesTable extends ProductArrivalPackageTypes
    with
        TableInfo<$ProductArrivalPackageTypesTable, ProductArrivalPackageType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductArrivalPackageTypesTable(this.attachedDatabase, [this._alias]);
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
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? 'product_arrival_package_types';
  @override
  String get actualTableName => 'product_arrival_package_types';
  @override
  VerificationContext validateIntegrity(
      Insertable<ProductArrivalPackageType> instance,
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductArrivalPackageType map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    return ProductArrivalPackageType.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ProductArrivalPackageTypesTable createAlias(String alias) {
    return $ProductArrivalPackageTypesTable(attachedDatabase, alias);
  }
}

class ProductArrivalPackageLine extends DataClass
    implements Insertable<ProductArrivalPackageLine> {
  final int id;
  final int productArrivalPackageId;
  final int productId;
  final int amount;
  ProductArrivalPackageLine(
      {required this.id,
      required this.productArrivalPackageId,
      required this.productId,
      required this.amount});
  factory ProductArrivalPackageLine.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ProductArrivalPackageLine(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      productArrivalPackageId: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}product_arrival_package_id'])!,
      productId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}product_id'])!,
      amount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_arrival_package_id'] = Variable<int>(productArrivalPackageId);
    map['product_id'] = Variable<int>(productId);
    map['amount'] = Variable<int>(amount);
    return map;
  }

  ProductArrivalPackageLinesCompanion toCompanion(bool nullToAbsent) {
    return ProductArrivalPackageLinesCompanion(
      id: Value(id),
      productArrivalPackageId: Value(productArrivalPackageId),
      productId: Value(productId),
      amount: Value(amount),
    );
  }

  factory ProductArrivalPackageLine.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductArrivalPackageLine(
      id: serializer.fromJson<int>(json['id']),
      productArrivalPackageId:
          serializer.fromJson<int>(json['productArrivalPackageId']),
      productId: serializer.fromJson<int>(json['productId']),
      amount: serializer.fromJson<int>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productArrivalPackageId':
          serializer.toJson<int>(productArrivalPackageId),
      'productId': serializer.toJson<int>(productId),
      'amount': serializer.toJson<int>(amount),
    };
  }

  ProductArrivalPackageLine copyWith(
          {int? id,
          int? productArrivalPackageId,
          int? productId,
          int? amount}) =>
      ProductArrivalPackageLine(
        id: id ?? this.id,
        productArrivalPackageId:
            productArrivalPackageId ?? this.productArrivalPackageId,
        productId: productId ?? this.productId,
        amount: amount ?? this.amount,
      );
  @override
  String toString() {
    return (StringBuffer('ProductArrivalPackageLine(')
          ..write('id: $id, ')
          ..write('productArrivalPackageId: $productArrivalPackageId, ')
          ..write('productId: $productId, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, productArrivalPackageId, productId, amount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductArrivalPackageLine &&
          other.id == this.id &&
          other.productArrivalPackageId == this.productArrivalPackageId &&
          other.productId == this.productId &&
          other.amount == this.amount);
}

class ProductArrivalPackageLinesCompanion
    extends UpdateCompanion<ProductArrivalPackageLine> {
  final Value<int> id;
  final Value<int> productArrivalPackageId;
  final Value<int> productId;
  final Value<int> amount;
  const ProductArrivalPackageLinesCompanion({
    this.id = const Value.absent(),
    this.productArrivalPackageId = const Value.absent(),
    this.productId = const Value.absent(),
    this.amount = const Value.absent(),
  });
  ProductArrivalPackageLinesCompanion.insert({
    this.id = const Value.absent(),
    required int productArrivalPackageId,
    required int productId,
    required int amount,
  })  : productArrivalPackageId = Value(productArrivalPackageId),
        productId = Value(productId),
        amount = Value(amount);
  static Insertable<ProductArrivalPackageLine> custom({
    Expression<int>? id,
    Expression<int>? productArrivalPackageId,
    Expression<int>? productId,
    Expression<int>? amount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productArrivalPackageId != null)
        'product_arrival_package_id': productArrivalPackageId,
      if (productId != null) 'product_id': productId,
      if (amount != null) 'amount': amount,
    });
  }

  ProductArrivalPackageLinesCompanion copyWith(
      {Value<int>? id,
      Value<int>? productArrivalPackageId,
      Value<int>? productId,
      Value<int>? amount}) {
    return ProductArrivalPackageLinesCompanion(
      id: id ?? this.id,
      productArrivalPackageId:
          productArrivalPackageId ?? this.productArrivalPackageId,
      productId: productId ?? this.productId,
      amount: amount ?? this.amount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productArrivalPackageId.present) {
      map['product_arrival_package_id'] =
          Variable<int>(productArrivalPackageId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductArrivalPackageLinesCompanion(')
          ..write('id: $id, ')
          ..write('productArrivalPackageId: $productArrivalPackageId, ')
          ..write('productId: $productId, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }
}

class $ProductArrivalPackageLinesTable extends ProductArrivalPackageLines
    with
        TableInfo<$ProductArrivalPackageLinesTable, ProductArrivalPackageLine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductArrivalPackageLinesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _productArrivalPackageIdMeta =
      const VerificationMeta('productArrivalPackageId');
  @override
  late final GeneratedColumn<int?> productArrivalPackageId =
      GeneratedColumn<int?>('product_arrival_package_id', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: true,
          defaultConstraints:
              'REFERENCES product_arrival_packages (id) ON DELETE CASCADE');
  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int?> productId = GeneratedColumn<int?>(
      'product_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES products (id) ON DELETE CASCADE');
  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int?> amount = GeneratedColumn<int?>(
      'amount', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, productArrivalPackageId, productId, amount];
  @override
  String get aliasedName => _alias ?? 'product_arrival_package_lines';
  @override
  String get actualTableName => 'product_arrival_package_lines';
  @override
  VerificationContext validateIntegrity(
      Insertable<ProductArrivalPackageLine> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_arrival_package_id')) {
      context.handle(
          _productArrivalPackageIdMeta,
          productArrivalPackageId.isAcceptableOrUnknown(
              data['product_arrival_package_id']!,
              _productArrivalPackageIdMeta));
    } else if (isInserting) {
      context.missing(_productArrivalPackageIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductArrivalPackageLine map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    return ProductArrivalPackageLine.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ProductArrivalPackageLinesTable createAlias(String alias) {
    return $ProductArrivalPackageLinesTable(attachedDatabase, alias);
  }
}

class ProductArrivalNewPackage extends DataClass
    implements Insertable<ProductArrivalNewPackage> {
  final int id;
  final int productArrivalId;
  final int typeId;
  final String typeName;
  final String number;
  ProductArrivalNewPackage(
      {required this.id,
      required this.productArrivalId,
      required this.typeId,
      required this.typeName,
      required this.number});
  factory ProductArrivalNewPackage.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ProductArrivalNewPackage(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      productArrivalId: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}product_arrival_id'])!,
      typeId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type_id'])!,
      typeName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type_name'])!,
      number: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}number'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_arrival_id'] = Variable<int>(productArrivalId);
    map['type_id'] = Variable<int>(typeId);
    map['type_name'] = Variable<String>(typeName);
    map['number'] = Variable<String>(number);
    return map;
  }

  ProductArrivalNewPackagesCompanion toCompanion(bool nullToAbsent) {
    return ProductArrivalNewPackagesCompanion(
      id: Value(id),
      productArrivalId: Value(productArrivalId),
      typeId: Value(typeId),
      typeName: Value(typeName),
      number: Value(number),
    );
  }

  factory ProductArrivalNewPackage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductArrivalNewPackage(
      id: serializer.fromJson<int>(json['id']),
      productArrivalId: serializer.fromJson<int>(json['productArrivalId']),
      typeId: serializer.fromJson<int>(json['typeId']),
      typeName: serializer.fromJson<String>(json['typeName']),
      number: serializer.fromJson<String>(json['number']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productArrivalId': serializer.toJson<int>(productArrivalId),
      'typeId': serializer.toJson<int>(typeId),
      'typeName': serializer.toJson<String>(typeName),
      'number': serializer.toJson<String>(number),
    };
  }

  ProductArrivalNewPackage copyWith(
          {int? id,
          int? productArrivalId,
          int? typeId,
          String? typeName,
          String? number}) =>
      ProductArrivalNewPackage(
        id: id ?? this.id,
        productArrivalId: productArrivalId ?? this.productArrivalId,
        typeId: typeId ?? this.typeId,
        typeName: typeName ?? this.typeName,
        number: number ?? this.number,
      );
  @override
  String toString() {
    return (StringBuffer('ProductArrivalNewPackage(')
          ..write('id: $id, ')
          ..write('productArrivalId: $productArrivalId, ')
          ..write('typeId: $typeId, ')
          ..write('typeName: $typeName, ')
          ..write('number: $number')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, productArrivalId, typeId, typeName, number);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductArrivalNewPackage &&
          other.id == this.id &&
          other.productArrivalId == this.productArrivalId &&
          other.typeId == this.typeId &&
          other.typeName == this.typeName &&
          other.number == this.number);
}

class ProductArrivalNewPackagesCompanion
    extends UpdateCompanion<ProductArrivalNewPackage> {
  final Value<int> id;
  final Value<int> productArrivalId;
  final Value<int> typeId;
  final Value<String> typeName;
  final Value<String> number;
  const ProductArrivalNewPackagesCompanion({
    this.id = const Value.absent(),
    this.productArrivalId = const Value.absent(),
    this.typeId = const Value.absent(),
    this.typeName = const Value.absent(),
    this.number = const Value.absent(),
  });
  ProductArrivalNewPackagesCompanion.insert({
    this.id = const Value.absent(),
    required int productArrivalId,
    required int typeId,
    required String typeName,
    required String number,
  })  : productArrivalId = Value(productArrivalId),
        typeId = Value(typeId),
        typeName = Value(typeName),
        number = Value(number);
  static Insertable<ProductArrivalNewPackage> custom({
    Expression<int>? id,
    Expression<int>? productArrivalId,
    Expression<int>? typeId,
    Expression<String>? typeName,
    Expression<String>? number,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productArrivalId != null) 'product_arrival_id': productArrivalId,
      if (typeId != null) 'type_id': typeId,
      if (typeName != null) 'type_name': typeName,
      if (number != null) 'number': number,
    });
  }

  ProductArrivalNewPackagesCompanion copyWith(
      {Value<int>? id,
      Value<int>? productArrivalId,
      Value<int>? typeId,
      Value<String>? typeName,
      Value<String>? number}) {
    return ProductArrivalNewPackagesCompanion(
      id: id ?? this.id,
      productArrivalId: productArrivalId ?? this.productArrivalId,
      typeId: typeId ?? this.typeId,
      typeName: typeName ?? this.typeName,
      number: number ?? this.number,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productArrivalId.present) {
      map['product_arrival_id'] = Variable<int>(productArrivalId.value);
    }
    if (typeId.present) {
      map['type_id'] = Variable<int>(typeId.value);
    }
    if (typeName.present) {
      map['type_name'] = Variable<String>(typeName.value);
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductArrivalNewPackagesCompanion(')
          ..write('id: $id, ')
          ..write('productArrivalId: $productArrivalId, ')
          ..write('typeId: $typeId, ')
          ..write('typeName: $typeName, ')
          ..write('number: $number')
          ..write(')'))
        .toString();
  }
}

class $ProductArrivalNewPackagesTable extends ProductArrivalNewPackages
    with TableInfo<$ProductArrivalNewPackagesTable, ProductArrivalNewPackage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductArrivalNewPackagesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _productArrivalIdMeta =
      const VerificationMeta('productArrivalId');
  @override
  late final GeneratedColumn<int?> productArrivalId = GeneratedColumn<int?>(
      'product_arrival_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES product_arrivals (id) ON DELETE CASCADE');
  final VerificationMeta _typeIdMeta = const VerificationMeta('typeId');
  @override
  late final GeneratedColumn<int?> typeId = GeneratedColumn<int?>(
      'type_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _typeNameMeta = const VerificationMeta('typeName');
  @override
  late final GeneratedColumn<String?> typeName = GeneratedColumn<String?>(
      'type_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String?> number = GeneratedColumn<String?>(
      'number', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, productArrivalId, typeId, typeName, number];
  @override
  String get aliasedName => _alias ?? 'product_arrival_new_packages';
  @override
  String get actualTableName => 'product_arrival_new_packages';
  @override
  VerificationContext validateIntegrity(
      Insertable<ProductArrivalNewPackage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_arrival_id')) {
      context.handle(
          _productArrivalIdMeta,
          productArrivalId.isAcceptableOrUnknown(
              data['product_arrival_id']!, _productArrivalIdMeta));
    } else if (isInserting) {
      context.missing(_productArrivalIdMeta);
    }
    if (data.containsKey('type_id')) {
      context.handle(_typeIdMeta,
          typeId.isAcceptableOrUnknown(data['type_id']!, _typeIdMeta));
    } else if (isInserting) {
      context.missing(_typeIdMeta);
    }
    if (data.containsKey('type_name')) {
      context.handle(_typeNameMeta,
          typeName.isAcceptableOrUnknown(data['type_name']!, _typeNameMeta));
    } else if (isInserting) {
      context.missing(_typeNameMeta);
    }
    if (data.containsKey('number')) {
      context.handle(_numberMeta,
          number.isAcceptableOrUnknown(data['number']!, _numberMeta));
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductArrivalNewPackage map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    return ProductArrivalNewPackage.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ProductArrivalNewPackagesTable createAlias(String alias) {
    return $ProductArrivalNewPackagesTable(attachedDatabase, alias);
  }
}

class ProductArrivalPackageNewLine extends DataClass
    implements Insertable<ProductArrivalPackageNewLine> {
  final int id;
  final int productArrivalPackageId;
  final int productId;
  final int amount;
  ProductArrivalPackageNewLine(
      {required this.id,
      required this.productArrivalPackageId,
      required this.productId,
      required this.amount});
  factory ProductArrivalPackageNewLine.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ProductArrivalPackageNewLine(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      productArrivalPackageId: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}product_arrival_package_id'])!,
      productId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}product_id'])!,
      amount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_arrival_package_id'] = Variable<int>(productArrivalPackageId);
    map['product_id'] = Variable<int>(productId);
    map['amount'] = Variable<int>(amount);
    return map;
  }

  ProductArrivalPackageNewLinesCompanion toCompanion(bool nullToAbsent) {
    return ProductArrivalPackageNewLinesCompanion(
      id: Value(id),
      productArrivalPackageId: Value(productArrivalPackageId),
      productId: Value(productId),
      amount: Value(amount),
    );
  }

  factory ProductArrivalPackageNewLine.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductArrivalPackageNewLine(
      id: serializer.fromJson<int>(json['id']),
      productArrivalPackageId:
          serializer.fromJson<int>(json['productArrivalPackageId']),
      productId: serializer.fromJson<int>(json['productId']),
      amount: serializer.fromJson<int>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productArrivalPackageId':
          serializer.toJson<int>(productArrivalPackageId),
      'productId': serializer.toJson<int>(productId),
      'amount': serializer.toJson<int>(amount),
    };
  }

  ProductArrivalPackageNewLine copyWith(
          {int? id,
          int? productArrivalPackageId,
          int? productId,
          int? amount}) =>
      ProductArrivalPackageNewLine(
        id: id ?? this.id,
        productArrivalPackageId:
            productArrivalPackageId ?? this.productArrivalPackageId,
        productId: productId ?? this.productId,
        amount: amount ?? this.amount,
      );
  @override
  String toString() {
    return (StringBuffer('ProductArrivalPackageNewLine(')
          ..write('id: $id, ')
          ..write('productArrivalPackageId: $productArrivalPackageId, ')
          ..write('productId: $productId, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, productArrivalPackageId, productId, amount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductArrivalPackageNewLine &&
          other.id == this.id &&
          other.productArrivalPackageId == this.productArrivalPackageId &&
          other.productId == this.productId &&
          other.amount == this.amount);
}

class ProductArrivalPackageNewLinesCompanion
    extends UpdateCompanion<ProductArrivalPackageNewLine> {
  final Value<int> id;
  final Value<int> productArrivalPackageId;
  final Value<int> productId;
  final Value<int> amount;
  const ProductArrivalPackageNewLinesCompanion({
    this.id = const Value.absent(),
    this.productArrivalPackageId = const Value.absent(),
    this.productId = const Value.absent(),
    this.amount = const Value.absent(),
  });
  ProductArrivalPackageNewLinesCompanion.insert({
    this.id = const Value.absent(),
    required int productArrivalPackageId,
    required int productId,
    required int amount,
  })  : productArrivalPackageId = Value(productArrivalPackageId),
        productId = Value(productId),
        amount = Value(amount);
  static Insertable<ProductArrivalPackageNewLine> custom({
    Expression<int>? id,
    Expression<int>? productArrivalPackageId,
    Expression<int>? productId,
    Expression<int>? amount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productArrivalPackageId != null)
        'product_arrival_package_id': productArrivalPackageId,
      if (productId != null) 'product_id': productId,
      if (amount != null) 'amount': amount,
    });
  }

  ProductArrivalPackageNewLinesCompanion copyWith(
      {Value<int>? id,
      Value<int>? productArrivalPackageId,
      Value<int>? productId,
      Value<int>? amount}) {
    return ProductArrivalPackageNewLinesCompanion(
      id: id ?? this.id,
      productArrivalPackageId:
          productArrivalPackageId ?? this.productArrivalPackageId,
      productId: productId ?? this.productId,
      amount: amount ?? this.amount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productArrivalPackageId.present) {
      map['product_arrival_package_id'] =
          Variable<int>(productArrivalPackageId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductArrivalPackageNewLinesCompanion(')
          ..write('id: $id, ')
          ..write('productArrivalPackageId: $productArrivalPackageId, ')
          ..write('productId: $productId, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }
}

class $ProductArrivalPackageNewLinesTable extends ProductArrivalPackageNewLines
    with
        TableInfo<$ProductArrivalPackageNewLinesTable,
            ProductArrivalPackageNewLine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductArrivalPackageNewLinesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _productArrivalPackageIdMeta =
      const VerificationMeta('productArrivalPackageId');
  @override
  late final GeneratedColumn<int?> productArrivalPackageId =
      GeneratedColumn<int?>('product_arrival_package_id', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: true,
          defaultConstraints:
              'REFERENCES product_arrival_packages (id) ON DELETE CASCADE');
  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int?> productId = GeneratedColumn<int?>(
      'product_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES products (id) ON DELETE CASCADE');
  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int?> amount = GeneratedColumn<int?>(
      'amount', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, productArrivalPackageId, productId, amount];
  @override
  String get aliasedName => _alias ?? 'product_arrival_package_new_lines';
  @override
  String get actualTableName => 'product_arrival_package_new_lines';
  @override
  VerificationContext validateIntegrity(
      Insertable<ProductArrivalPackageNewLine> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_arrival_package_id')) {
      context.handle(
          _productArrivalPackageIdMeta,
          productArrivalPackageId.isAcceptableOrUnknown(
              data['product_arrival_package_id']!,
              _productArrivalPackageIdMeta));
    } else if (isInserting) {
      context.missing(_productArrivalPackageIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductArrivalPackageNewLine map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    return ProductArrivalPackageNewLine.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ProductArrivalPackageNewLinesTable createAlias(String alias) {
    return $ProductArrivalPackageNewLinesTable(attachedDatabase, alias);
  }
}

class StorageCell extends DataClass implements Insertable<StorageCell> {
  final int id;
  final String name;
  StorageCell({required this.id, required this.name});
  factory StorageCell.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return StorageCell(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  StorageCellsCompanion toCompanion(bool nullToAbsent) {
    return StorageCellsCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory StorageCell.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StorageCell(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  StorageCell copyWith({int? id, String? name}) => StorageCell(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('StorageCell(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StorageCell && other.id == this.id && other.name == this.name);
}

class StorageCellsCompanion extends UpdateCompanion<StorageCell> {
  final Value<int> id;
  final Value<String> name;
  const StorageCellsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  StorageCellsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<StorageCell> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  StorageCellsCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return StorageCellsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StorageCellsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $StorageCellsTable extends StorageCells
    with TableInfo<$StorageCellsTable, StorageCell> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StorageCellsTable(this.attachedDatabase, [this._alias]);
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
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? 'storage_cells';
  @override
  String get actualTableName => 'storage_cells';
  @override
  VerificationContext validateIntegrity(Insertable<StorageCell> instance,
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StorageCell map(Map<String, dynamic> data, {String? tablePrefix}) {
    return StorageCell.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $StorageCellsTable createAlias(String alias) {
    return $StorageCellsTable(attachedDatabase, alias);
  }
}

class ProductArrivalPackageNewCell extends DataClass
    implements Insertable<ProductArrivalPackageNewCell> {
  final int id;
  final int productArrivalPackageId;
  final int productId;
  final int storageCellId;
  final int amount;
  ProductArrivalPackageNewCell(
      {required this.id,
      required this.productArrivalPackageId,
      required this.productId,
      required this.storageCellId,
      required this.amount});
  factory ProductArrivalPackageNewCell.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ProductArrivalPackageNewCell(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      productArrivalPackageId: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}product_arrival_package_id'])!,
      productId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}product_id'])!,
      storageCellId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}storage_cell_id'])!,
      amount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_arrival_package_id'] = Variable<int>(productArrivalPackageId);
    map['product_id'] = Variable<int>(productId);
    map['storage_cell_id'] = Variable<int>(storageCellId);
    map['amount'] = Variable<int>(amount);
    return map;
  }

  ProductArrivalPackageNewCellsCompanion toCompanion(bool nullToAbsent) {
    return ProductArrivalPackageNewCellsCompanion(
      id: Value(id),
      productArrivalPackageId: Value(productArrivalPackageId),
      productId: Value(productId),
      storageCellId: Value(storageCellId),
      amount: Value(amount),
    );
  }

  factory ProductArrivalPackageNewCell.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductArrivalPackageNewCell(
      id: serializer.fromJson<int>(json['id']),
      productArrivalPackageId:
          serializer.fromJson<int>(json['productArrivalPackageId']),
      productId: serializer.fromJson<int>(json['productId']),
      storageCellId: serializer.fromJson<int>(json['storageCellId']),
      amount: serializer.fromJson<int>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productArrivalPackageId':
          serializer.toJson<int>(productArrivalPackageId),
      'productId': serializer.toJson<int>(productId),
      'storageCellId': serializer.toJson<int>(storageCellId),
      'amount': serializer.toJson<int>(amount),
    };
  }

  ProductArrivalPackageNewCell copyWith(
          {int? id,
          int? productArrivalPackageId,
          int? productId,
          int? storageCellId,
          int? amount}) =>
      ProductArrivalPackageNewCell(
        id: id ?? this.id,
        productArrivalPackageId:
            productArrivalPackageId ?? this.productArrivalPackageId,
        productId: productId ?? this.productId,
        storageCellId: storageCellId ?? this.storageCellId,
        amount: amount ?? this.amount,
      );
  @override
  String toString() {
    return (StringBuffer('ProductArrivalPackageNewCell(')
          ..write('id: $id, ')
          ..write('productArrivalPackageId: $productArrivalPackageId, ')
          ..write('productId: $productId, ')
          ..write('storageCellId: $storageCellId, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, productArrivalPackageId, productId, storageCellId, amount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductArrivalPackageNewCell &&
          other.id == this.id &&
          other.productArrivalPackageId == this.productArrivalPackageId &&
          other.productId == this.productId &&
          other.storageCellId == this.storageCellId &&
          other.amount == this.amount);
}

class ProductArrivalPackageNewCellsCompanion
    extends UpdateCompanion<ProductArrivalPackageNewCell> {
  final Value<int> id;
  final Value<int> productArrivalPackageId;
  final Value<int> productId;
  final Value<int> storageCellId;
  final Value<int> amount;
  const ProductArrivalPackageNewCellsCompanion({
    this.id = const Value.absent(),
    this.productArrivalPackageId = const Value.absent(),
    this.productId = const Value.absent(),
    this.storageCellId = const Value.absent(),
    this.amount = const Value.absent(),
  });
  ProductArrivalPackageNewCellsCompanion.insert({
    this.id = const Value.absent(),
    required int productArrivalPackageId,
    required int productId,
    required int storageCellId,
    required int amount,
  })  : productArrivalPackageId = Value(productArrivalPackageId),
        productId = Value(productId),
        storageCellId = Value(storageCellId),
        amount = Value(amount);
  static Insertable<ProductArrivalPackageNewCell> custom({
    Expression<int>? id,
    Expression<int>? productArrivalPackageId,
    Expression<int>? productId,
    Expression<int>? storageCellId,
    Expression<int>? amount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productArrivalPackageId != null)
        'product_arrival_package_id': productArrivalPackageId,
      if (productId != null) 'product_id': productId,
      if (storageCellId != null) 'storage_cell_id': storageCellId,
      if (amount != null) 'amount': amount,
    });
  }

  ProductArrivalPackageNewCellsCompanion copyWith(
      {Value<int>? id,
      Value<int>? productArrivalPackageId,
      Value<int>? productId,
      Value<int>? storageCellId,
      Value<int>? amount}) {
    return ProductArrivalPackageNewCellsCompanion(
      id: id ?? this.id,
      productArrivalPackageId:
          productArrivalPackageId ?? this.productArrivalPackageId,
      productId: productId ?? this.productId,
      storageCellId: storageCellId ?? this.storageCellId,
      amount: amount ?? this.amount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productArrivalPackageId.present) {
      map['product_arrival_package_id'] =
          Variable<int>(productArrivalPackageId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (storageCellId.present) {
      map['storage_cell_id'] = Variable<int>(storageCellId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductArrivalPackageNewCellsCompanion(')
          ..write('id: $id, ')
          ..write('productArrivalPackageId: $productArrivalPackageId, ')
          ..write('productId: $productId, ')
          ..write('storageCellId: $storageCellId, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }
}

class $ProductArrivalPackageNewCellsTable extends ProductArrivalPackageNewCells
    with
        TableInfo<$ProductArrivalPackageNewCellsTable,
            ProductArrivalPackageNewCell> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductArrivalPackageNewCellsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _productArrivalPackageIdMeta =
      const VerificationMeta('productArrivalPackageId');
  @override
  late final GeneratedColumn<int?> productArrivalPackageId =
      GeneratedColumn<int?>('product_arrival_package_id', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: true,
          defaultConstraints:
              'REFERENCES product_arrival_packages (id) ON DELETE CASCADE');
  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int?> productId = GeneratedColumn<int?>(
      'product_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES products (id) ON DELETE CASCADE');
  final VerificationMeta _storageCellIdMeta =
      const VerificationMeta('storageCellId');
  @override
  late final GeneratedColumn<int?> storageCellId = GeneratedColumn<int?>(
      'storage_cell_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES storage_cells (id) ON DELETE CASCADE');
  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int?> amount = GeneratedColumn<int?>(
      'amount', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, productArrivalPackageId, productId, storageCellId, amount];
  @override
  String get aliasedName => _alias ?? 'product_arrival_package_new_cells';
  @override
  String get actualTableName => 'product_arrival_package_new_cells';
  @override
  VerificationContext validateIntegrity(
      Insertable<ProductArrivalPackageNewCell> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_arrival_package_id')) {
      context.handle(
          _productArrivalPackageIdMeta,
          productArrivalPackageId.isAcceptableOrUnknown(
              data['product_arrival_package_id']!,
              _productArrivalPackageIdMeta));
    } else if (isInserting) {
      context.missing(_productArrivalPackageIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('storage_cell_id')) {
      context.handle(
          _storageCellIdMeta,
          storageCellId.isAcceptableOrUnknown(
              data['storage_cell_id']!, _storageCellIdMeta));
    } else if (isInserting) {
      context.missing(_storageCellIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductArrivalPackageNewCell map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    return ProductArrivalPackageNewCell.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ProductArrivalPackageNewCellsTable createAlias(String alias) {
    return $ProductArrivalPackageNewCellsTable(attachedDatabase, alias);
  }
}

class ProductArrivalNewUnloadPackage extends DataClass
    implements Insertable<ProductArrivalNewUnloadPackage> {
  final int id;
  final int productArrivalId;
  final int amount;
  final int typeId;
  final String typeName;
  ProductArrivalNewUnloadPackage(
      {required this.id,
      required this.productArrivalId,
      required this.amount,
      required this.typeId,
      required this.typeName});
  factory ProductArrivalNewUnloadPackage.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ProductArrivalNewUnloadPackage(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      productArrivalId: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}product_arrival_id'])!,
      amount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount'])!,
      typeId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type_id'])!,
      typeName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type_name'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_arrival_id'] = Variable<int>(productArrivalId);
    map['amount'] = Variable<int>(amount);
    map['type_id'] = Variable<int>(typeId);
    map['type_name'] = Variable<String>(typeName);
    return map;
  }

  ProductArrivalNewUnloadPackagesCompanion toCompanion(bool nullToAbsent) {
    return ProductArrivalNewUnloadPackagesCompanion(
      id: Value(id),
      productArrivalId: Value(productArrivalId),
      amount: Value(amount),
      typeId: Value(typeId),
      typeName: Value(typeName),
    );
  }

  factory ProductArrivalNewUnloadPackage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductArrivalNewUnloadPackage(
      id: serializer.fromJson<int>(json['id']),
      productArrivalId: serializer.fromJson<int>(json['productArrivalId']),
      amount: serializer.fromJson<int>(json['amount']),
      typeId: serializer.fromJson<int>(json['typeId']),
      typeName: serializer.fromJson<String>(json['typeName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productArrivalId': serializer.toJson<int>(productArrivalId),
      'amount': serializer.toJson<int>(amount),
      'typeId': serializer.toJson<int>(typeId),
      'typeName': serializer.toJson<String>(typeName),
    };
  }

  ProductArrivalNewUnloadPackage copyWith(
          {int? id,
          int? productArrivalId,
          int? amount,
          int? typeId,
          String? typeName}) =>
      ProductArrivalNewUnloadPackage(
        id: id ?? this.id,
        productArrivalId: productArrivalId ?? this.productArrivalId,
        amount: amount ?? this.amount,
        typeId: typeId ?? this.typeId,
        typeName: typeName ?? this.typeName,
      );
  @override
  String toString() {
    return (StringBuffer('ProductArrivalNewUnloadPackage(')
          ..write('id: $id, ')
          ..write('productArrivalId: $productArrivalId, ')
          ..write('amount: $amount, ')
          ..write('typeId: $typeId, ')
          ..write('typeName: $typeName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, productArrivalId, amount, typeId, typeName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductArrivalNewUnloadPackage &&
          other.id == this.id &&
          other.productArrivalId == this.productArrivalId &&
          other.amount == this.amount &&
          other.typeId == this.typeId &&
          other.typeName == this.typeName);
}

class ProductArrivalNewUnloadPackagesCompanion
    extends UpdateCompanion<ProductArrivalNewUnloadPackage> {
  final Value<int> id;
  final Value<int> productArrivalId;
  final Value<int> amount;
  final Value<int> typeId;
  final Value<String> typeName;
  const ProductArrivalNewUnloadPackagesCompanion({
    this.id = const Value.absent(),
    this.productArrivalId = const Value.absent(),
    this.amount = const Value.absent(),
    this.typeId = const Value.absent(),
    this.typeName = const Value.absent(),
  });
  ProductArrivalNewUnloadPackagesCompanion.insert({
    this.id = const Value.absent(),
    required int productArrivalId,
    required int amount,
    required int typeId,
    required String typeName,
  })  : productArrivalId = Value(productArrivalId),
        amount = Value(amount),
        typeId = Value(typeId),
        typeName = Value(typeName);
  static Insertable<ProductArrivalNewUnloadPackage> custom({
    Expression<int>? id,
    Expression<int>? productArrivalId,
    Expression<int>? amount,
    Expression<int>? typeId,
    Expression<String>? typeName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productArrivalId != null) 'product_arrival_id': productArrivalId,
      if (amount != null) 'amount': amount,
      if (typeId != null) 'type_id': typeId,
      if (typeName != null) 'type_name': typeName,
    });
  }

  ProductArrivalNewUnloadPackagesCompanion copyWith(
      {Value<int>? id,
      Value<int>? productArrivalId,
      Value<int>? amount,
      Value<int>? typeId,
      Value<String>? typeName}) {
    return ProductArrivalNewUnloadPackagesCompanion(
      id: id ?? this.id,
      productArrivalId: productArrivalId ?? this.productArrivalId,
      amount: amount ?? this.amount,
      typeId: typeId ?? this.typeId,
      typeName: typeName ?? this.typeName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productArrivalId.present) {
      map['product_arrival_id'] = Variable<int>(productArrivalId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (typeId.present) {
      map['type_id'] = Variable<int>(typeId.value);
    }
    if (typeName.present) {
      map['type_name'] = Variable<String>(typeName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductArrivalNewUnloadPackagesCompanion(')
          ..write('id: $id, ')
          ..write('productArrivalId: $productArrivalId, ')
          ..write('amount: $amount, ')
          ..write('typeId: $typeId, ')
          ..write('typeName: $typeName')
          ..write(')'))
        .toString();
  }
}

class $ProductArrivalNewUnloadPackagesTable
    extends ProductArrivalNewUnloadPackages
    with
        TableInfo<$ProductArrivalNewUnloadPackagesTable,
            ProductArrivalNewUnloadPackage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductArrivalNewUnloadPackagesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _productArrivalIdMeta =
      const VerificationMeta('productArrivalId');
  @override
  late final GeneratedColumn<int?> productArrivalId = GeneratedColumn<int?>(
      'product_arrival_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES product_arrivals (id) ON DELETE CASCADE');
  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int?> amount = GeneratedColumn<int?>(
      'amount', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _typeIdMeta = const VerificationMeta('typeId');
  @override
  late final GeneratedColumn<int?> typeId = GeneratedColumn<int?>(
      'type_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _typeNameMeta = const VerificationMeta('typeName');
  @override
  late final GeneratedColumn<String?> typeName = GeneratedColumn<String?>(
      'type_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, productArrivalId, amount, typeId, typeName];
  @override
  String get aliasedName => _alias ?? 'product_arrival_new_unload_packages';
  @override
  String get actualTableName => 'product_arrival_new_unload_packages';
  @override
  VerificationContext validateIntegrity(
      Insertable<ProductArrivalNewUnloadPackage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_arrival_id')) {
      context.handle(
          _productArrivalIdMeta,
          productArrivalId.isAcceptableOrUnknown(
              data['product_arrival_id']!, _productArrivalIdMeta));
    } else if (isInserting) {
      context.missing(_productArrivalIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('type_id')) {
      context.handle(_typeIdMeta,
          typeId.isAcceptableOrUnknown(data['type_id']!, _typeIdMeta));
    } else if (isInserting) {
      context.missing(_typeIdMeta);
    }
    if (data.containsKey('type_name')) {
      context.handle(_typeNameMeta,
          typeName.isAcceptableOrUnknown(data['type_name']!, _typeNameMeta));
    } else if (isInserting) {
      context.missing(_typeNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductArrivalNewUnloadPackage map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    return ProductArrivalNewUnloadPackage.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ProductArrivalNewUnloadPackagesTable createAlias(String alias) {
    return $ProductArrivalNewUnloadPackagesTable(attachedDatabase, alias);
  }
}

class ProductStore extends DataClass implements Insertable<ProductStore> {
  final String id;
  final String name;
  ProductStore({required this.id, required this.name});
  factory ProductStore.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ProductStore(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  ProductStoresCompanion toCompanion(bool nullToAbsent) {
    return ProductStoresCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory ProductStore.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductStore(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  ProductStore copyWith({String? id, String? name}) => ProductStore(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('ProductStore(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductStore && other.id == this.id && other.name == this.name);
}

class ProductStoresCompanion extends UpdateCompanion<ProductStore> {
  final Value<String> id;
  final Value<String> name;
  const ProductStoresCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  ProductStoresCompanion.insert({
    required String id,
    required String name,
  })  : id = Value(id),
        name = Value(name);
  static Insertable<ProductStore> custom({
    Expression<String>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  ProductStoresCompanion copyWith({Value<String>? id, Value<String>? name}) {
    return ProductStoresCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductStoresCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $ProductStoresTable extends ProductStores
    with TableInfo<$ProductStoresTable, ProductStore> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductStoresTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? 'product_stores';
  @override
  String get actualTableName => 'product_stores';
  @override
  VerificationContext validateIntegrity(Insertable<ProductStore> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductStore map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ProductStore.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ProductStoresTable createAlias(String alias) {
    return $ProductStoresTable(attachedDatabase, alias);
  }
}

class ProductTransfer extends DataClass implements Insertable<ProductTransfer> {
  final int id;
  final String? storeFromId;
  final String? storeToId;
  final String? comment;
  final bool gatherFinished;
  ProductTransfer(
      {required this.id,
      this.storeFromId,
      this.storeToId,
      this.comment,
      required this.gatherFinished});
  factory ProductTransfer.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ProductTransfer(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      storeFromId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}store_from_id']),
      storeToId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}store_to_id']),
      comment: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}comment']),
      gatherFinished: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}gather_finished'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || storeFromId != null) {
      map['store_from_id'] = Variable<String?>(storeFromId);
    }
    if (!nullToAbsent || storeToId != null) {
      map['store_to_id'] = Variable<String?>(storeToId);
    }
    if (!nullToAbsent || comment != null) {
      map['comment'] = Variable<String?>(comment);
    }
    map['gather_finished'] = Variable<bool>(gatherFinished);
    return map;
  }

  ProductTransfersCompanion toCompanion(bool nullToAbsent) {
    return ProductTransfersCompanion(
      id: Value(id),
      storeFromId: storeFromId == null && nullToAbsent
          ? const Value.absent()
          : Value(storeFromId),
      storeToId: storeToId == null && nullToAbsent
          ? const Value.absent()
          : Value(storeToId),
      comment: comment == null && nullToAbsent
          ? const Value.absent()
          : Value(comment),
      gatherFinished: Value(gatherFinished),
    );
  }

  factory ProductTransfer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductTransfer(
      id: serializer.fromJson<int>(json['id']),
      storeFromId: serializer.fromJson<String?>(json['storeFromId']),
      storeToId: serializer.fromJson<String?>(json['storeToId']),
      comment: serializer.fromJson<String?>(json['comment']),
      gatherFinished: serializer.fromJson<bool>(json['gatherFinished']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'storeFromId': serializer.toJson<String?>(storeFromId),
      'storeToId': serializer.toJson<String?>(storeToId),
      'comment': serializer.toJson<String?>(comment),
      'gatherFinished': serializer.toJson<bool>(gatherFinished),
    };
  }

  ProductTransfer copyWith(
          {int? id,
          String? storeFromId,
          String? storeToId,
          String? comment,
          bool? gatherFinished}) =>
      ProductTransfer(
        id: id ?? this.id,
        storeFromId: storeFromId ?? this.storeFromId,
        storeToId: storeToId ?? this.storeToId,
        comment: comment ?? this.comment,
        gatherFinished: gatherFinished ?? this.gatherFinished,
      );
  @override
  String toString() {
    return (StringBuffer('ProductTransfer(')
          ..write('id: $id, ')
          ..write('storeFromId: $storeFromId, ')
          ..write('storeToId: $storeToId, ')
          ..write('comment: $comment, ')
          ..write('gatherFinished: $gatherFinished')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, storeFromId, storeToId, comment, gatherFinished);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductTransfer &&
          other.id == this.id &&
          other.storeFromId == this.storeFromId &&
          other.storeToId == this.storeToId &&
          other.comment == this.comment &&
          other.gatherFinished == this.gatherFinished);
}

class ProductTransfersCompanion extends UpdateCompanion<ProductTransfer> {
  final Value<int> id;
  final Value<String?> storeFromId;
  final Value<String?> storeToId;
  final Value<String?> comment;
  final Value<bool> gatherFinished;
  const ProductTransfersCompanion({
    this.id = const Value.absent(),
    this.storeFromId = const Value.absent(),
    this.storeToId = const Value.absent(),
    this.comment = const Value.absent(),
    this.gatherFinished = const Value.absent(),
  });
  ProductTransfersCompanion.insert({
    this.id = const Value.absent(),
    this.storeFromId = const Value.absent(),
    this.storeToId = const Value.absent(),
    this.comment = const Value.absent(),
    required bool gatherFinished,
  }) : gatherFinished = Value(gatherFinished);
  static Insertable<ProductTransfer> custom({
    Expression<int>? id,
    Expression<String?>? storeFromId,
    Expression<String?>? storeToId,
    Expression<String?>? comment,
    Expression<bool>? gatherFinished,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (storeFromId != null) 'store_from_id': storeFromId,
      if (storeToId != null) 'store_to_id': storeToId,
      if (comment != null) 'comment': comment,
      if (gatherFinished != null) 'gather_finished': gatherFinished,
    });
  }

  ProductTransfersCompanion copyWith(
      {Value<int>? id,
      Value<String?>? storeFromId,
      Value<String?>? storeToId,
      Value<String?>? comment,
      Value<bool>? gatherFinished}) {
    return ProductTransfersCompanion(
      id: id ?? this.id,
      storeFromId: storeFromId ?? this.storeFromId,
      storeToId: storeToId ?? this.storeToId,
      comment: comment ?? this.comment,
      gatherFinished: gatherFinished ?? this.gatherFinished,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (storeFromId.present) {
      map['store_from_id'] = Variable<String?>(storeFromId.value);
    }
    if (storeToId.present) {
      map['store_to_id'] = Variable<String?>(storeToId.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String?>(comment.value);
    }
    if (gatherFinished.present) {
      map['gather_finished'] = Variable<bool>(gatherFinished.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductTransfersCompanion(')
          ..write('id: $id, ')
          ..write('storeFromId: $storeFromId, ')
          ..write('storeToId: $storeToId, ')
          ..write('comment: $comment, ')
          ..write('gatherFinished: $gatherFinished')
          ..write(')'))
        .toString();
  }
}

class $ProductTransfersTable extends ProductTransfers
    with TableInfo<$ProductTransfersTable, ProductTransfer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductTransfersTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _storeFromIdMeta =
      const VerificationMeta('storeFromId');
  @override
  late final GeneratedColumn<String?> storeFromId = GeneratedColumn<String?>(
      'store_from_id', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES product_stores (id) ON DELETE CASCADE');
  final VerificationMeta _storeToIdMeta = const VerificationMeta('storeToId');
  @override
  late final GeneratedColumn<String?> storeToId = GeneratedColumn<String?>(
      'store_to_id', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES product_stores (id) ON DELETE CASCADE');
  final VerificationMeta _commentMeta = const VerificationMeta('comment');
  @override
  late final GeneratedColumn<String?> comment = GeneratedColumn<String?>(
      'comment', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _gatherFinishedMeta =
      const VerificationMeta('gatherFinished');
  @override
  late final GeneratedColumn<bool?> gatherFinished = GeneratedColumn<bool?>(
      'gather_finished', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (gather_finished IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns =>
      [id, storeFromId, storeToId, comment, gatherFinished];
  @override
  String get aliasedName => _alias ?? 'product_transfers';
  @override
  String get actualTableName => 'product_transfers';
  @override
  VerificationContext validateIntegrity(Insertable<ProductTransfer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('store_from_id')) {
      context.handle(
          _storeFromIdMeta,
          storeFromId.isAcceptableOrUnknown(
              data['store_from_id']!, _storeFromIdMeta));
    }
    if (data.containsKey('store_to_id')) {
      context.handle(
          _storeToIdMeta,
          storeToId.isAcceptableOrUnknown(
              data['store_to_id']!, _storeToIdMeta));
    }
    if (data.containsKey('comment')) {
      context.handle(_commentMeta,
          comment.isAcceptableOrUnknown(data['comment']!, _commentMeta));
    }
    if (data.containsKey('gather_finished')) {
      context.handle(
          _gatherFinishedMeta,
          gatherFinished.isAcceptableOrUnknown(
              data['gather_finished']!, _gatherFinishedMeta));
    } else if (isInserting) {
      context.missing(_gatherFinishedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductTransfer map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ProductTransfer.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ProductTransfersTable createAlias(String alias) {
    return $ProductTransfersTable(attachedDatabase, alias);
  }
}

class ProductTransferFromCell extends DataClass
    implements Insertable<ProductTransferFromCell> {
  final int id;
  final int productTransferId;
  final int productId;
  final int storageCellId;
  final int amount;
  ProductTransferFromCell(
      {required this.id,
      required this.productTransferId,
      required this.productId,
      required this.storageCellId,
      required this.amount});
  factory ProductTransferFromCell.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ProductTransferFromCell(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      productTransferId: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}product_transfer_id'])!,
      productId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}product_id'])!,
      storageCellId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}storage_cell_id'])!,
      amount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_transfer_id'] = Variable<int>(productTransferId);
    map['product_id'] = Variable<int>(productId);
    map['storage_cell_id'] = Variable<int>(storageCellId);
    map['amount'] = Variable<int>(amount);
    return map;
  }

  ProductTransferFromCellsCompanion toCompanion(bool nullToAbsent) {
    return ProductTransferFromCellsCompanion(
      id: Value(id),
      productTransferId: Value(productTransferId),
      productId: Value(productId),
      storageCellId: Value(storageCellId),
      amount: Value(amount),
    );
  }

  factory ProductTransferFromCell.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductTransferFromCell(
      id: serializer.fromJson<int>(json['id']),
      productTransferId: serializer.fromJson<int>(json['productTransferId']),
      productId: serializer.fromJson<int>(json['productId']),
      storageCellId: serializer.fromJson<int>(json['storageCellId']),
      amount: serializer.fromJson<int>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productTransferId': serializer.toJson<int>(productTransferId),
      'productId': serializer.toJson<int>(productId),
      'storageCellId': serializer.toJson<int>(storageCellId),
      'amount': serializer.toJson<int>(amount),
    };
  }

  ProductTransferFromCell copyWith(
          {int? id,
          int? productTransferId,
          int? productId,
          int? storageCellId,
          int? amount}) =>
      ProductTransferFromCell(
        id: id ?? this.id,
        productTransferId: productTransferId ?? this.productTransferId,
        productId: productId ?? this.productId,
        storageCellId: storageCellId ?? this.storageCellId,
        amount: amount ?? this.amount,
      );
  @override
  String toString() {
    return (StringBuffer('ProductTransferFromCell(')
          ..write('id: $id, ')
          ..write('productTransferId: $productTransferId, ')
          ..write('productId: $productId, ')
          ..write('storageCellId: $storageCellId, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, productTransferId, productId, storageCellId, amount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductTransferFromCell &&
          other.id == this.id &&
          other.productTransferId == this.productTransferId &&
          other.productId == this.productId &&
          other.storageCellId == this.storageCellId &&
          other.amount == this.amount);
}

class ProductTransferFromCellsCompanion
    extends UpdateCompanion<ProductTransferFromCell> {
  final Value<int> id;
  final Value<int> productTransferId;
  final Value<int> productId;
  final Value<int> storageCellId;
  final Value<int> amount;
  const ProductTransferFromCellsCompanion({
    this.id = const Value.absent(),
    this.productTransferId = const Value.absent(),
    this.productId = const Value.absent(),
    this.storageCellId = const Value.absent(),
    this.amount = const Value.absent(),
  });
  ProductTransferFromCellsCompanion.insert({
    this.id = const Value.absent(),
    required int productTransferId,
    required int productId,
    required int storageCellId,
    required int amount,
  })  : productTransferId = Value(productTransferId),
        productId = Value(productId),
        storageCellId = Value(storageCellId),
        amount = Value(amount);
  static Insertable<ProductTransferFromCell> custom({
    Expression<int>? id,
    Expression<int>? productTransferId,
    Expression<int>? productId,
    Expression<int>? storageCellId,
    Expression<int>? amount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productTransferId != null) 'product_transfer_id': productTransferId,
      if (productId != null) 'product_id': productId,
      if (storageCellId != null) 'storage_cell_id': storageCellId,
      if (amount != null) 'amount': amount,
    });
  }

  ProductTransferFromCellsCompanion copyWith(
      {Value<int>? id,
      Value<int>? productTransferId,
      Value<int>? productId,
      Value<int>? storageCellId,
      Value<int>? amount}) {
    return ProductTransferFromCellsCompanion(
      id: id ?? this.id,
      productTransferId: productTransferId ?? this.productTransferId,
      productId: productId ?? this.productId,
      storageCellId: storageCellId ?? this.storageCellId,
      amount: amount ?? this.amount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productTransferId.present) {
      map['product_transfer_id'] = Variable<int>(productTransferId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (storageCellId.present) {
      map['storage_cell_id'] = Variable<int>(storageCellId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductTransferFromCellsCompanion(')
          ..write('id: $id, ')
          ..write('productTransferId: $productTransferId, ')
          ..write('productId: $productId, ')
          ..write('storageCellId: $storageCellId, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }
}

class $ProductTransferFromCellsTable extends ProductTransferFromCells
    with TableInfo<$ProductTransferFromCellsTable, ProductTransferFromCell> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductTransferFromCellsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _productTransferIdMeta =
      const VerificationMeta('productTransferId');
  @override
  late final GeneratedColumn<int?> productTransferId = GeneratedColumn<int?>(
      'product_transfer_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints:
          'REFERENCES product_transfers (id) ON DELETE CASCADE');
  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int?> productId = GeneratedColumn<int?>(
      'product_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES products (id) ON DELETE CASCADE');
  final VerificationMeta _storageCellIdMeta =
      const VerificationMeta('storageCellId');
  @override
  late final GeneratedColumn<int?> storageCellId = GeneratedColumn<int?>(
      'storage_cell_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES storage_cells (id) ON DELETE CASCADE');
  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int?> amount = GeneratedColumn<int?>(
      'amount', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, productTransferId, productId, storageCellId, amount];
  @override
  String get aliasedName => _alias ?? 'product_transfer_from_cells';
  @override
  String get actualTableName => 'product_transfer_from_cells';
  @override
  VerificationContext validateIntegrity(
      Insertable<ProductTransferFromCell> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_transfer_id')) {
      context.handle(
          _productTransferIdMeta,
          productTransferId.isAcceptableOrUnknown(
              data['product_transfer_id']!, _productTransferIdMeta));
    } else if (isInserting) {
      context.missing(_productTransferIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('storage_cell_id')) {
      context.handle(
          _storageCellIdMeta,
          storageCellId.isAcceptableOrUnknown(
              data['storage_cell_id']!, _storageCellIdMeta));
    } else if (isInserting) {
      context.missing(_storageCellIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductTransferFromCell map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    return ProductTransferFromCell.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ProductTransferFromCellsTable createAlias(String alias) {
    return $ProductTransferFromCellsTable(attachedDatabase, alias);
  }
}

class ProductTransferToCell extends DataClass
    implements Insertable<ProductTransferToCell> {
  final int id;
  final int productTransferId;
  final int productId;
  final int storageCellId;
  final int amount;
  ProductTransferToCell(
      {required this.id,
      required this.productTransferId,
      required this.productId,
      required this.storageCellId,
      required this.amount});
  factory ProductTransferToCell.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ProductTransferToCell(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      productTransferId: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}product_transfer_id'])!,
      productId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}product_id'])!,
      storageCellId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}storage_cell_id'])!,
      amount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_transfer_id'] = Variable<int>(productTransferId);
    map['product_id'] = Variable<int>(productId);
    map['storage_cell_id'] = Variable<int>(storageCellId);
    map['amount'] = Variable<int>(amount);
    return map;
  }

  ProductTransferToCellsCompanion toCompanion(bool nullToAbsent) {
    return ProductTransferToCellsCompanion(
      id: Value(id),
      productTransferId: Value(productTransferId),
      productId: Value(productId),
      storageCellId: Value(storageCellId),
      amount: Value(amount),
    );
  }

  factory ProductTransferToCell.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductTransferToCell(
      id: serializer.fromJson<int>(json['id']),
      productTransferId: serializer.fromJson<int>(json['productTransferId']),
      productId: serializer.fromJson<int>(json['productId']),
      storageCellId: serializer.fromJson<int>(json['storageCellId']),
      amount: serializer.fromJson<int>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productTransferId': serializer.toJson<int>(productTransferId),
      'productId': serializer.toJson<int>(productId),
      'storageCellId': serializer.toJson<int>(storageCellId),
      'amount': serializer.toJson<int>(amount),
    };
  }

  ProductTransferToCell copyWith(
          {int? id,
          int? productTransferId,
          int? productId,
          int? storageCellId,
          int? amount}) =>
      ProductTransferToCell(
        id: id ?? this.id,
        productTransferId: productTransferId ?? this.productTransferId,
        productId: productId ?? this.productId,
        storageCellId: storageCellId ?? this.storageCellId,
        amount: amount ?? this.amount,
      );
  @override
  String toString() {
    return (StringBuffer('ProductTransferToCell(')
          ..write('id: $id, ')
          ..write('productTransferId: $productTransferId, ')
          ..write('productId: $productId, ')
          ..write('storageCellId: $storageCellId, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, productTransferId, productId, storageCellId, amount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductTransferToCell &&
          other.id == this.id &&
          other.productTransferId == this.productTransferId &&
          other.productId == this.productId &&
          other.storageCellId == this.storageCellId &&
          other.amount == this.amount);
}

class ProductTransferToCellsCompanion
    extends UpdateCompanion<ProductTransferToCell> {
  final Value<int> id;
  final Value<int> productTransferId;
  final Value<int> productId;
  final Value<int> storageCellId;
  final Value<int> amount;
  const ProductTransferToCellsCompanion({
    this.id = const Value.absent(),
    this.productTransferId = const Value.absent(),
    this.productId = const Value.absent(),
    this.storageCellId = const Value.absent(),
    this.amount = const Value.absent(),
  });
  ProductTransferToCellsCompanion.insert({
    this.id = const Value.absent(),
    required int productTransferId,
    required int productId,
    required int storageCellId,
    required int amount,
  })  : productTransferId = Value(productTransferId),
        productId = Value(productId),
        storageCellId = Value(storageCellId),
        amount = Value(amount);
  static Insertable<ProductTransferToCell> custom({
    Expression<int>? id,
    Expression<int>? productTransferId,
    Expression<int>? productId,
    Expression<int>? storageCellId,
    Expression<int>? amount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productTransferId != null) 'product_transfer_id': productTransferId,
      if (productId != null) 'product_id': productId,
      if (storageCellId != null) 'storage_cell_id': storageCellId,
      if (amount != null) 'amount': amount,
    });
  }

  ProductTransferToCellsCompanion copyWith(
      {Value<int>? id,
      Value<int>? productTransferId,
      Value<int>? productId,
      Value<int>? storageCellId,
      Value<int>? amount}) {
    return ProductTransferToCellsCompanion(
      id: id ?? this.id,
      productTransferId: productTransferId ?? this.productTransferId,
      productId: productId ?? this.productId,
      storageCellId: storageCellId ?? this.storageCellId,
      amount: amount ?? this.amount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productTransferId.present) {
      map['product_transfer_id'] = Variable<int>(productTransferId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (storageCellId.present) {
      map['storage_cell_id'] = Variable<int>(storageCellId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductTransferToCellsCompanion(')
          ..write('id: $id, ')
          ..write('productTransferId: $productTransferId, ')
          ..write('productId: $productId, ')
          ..write('storageCellId: $storageCellId, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }
}

class $ProductTransferToCellsTable extends ProductTransferToCells
    with TableInfo<$ProductTransferToCellsTable, ProductTransferToCell> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductTransferToCellsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _productTransferIdMeta =
      const VerificationMeta('productTransferId');
  @override
  late final GeneratedColumn<int?> productTransferId = GeneratedColumn<int?>(
      'product_transfer_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints:
          'REFERENCES product_transfers (id) ON DELETE CASCADE');
  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int?> productId = GeneratedColumn<int?>(
      'product_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES products (id) ON DELETE CASCADE');
  final VerificationMeta _storageCellIdMeta =
      const VerificationMeta('storageCellId');
  @override
  late final GeneratedColumn<int?> storageCellId = GeneratedColumn<int?>(
      'storage_cell_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES storage_cells (id) ON DELETE CASCADE');
  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int?> amount = GeneratedColumn<int?>(
      'amount', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, productTransferId, productId, storageCellId, amount];
  @override
  String get aliasedName => _alias ?? 'product_transfer_to_cells';
  @override
  String get actualTableName => 'product_transfer_to_cells';
  @override
  VerificationContext validateIntegrity(
      Insertable<ProductTransferToCell> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_transfer_id')) {
      context.handle(
          _productTransferIdMeta,
          productTransferId.isAcceptableOrUnknown(
              data['product_transfer_id']!, _productTransferIdMeta));
    } else if (isInserting) {
      context.missing(_productTransferIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('storage_cell_id')) {
      context.handle(
          _storageCellIdMeta,
          storageCellId.isAcceptableOrUnknown(
              data['storage_cell_id']!, _storageCellIdMeta));
    } else if (isInserting) {
      context.missing(_storageCellIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductTransferToCell map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ProductTransferToCell.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ProductTransferToCellsTable createAlias(String alias) {
    return $ProductTransferToCellsTable(attachedDatabase, alias);
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
    this.id = const Value.absent(),
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
  })  : trackingNumber = Value(trackingNumber),
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
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
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
      defaultConstraints: 'REFERENCES storages (id)');
  final VerificationMeta _storageToIdMeta =
      const VerificationMeta('storageToId');
  @override
  late final GeneratedColumn<int?> storageToId = GeneratedColumn<int?>(
      'storage_to_id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES storages (id)');
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
  Set<GeneratedColumn> get $primaryKey => {id};
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
      defaultConstraints: 'REFERENCES orders (id) ON DELETE CASCADE');
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

abstract class _$AppDataStore extends GeneratedDatabase {
  _$AppDataStore(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $UsersTable users = $UsersTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $StoragesTable storages = $StoragesTable(this);
  late final $ProductArrivalsTable productArrivals =
      $ProductArrivalsTable(this);
  late final $ProductArrivalPackagesTable productArrivalPackages =
      $ProductArrivalPackagesTable(this);
  late final $ProductArrivalLinesTable productArrivalLines =
      $ProductArrivalLinesTable(this);
  late final $ProductArrivalUnloadPackagesTable productArrivalUnloadPackages =
      $ProductArrivalUnloadPackagesTable(this);
  late final $ProductArrivalPackageTypesTable productArrivalPackageTypes =
      $ProductArrivalPackageTypesTable(this);
  late final $ProductArrivalPackageLinesTable productArrivalPackageLines =
      $ProductArrivalPackageLinesTable(this);
  late final $ProductArrivalNewPackagesTable productArrivalNewPackages =
      $ProductArrivalNewPackagesTable(this);
  late final $ProductArrivalPackageNewLinesTable productArrivalPackageNewLines =
      $ProductArrivalPackageNewLinesTable(this);
  late final $StorageCellsTable storageCells = $StorageCellsTable(this);
  late final $ProductArrivalPackageNewCellsTable productArrivalPackageNewCells =
      $ProductArrivalPackageNewCellsTable(this);
  late final $ProductArrivalNewUnloadPackagesTable
      productArrivalNewUnloadPackages =
      $ProductArrivalNewUnloadPackagesTable(this);
  late final $ProductStoresTable productStores = $ProductStoresTable(this);
  late final $ProductTransfersTable productTransfers =
      $ProductTransfersTable(this);
  late final $ProductTransferFromCellsTable productTransferFromCells =
      $ProductTransferFromCellsTable(this);
  late final $ProductTransferToCellsTable productTransferToCells =
      $ProductTransferToCellsTable(this);
  late final $OrdersTable orders = $OrdersTable(this);
  late final $OrderLinesTable orderLines = $OrderLinesTable(this);
  late final $ApiCredentialsTable apiCredentials = $ApiCredentialsTable(this);
  late final $PrefsTable prefs = $PrefsTable(this);
  late final ApiCredentialsDao apiCredentialsDao =
      ApiCredentialsDao(this as AppDataStore);
  late final OrdersDao ordersDao = OrdersDao(this as AppDataStore);
  late final ProductArrivalsDao productArrivalsDao =
      ProductArrivalsDao(this as AppDataStore);
  late final ProductTransfersDao productTransfersDao =
      ProductTransfersDao(this as AppDataStore);
  late final ProductsDao productsDao = ProductsDao(this as AppDataStore);
  late final StoragesDao storagesDao = StoragesDao(this as AppDataStore);
  late final UsersDao usersDao = UsersDao(this as AppDataStore);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        users,
        products,
        storages,
        productArrivals,
        productArrivalPackages,
        productArrivalLines,
        productArrivalUnloadPackages,
        productArrivalPackageTypes,
        productArrivalPackageLines,
        productArrivalNewPackages,
        productArrivalPackageNewLines,
        storageCells,
        productArrivalPackageNewCells,
        productArrivalNewUnloadPackages,
        productStores,
        productTransfers,
        productTransferFromCells,
        productTransferToCells,
        orders,
        orderLines,
        apiCredentials,
        prefs
      ];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$ApiCredentialsDaoMixin on DatabaseAccessor<AppDataStore> {
  $ApiCredentialsTable get apiCredentials => attachedDatabase.apiCredentials;
}
mixin _$ProductArrivalsDaoMixin on DatabaseAccessor<AppDataStore> {
  $ProductsTable get products => attachedDatabase.products;
  $StoragesTable get storages => attachedDatabase.storages;
  $ProductArrivalsTable get productArrivals => attachedDatabase.productArrivals;
  $ProductArrivalPackagesTable get productArrivalPackages =>
      attachedDatabase.productArrivalPackages;
  $ProductArrivalLinesTable get productArrivalLines =>
      attachedDatabase.productArrivalLines;
  $ProductArrivalUnloadPackagesTable get productArrivalUnloadPackages =>
      attachedDatabase.productArrivalUnloadPackages;
  $ProductArrivalPackageLinesTable get productArrivalPackageLines =>
      attachedDatabase.productArrivalPackageLines;
  $ProductArrivalPackageTypesTable get productArrivalPackageTypes =>
      attachedDatabase.productArrivalPackageTypes;
  $ProductArrivalPackageNewLinesTable get productArrivalPackageNewLines =>
      attachedDatabase.productArrivalPackageNewLines;
  $StorageCellsTable get storageCells => attachedDatabase.storageCells;
  $ProductArrivalPackageNewCellsTable get productArrivalPackageNewCells =>
      attachedDatabase.productArrivalPackageNewCells;
  $ProductArrivalNewPackagesTable get productArrivalNewPackages =>
      attachedDatabase.productArrivalNewPackages;
  $ProductArrivalNewUnloadPackagesTable get productArrivalNewUnloadPackages =>
      attachedDatabase.productArrivalNewUnloadPackages;
}
mixin _$ProductTransfersDaoMixin on DatabaseAccessor<AppDataStore> {
  $ProductsTable get products => attachedDatabase.products;
  $ProductStoresTable get productStores => attachedDatabase.productStores;
  $ProductTransfersTable get productTransfers =>
      attachedDatabase.productTransfers;
  $StorageCellsTable get storageCells => attachedDatabase.storageCells;
  $ProductTransferFromCellsTable get productTransferFromCells =>
      attachedDatabase.productTransferFromCells;
  $ProductTransferToCellsTable get productTransferToCells =>
      attachedDatabase.productTransferToCells;
}
mixin _$StoragesDaoMixin on DatabaseAccessor<AppDataStore> {
  $StoragesTable get storages => attachedDatabase.storages;
  $StorageCellsTable get storageCells => attachedDatabase.storageCells;
}
mixin _$OrdersDaoMixin on DatabaseAccessor<AppDataStore> {
  $StoragesTable get storages => attachedDatabase.storages;
  $OrdersTable get orders => attachedDatabase.orders;
  $OrderLinesTable get orderLines => attachedDatabase.orderLines;
}
mixin _$ProductsDaoMixin on DatabaseAccessor<AppDataStore> {
  $ProductsTable get products => attachedDatabase.products;
  $ProductStoresTable get productStores => attachedDatabase.productStores;
}
mixin _$UsersDaoMixin on DatabaseAccessor<AppDataStore> {
  $UsersTable get users => attachedDatabase.users;
}
