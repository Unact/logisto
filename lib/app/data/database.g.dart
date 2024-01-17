// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pickupStorageIdMeta =
      const VerificationMeta('pickupStorageId');
  @override
  late final GeneratedColumn<int> pickupStorageId = GeneratedColumn<int>(
      'pickup_storage_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _storageIdsMeta =
      const VerificationMeta('storageIds');
  @override
  late final GeneratedColumnWithTypeConverter<List<int>, String> storageIds =
      GeneratedColumn<String>('storage_ids', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<int>>($UsersTable.$converterstorageIds);
  static const VerificationMeta _versionMeta =
      const VerificationMeta('version');
  @override
  late final GeneratedColumn<String> version = GeneratedColumn<String>(
      'version', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
      'total', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, username, name, email, pickupStorageId, storageIds, version, total];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      pickupStorageId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pickup_storage_id']),
      storageIds: $UsersTable.$converterstorageIds.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}storage_ids'])!),
      version: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}version'])!,
      total: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }

  static TypeConverter<List<int>, String> $converterstorageIds =
      const JsonIntListConverter();
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String username;
  final String name;
  final String email;
  final int? pickupStorageId;
  final List<int> storageIds;
  final String version;
  final double total;
  const User(
      {required this.id,
      required this.username,
      required this.name,
      required this.email,
      this.pickupStorageId,
      required this.storageIds,
      required this.version,
      required this.total});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    if (!nullToAbsent || pickupStorageId != null) {
      map['pickup_storage_id'] = Variable<int>(pickupStorageId);
    }
    {
      final converter = $UsersTable.$converterstorageIds;
      map['storage_ids'] = Variable<String>(converter.toSql(storageIds));
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
          Value<int?> pickupStorageId = const Value.absent(),
          List<int>? storageIds,
          String? version,
          double? total}) =>
      User(
        id: id ?? this.id,
        username: username ?? this.username,
        name: name ?? this.name,
        email: email ?? this.email,
        pickupStorageId: pickupStorageId.present
            ? pickupStorageId.value
            : this.pickupStorageId,
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
    Expression<int>? pickupStorageId,
    Expression<String>? storageIds,
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
      map['pickup_storage_id'] = Variable<int>(pickupStorageId.value);
    }
    if (storageIds.present) {
      final converter = $UsersTable.$converterstorageIds;

      map['storage_ids'] = Variable<String>(converter.toSql(storageIds.value));
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

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _groupNameMeta =
      const VerificationMeta('groupName');
  @override
  late final GeneratedColumn<String> groupName = GeneratedColumn<String>(
      'group_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _articleMeta =
      const VerificationMeta('article');
  @override
  late final GeneratedColumn<String> article = GeneratedColumn<String>(
      'article', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lengthMeta = const VerificationMeta('length');
  @override
  late final GeneratedColumn<int> length = GeneratedColumn<int>(
      'length', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<int> width = GeneratedColumn<int>(
      'width', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<int> height = GeneratedColumn<int>(
      'height', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
      'weight', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _archivedMeta =
      const VerificationMeta('archived');
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
      'archived', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("archived" IN (0, 1))'));
  static const VerificationMeta _needMarkingMeta =
      const VerificationMeta('needMarking');
  @override
  late final GeneratedColumn<bool> needMarking = GeneratedColumn<bool>(
      'need_marking', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("need_marking" IN (0, 1))'));
  static const VerificationMeta _inPackageMeta =
      const VerificationMeta('inPackage');
  @override
  late final GeneratedColumn<bool> inPackage = GeneratedColumn<bool>(
      'in_package', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("in_package" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        groupName,
        article,
        length,
        width,
        height,
        weight,
        archived,
        needMarking,
        inPackage
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
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
    if (data.containsKey('group_name')) {
      context.handle(_groupNameMeta,
          groupName.isAcceptableOrUnknown(data['group_name']!, _groupNameMeta));
    } else if (isInserting) {
      context.missing(_groupNameMeta);
    }
    if (data.containsKey('article')) {
      context.handle(_articleMeta,
          article.isAcceptableOrUnknown(data['article']!, _articleMeta));
    }
    if (data.containsKey('length')) {
      context.handle(_lengthMeta,
          length.isAcceptableOrUnknown(data['length']!, _lengthMeta));
    }
    if (data.containsKey('width')) {
      context.handle(
          _widthMeta, width.isAcceptableOrUnknown(data['width']!, _widthMeta));
    }
    if (data.containsKey('height')) {
      context.handle(_heightMeta,
          height.isAcceptableOrUnknown(data['height']!, _heightMeta));
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    if (data.containsKey('archived')) {
      context.handle(_archivedMeta,
          archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta));
    } else if (isInserting) {
      context.missing(_archivedMeta);
    }
    if (data.containsKey('need_marking')) {
      context.handle(
          _needMarkingMeta,
          needMarking.isAcceptableOrUnknown(
              data['need_marking']!, _needMarkingMeta));
    } else if (isInserting) {
      context.missing(_needMarkingMeta);
    }
    if (data.containsKey('in_package')) {
      context.handle(_inPackageMeta,
          inPackage.isAcceptableOrUnknown(data['in_package']!, _inPackageMeta));
    } else if (isInserting) {
      context.missing(_inPackageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      groupName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_name'])!,
      article: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}article']),
      length: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}length']),
      width: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}width']),
      height: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}height']),
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}weight']),
      archived: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}archived'])!,
      needMarking: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}need_marking'])!,
      inPackage: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}in_package'])!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final int id;
  final String name;
  final String groupName;
  final String? article;
  final int? length;
  final int? width;
  final int? height;
  final int? weight;
  final bool archived;
  final bool needMarking;
  final bool inPackage;
  const Product(
      {required this.id,
      required this.name,
      required this.groupName,
      this.article,
      this.length,
      this.width,
      this.height,
      this.weight,
      required this.archived,
      required this.needMarking,
      required this.inPackage});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['group_name'] = Variable<String>(groupName);
    if (!nullToAbsent || article != null) {
      map['article'] = Variable<String>(article);
    }
    if (!nullToAbsent || length != null) {
      map['length'] = Variable<int>(length);
    }
    if (!nullToAbsent || width != null) {
      map['width'] = Variable<int>(width);
    }
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<int>(height);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<int>(weight);
    }
    map['archived'] = Variable<bool>(archived);
    map['need_marking'] = Variable<bool>(needMarking);
    map['in_package'] = Variable<bool>(inPackage);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      name: Value(name),
      groupName: Value(groupName),
      article: article == null && nullToAbsent
          ? const Value.absent()
          : Value(article),
      length:
          length == null && nullToAbsent ? const Value.absent() : Value(length),
      width:
          width == null && nullToAbsent ? const Value.absent() : Value(width),
      height:
          height == null && nullToAbsent ? const Value.absent() : Value(height),
      weight:
          weight == null && nullToAbsent ? const Value.absent() : Value(weight),
      archived: Value(archived),
      needMarking: Value(needMarking),
      inPackage: Value(inPackage),
    );
  }

  factory Product.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      groupName: serializer.fromJson<String>(json['groupName']),
      article: serializer.fromJson<String?>(json['article']),
      length: serializer.fromJson<int?>(json['length']),
      width: serializer.fromJson<int?>(json['width']),
      height: serializer.fromJson<int?>(json['height']),
      weight: serializer.fromJson<int?>(json['weight']),
      archived: serializer.fromJson<bool>(json['archived']),
      needMarking: serializer.fromJson<bool>(json['needMarking']),
      inPackage: serializer.fromJson<bool>(json['inPackage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'groupName': serializer.toJson<String>(groupName),
      'article': serializer.toJson<String?>(article),
      'length': serializer.toJson<int?>(length),
      'width': serializer.toJson<int?>(width),
      'height': serializer.toJson<int?>(height),
      'weight': serializer.toJson<int?>(weight),
      'archived': serializer.toJson<bool>(archived),
      'needMarking': serializer.toJson<bool>(needMarking),
      'inPackage': serializer.toJson<bool>(inPackage),
    };
  }

  Product copyWith(
          {int? id,
          String? name,
          String? groupName,
          Value<String?> article = const Value.absent(),
          Value<int?> length = const Value.absent(),
          Value<int?> width = const Value.absent(),
          Value<int?> height = const Value.absent(),
          Value<int?> weight = const Value.absent(),
          bool? archived,
          bool? needMarking,
          bool? inPackage}) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        groupName: groupName ?? this.groupName,
        article: article.present ? article.value : this.article,
        length: length.present ? length.value : this.length,
        width: width.present ? width.value : this.width,
        height: height.present ? height.value : this.height,
        weight: weight.present ? weight.value : this.weight,
        archived: archived ?? this.archived,
        needMarking: needMarking ?? this.needMarking,
        inPackage: inPackage ?? this.inPackage,
      );
  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('groupName: $groupName, ')
          ..write('article: $article, ')
          ..write('length: $length, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('weight: $weight, ')
          ..write('archived: $archived, ')
          ..write('needMarking: $needMarking, ')
          ..write('inPackage: $inPackage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, groupName, article, length, width,
      height, weight, archived, needMarking, inPackage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.name == this.name &&
          other.groupName == this.groupName &&
          other.article == this.article &&
          other.length == this.length &&
          other.width == this.width &&
          other.height == this.height &&
          other.weight == this.weight &&
          other.archived == this.archived &&
          other.needMarking == this.needMarking &&
          other.inPackage == this.inPackage);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> groupName;
  final Value<String?> article;
  final Value<int?> length;
  final Value<int?> width;
  final Value<int?> height;
  final Value<int?> weight;
  final Value<bool> archived;
  final Value<bool> needMarking;
  final Value<bool> inPackage;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.groupName = const Value.absent(),
    this.article = const Value.absent(),
    this.length = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.weight = const Value.absent(),
    this.archived = const Value.absent(),
    this.needMarking = const Value.absent(),
    this.inPackage = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String groupName,
    this.article = const Value.absent(),
    this.length = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.weight = const Value.absent(),
    required bool archived,
    required bool needMarking,
    required bool inPackage,
  })  : name = Value(name),
        groupName = Value(groupName),
        archived = Value(archived),
        needMarking = Value(needMarking),
        inPackage = Value(inPackage);
  static Insertable<Product> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? groupName,
    Expression<String>? article,
    Expression<int>? length,
    Expression<int>? width,
    Expression<int>? height,
    Expression<int>? weight,
    Expression<bool>? archived,
    Expression<bool>? needMarking,
    Expression<bool>? inPackage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (groupName != null) 'group_name': groupName,
      if (article != null) 'article': article,
      if (length != null) 'length': length,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (weight != null) 'weight': weight,
      if (archived != null) 'archived': archived,
      if (needMarking != null) 'need_marking': needMarking,
      if (inPackage != null) 'in_package': inPackage,
    });
  }

  ProductsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? groupName,
      Value<String?>? article,
      Value<int?>? length,
      Value<int?>? width,
      Value<int?>? height,
      Value<int?>? weight,
      Value<bool>? archived,
      Value<bool>? needMarking,
      Value<bool>? inPackage}) {
    return ProductsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      groupName: groupName ?? this.groupName,
      article: article ?? this.article,
      length: length ?? this.length,
      width: width ?? this.width,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      archived: archived ?? this.archived,
      needMarking: needMarking ?? this.needMarking,
      inPackage: inPackage ?? this.inPackage,
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
    if (groupName.present) {
      map['group_name'] = Variable<String>(groupName.value);
    }
    if (article.present) {
      map['article'] = Variable<String>(article.value);
    }
    if (length.present) {
      map['length'] = Variable<int>(length.value);
    }
    if (width.present) {
      map['width'] = Variable<int>(width.value);
    }
    if (height.present) {
      map['height'] = Variable<int>(height.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (needMarking.present) {
      map['need_marking'] = Variable<bool>(needMarking.value);
    }
    if (inPackage.present) {
      map['in_package'] = Variable<bool>(inPackage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('groupName: $groupName, ')
          ..write('article: $article, ')
          ..write('length: $length, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('weight: $weight, ')
          ..write('archived: $archived, ')
          ..write('needMarking: $needMarking, ')
          ..write('inPackage: $inPackage')
          ..write(')'))
        .toString();
  }
}

class $StoragesTable extends Storages with TableInfo<$StoragesTable, Storage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StoragesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sequenceNumberMeta =
      const VerificationMeta('sequenceNumber');
  @override
  late final GeneratedColumn<int> sequenceNumber = GeneratedColumn<int>(
      'sequence_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, sequenceNumber];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'storages';
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Storage(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      sequenceNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sequence_number'])!,
    );
  }

  @override
  $StoragesTable createAlias(String alias) {
    return $StoragesTable(attachedDatabase, alias);
  }
}

class Storage extends DataClass implements Insertable<Storage> {
  final int id;
  final String name;
  final int sequenceNumber;
  const Storage(
      {required this.id, required this.name, required this.sequenceNumber});
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

class $ProductArrivalsTable extends ProductArrivals
    with TableInfo<$ProductArrivalsTable, ProductArrival> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductArrivalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _arrivalDateMeta =
      const VerificationMeta('arrivalDate');
  @override
  late final GeneratedColumn<DateTime> arrivalDate = GeneratedColumn<DateTime>(
      'arrival_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
      'number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _unloadStartMeta =
      const VerificationMeta('unloadStart');
  @override
  late final GeneratedColumn<DateTime> unloadStart = GeneratedColumn<DateTime>(
      'unload_start', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _unloadEndMeta =
      const VerificationMeta('unloadEnd');
  @override
  late final GeneratedColumn<DateTime> unloadEnd = GeneratedColumn<DateTime>(
      'unload_end', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _storageIdMeta =
      const VerificationMeta('storageId');
  @override
  late final GeneratedColumn<int> storageId = GeneratedColumn<int>(
      'storage_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES storages (id)'));
  static const VerificationMeta _storeNameMeta =
      const VerificationMeta('storeName');
  @override
  late final GeneratedColumn<String> storeName = GeneratedColumn<String>(
      'store_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sellerNameMeta =
      const VerificationMeta('sellerName');
  @override
  late final GeneratedColumn<String> sellerName = GeneratedColumn<String>(
      'seller_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusNameMeta =
      const VerificationMeta('statusName');
  @override
  late final GeneratedColumn<String> statusName = GeneratedColumn<String>(
      'status_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderTrackingNumberMeta =
      const VerificationMeta('orderTrackingNumber');
  @override
  late final GeneratedColumn<String> orderTrackingNumber =
      GeneratedColumn<String>('order_tracking_number', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _commentMeta =
      const VerificationMeta('comment');
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
      'comment', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_arrivals';
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductArrival(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      arrivalDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}arrival_date'])!,
      number: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}number'])!,
      unloadStart: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}unload_start']),
      unloadEnd: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}unload_end']),
      storageId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}storage_id']),
      storeName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}store_name'])!,
      sellerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}seller_name'])!,
      statusName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status_name'])!,
      orderTrackingNumber: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}order_tracking_number']),
      comment: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}comment']),
    );
  }

  @override
  $ProductArrivalsTable createAlias(String alias) {
    return $ProductArrivalsTable(attachedDatabase, alias);
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
  const ProductArrival(
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['arrival_date'] = Variable<DateTime>(arrivalDate);
    map['number'] = Variable<String>(number);
    if (!nullToAbsent || unloadStart != null) {
      map['unload_start'] = Variable<DateTime>(unloadStart);
    }
    if (!nullToAbsent || unloadEnd != null) {
      map['unload_end'] = Variable<DateTime>(unloadEnd);
    }
    if (!nullToAbsent || storageId != null) {
      map['storage_id'] = Variable<int>(storageId);
    }
    map['store_name'] = Variable<String>(storeName);
    map['seller_name'] = Variable<String>(sellerName);
    map['status_name'] = Variable<String>(statusName);
    if (!nullToAbsent || orderTrackingNumber != null) {
      map['order_tracking_number'] = Variable<String>(orderTrackingNumber);
    }
    if (!nullToAbsent || comment != null) {
      map['comment'] = Variable<String>(comment);
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
          Value<DateTime?> unloadStart = const Value.absent(),
          Value<DateTime?> unloadEnd = const Value.absent(),
          Value<int?> storageId = const Value.absent(),
          String? storeName,
          String? sellerName,
          String? statusName,
          Value<String?> orderTrackingNumber = const Value.absent(),
          Value<String?> comment = const Value.absent()}) =>
      ProductArrival(
        id: id ?? this.id,
        arrivalDate: arrivalDate ?? this.arrivalDate,
        number: number ?? this.number,
        unloadStart: unloadStart.present ? unloadStart.value : this.unloadStart,
        unloadEnd: unloadEnd.present ? unloadEnd.value : this.unloadEnd,
        storageId: storageId.present ? storageId.value : this.storageId,
        storeName: storeName ?? this.storeName,
        sellerName: sellerName ?? this.sellerName,
        statusName: statusName ?? this.statusName,
        orderTrackingNumber: orderTrackingNumber.present
            ? orderTrackingNumber.value
            : this.orderTrackingNumber,
        comment: comment.present ? comment.value : this.comment,
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
    Expression<DateTime>? unloadStart,
    Expression<DateTime>? unloadEnd,
    Expression<int>? storageId,
    Expression<String>? storeName,
    Expression<String>? sellerName,
    Expression<String>? statusName,
    Expression<String>? orderTrackingNumber,
    Expression<String>? comment,
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
      map['unload_start'] = Variable<DateTime>(unloadStart.value);
    }
    if (unloadEnd.present) {
      map['unload_end'] = Variable<DateTime>(unloadEnd.value);
    }
    if (storageId.present) {
      map['storage_id'] = Variable<int>(storageId.value);
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
          Variable<String>(orderTrackingNumber.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
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

class $ProductArrivalPackagesTable extends ProductArrivalPackages
    with TableInfo<$ProductArrivalPackagesTable, ProductArrivalPackage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductArrivalPackagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _productArrivalIdMeta =
      const VerificationMeta('productArrivalId');
  @override
  late final GeneratedColumn<int> productArrivalId = GeneratedColumn<int>(
      'product_arrival_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES product_arrivals (id) ON DELETE CASCADE'));
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
      'number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeNameMeta =
      const VerificationMeta('typeName');
  @override
  late final GeneratedColumn<String> typeName = GeneratedColumn<String>(
      'type_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _qrMeta = const VerificationMeta('qr');
  @override
  late final GeneratedColumn<String> qr = GeneratedColumn<String>(
      'qr', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _acceptStartMeta =
      const VerificationMeta('acceptStart');
  @override
  late final GeneratedColumn<DateTime> acceptStart = GeneratedColumn<DateTime>(
      'accept_start', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _acceptEndMeta =
      const VerificationMeta('acceptEnd');
  @override
  late final GeneratedColumn<DateTime> acceptEnd = GeneratedColumn<DateTime>(
      'accept_end', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _placedMeta = const VerificationMeta('placed');
  @override
  late final GeneratedColumn<DateTime> placed = GeneratedColumn<DateTime>(
      'placed', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _markingScannedMeta =
      const VerificationMeta('markingScanned');
  @override
  late final GeneratedColumn<DateTime> markingScanned =
      GeneratedColumn<DateTime>('marking_scanned', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _needMarkingScanMeta =
      const VerificationMeta('needMarkingScan');
  @override
  late final GeneratedColumn<bool> needMarkingScan = GeneratedColumn<bool>(
      'need_marking_scan', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("need_marking_scan" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        productArrivalId,
        number,
        typeName,
        qr,
        acceptStart,
        acceptEnd,
        placed,
        markingScanned,
        needMarkingScan
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_arrival_packages';
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
    if (data.containsKey('marking_scanned')) {
      context.handle(
          _markingScannedMeta,
          markingScanned.isAcceptableOrUnknown(
              data['marking_scanned']!, _markingScannedMeta));
    }
    if (data.containsKey('need_marking_scan')) {
      context.handle(
          _needMarkingScanMeta,
          needMarkingScan.isAcceptableOrUnknown(
              data['need_marking_scan']!, _needMarkingScanMeta));
    } else if (isInserting) {
      context.missing(_needMarkingScanMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductArrivalPackage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductArrivalPackage(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      productArrivalId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}product_arrival_id'])!,
      number: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}number'])!,
      typeName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type_name'])!,
      qr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}qr'])!,
      acceptStart: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}accept_start']),
      acceptEnd: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}accept_end']),
      placed: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}placed']),
      markingScanned: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}marking_scanned']),
      needMarkingScan: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}need_marking_scan'])!,
    );
  }

  @override
  $ProductArrivalPackagesTable createAlias(String alias) {
    return $ProductArrivalPackagesTable(attachedDatabase, alias);
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
  final DateTime? markingScanned;
  final bool needMarkingScan;
  const ProductArrivalPackage(
      {required this.id,
      required this.productArrivalId,
      required this.number,
      required this.typeName,
      required this.qr,
      this.acceptStart,
      this.acceptEnd,
      this.placed,
      this.markingScanned,
      required this.needMarkingScan});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_arrival_id'] = Variable<int>(productArrivalId);
    map['number'] = Variable<String>(number);
    map['type_name'] = Variable<String>(typeName);
    map['qr'] = Variable<String>(qr);
    if (!nullToAbsent || acceptStart != null) {
      map['accept_start'] = Variable<DateTime>(acceptStart);
    }
    if (!nullToAbsent || acceptEnd != null) {
      map['accept_end'] = Variable<DateTime>(acceptEnd);
    }
    if (!nullToAbsent || placed != null) {
      map['placed'] = Variable<DateTime>(placed);
    }
    if (!nullToAbsent || markingScanned != null) {
      map['marking_scanned'] = Variable<DateTime>(markingScanned);
    }
    map['need_marking_scan'] = Variable<bool>(needMarkingScan);
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
      markingScanned: markingScanned == null && nullToAbsent
          ? const Value.absent()
          : Value(markingScanned),
      needMarkingScan: Value(needMarkingScan),
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
      markingScanned: serializer.fromJson<DateTime?>(json['markingScanned']),
      needMarkingScan: serializer.fromJson<bool>(json['needMarkingScan']),
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
      'markingScanned': serializer.toJson<DateTime?>(markingScanned),
      'needMarkingScan': serializer.toJson<bool>(needMarkingScan),
    };
  }

  ProductArrivalPackage copyWith(
          {int? id,
          int? productArrivalId,
          String? number,
          String? typeName,
          String? qr,
          Value<DateTime?> acceptStart = const Value.absent(),
          Value<DateTime?> acceptEnd = const Value.absent(),
          Value<DateTime?> placed = const Value.absent(),
          Value<DateTime?> markingScanned = const Value.absent(),
          bool? needMarkingScan}) =>
      ProductArrivalPackage(
        id: id ?? this.id,
        productArrivalId: productArrivalId ?? this.productArrivalId,
        number: number ?? this.number,
        typeName: typeName ?? this.typeName,
        qr: qr ?? this.qr,
        acceptStart: acceptStart.present ? acceptStart.value : this.acceptStart,
        acceptEnd: acceptEnd.present ? acceptEnd.value : this.acceptEnd,
        placed: placed.present ? placed.value : this.placed,
        markingScanned:
            markingScanned.present ? markingScanned.value : this.markingScanned,
        needMarkingScan: needMarkingScan ?? this.needMarkingScan,
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
          ..write('placed: $placed, ')
          ..write('markingScanned: $markingScanned, ')
          ..write('needMarkingScan: $needMarkingScan')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, productArrivalId, number, typeName, qr,
      acceptStart, acceptEnd, placed, markingScanned, needMarkingScan);
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
          other.placed == this.placed &&
          other.markingScanned == this.markingScanned &&
          other.needMarkingScan == this.needMarkingScan);
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
  final Value<DateTime?> markingScanned;
  final Value<bool> needMarkingScan;
  const ProductArrivalPackagesCompanion({
    this.id = const Value.absent(),
    this.productArrivalId = const Value.absent(),
    this.number = const Value.absent(),
    this.typeName = const Value.absent(),
    this.qr = const Value.absent(),
    this.acceptStart = const Value.absent(),
    this.acceptEnd = const Value.absent(),
    this.placed = const Value.absent(),
    this.markingScanned = const Value.absent(),
    this.needMarkingScan = const Value.absent(),
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
    this.markingScanned = const Value.absent(),
    required bool needMarkingScan,
  })  : productArrivalId = Value(productArrivalId),
        number = Value(number),
        typeName = Value(typeName),
        qr = Value(qr),
        needMarkingScan = Value(needMarkingScan);
  static Insertable<ProductArrivalPackage> custom({
    Expression<int>? id,
    Expression<int>? productArrivalId,
    Expression<String>? number,
    Expression<String>? typeName,
    Expression<String>? qr,
    Expression<DateTime>? acceptStart,
    Expression<DateTime>? acceptEnd,
    Expression<DateTime>? placed,
    Expression<DateTime>? markingScanned,
    Expression<bool>? needMarkingScan,
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
      if (markingScanned != null) 'marking_scanned': markingScanned,
      if (needMarkingScan != null) 'need_marking_scan': needMarkingScan,
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
      Value<DateTime?>? placed,
      Value<DateTime?>? markingScanned,
      Value<bool>? needMarkingScan}) {
    return ProductArrivalPackagesCompanion(
      id: id ?? this.id,
      productArrivalId: productArrivalId ?? this.productArrivalId,
      number: number ?? this.number,
      typeName: typeName ?? this.typeName,
      qr: qr ?? this.qr,
      acceptStart: acceptStart ?? this.acceptStart,
      acceptEnd: acceptEnd ?? this.acceptEnd,
      placed: placed ?? this.placed,
      markingScanned: markingScanned ?? this.markingScanned,
      needMarkingScan: needMarkingScan ?? this.needMarkingScan,
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
      map['accept_start'] = Variable<DateTime>(acceptStart.value);
    }
    if (acceptEnd.present) {
      map['accept_end'] = Variable<DateTime>(acceptEnd.value);
    }
    if (placed.present) {
      map['placed'] = Variable<DateTime>(placed.value);
    }
    if (markingScanned.present) {
      map['marking_scanned'] = Variable<DateTime>(markingScanned.value);
    }
    if (needMarkingScan.present) {
      map['need_marking_scan'] = Variable<bool>(needMarkingScan.value);
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
          ..write('placed: $placed, ')
          ..write('markingScanned: $markingScanned, ')
          ..write('needMarkingScan: $needMarkingScan')
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
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _productArrivalIdMeta =
      const VerificationMeta('productArrivalId');
  @override
  late final GeneratedColumn<int> productArrivalId = GeneratedColumn<int>(
      'product_arrival_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES product_arrival_packages (id) ON DELETE CASCADE'));
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES products (id) ON DELETE CASCADE'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _enumeratePieceMeta =
      const VerificationMeta('enumeratePiece');
  @override
  late final GeneratedColumn<bool> enumeratePiece = GeneratedColumn<bool>(
      'enumerate_piece', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("enumerate_piece" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, productArrivalId, productId, amount, enumeratePiece];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_arrival_lines';
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductArrivalLine(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      productArrivalId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}product_arrival_id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      enumeratePiece: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}enumerate_piece'])!,
    );
  }

  @override
  $ProductArrivalLinesTable createAlias(String alias) {
    return $ProductArrivalLinesTable(attachedDatabase, alias);
  }
}

class ProductArrivalLine extends DataClass
    implements Insertable<ProductArrivalLine> {
  final int id;
  final int productArrivalId;
  final int productId;
  final int amount;
  final bool enumeratePiece;
  const ProductArrivalLine(
      {required this.id,
      required this.productArrivalId,
      required this.productId,
      required this.amount,
      required this.enumeratePiece});
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

class $ProductArrivalUnloadPackagesTable extends ProductArrivalUnloadPackages
    with
        TableInfo<$ProductArrivalUnloadPackagesTable,
            ProductArrivalUnloadPackage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductArrivalUnloadPackagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _productArrivalIdMeta =
      const VerificationMeta('productArrivalId');
  @override
  late final GeneratedColumn<int> productArrivalId = GeneratedColumn<int>(
      'product_arrival_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES product_arrivals (id) ON DELETE CASCADE'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _typeNameMeta =
      const VerificationMeta('typeName');
  @override
  late final GeneratedColumn<String> typeName = GeneratedColumn<String>(
      'type_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, productArrivalId, amount, typeName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_arrival_unload_packages';
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductArrivalUnloadPackage(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      productArrivalId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}product_arrival_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      typeName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type_name'])!,
    );
  }

  @override
  $ProductArrivalUnloadPackagesTable createAlias(String alias) {
    return $ProductArrivalUnloadPackagesTable(attachedDatabase, alias);
  }
}

class ProductArrivalUnloadPackage extends DataClass
    implements Insertable<ProductArrivalUnloadPackage> {
  final int id;
  final int productArrivalId;
  final int amount;
  final String typeName;
  const ProductArrivalUnloadPackage(
      {required this.id,
      required this.productArrivalId,
      required this.amount,
      required this.typeName});
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

class $ProductArrivalPackageTypesTable extends ProductArrivalPackageTypes
    with
        TableInfo<$ProductArrivalPackageTypesTable, ProductArrivalPackageType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductArrivalPackageTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_arrival_package_types';
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductArrivalPackageType(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $ProductArrivalPackageTypesTable createAlias(String alias) {
    return $ProductArrivalPackageTypesTable(attachedDatabase, alias);
  }
}

class ProductArrivalPackageType extends DataClass
    implements Insertable<ProductArrivalPackageType> {
  final int id;
  final String name;
  const ProductArrivalPackageType({required this.id, required this.name});
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

class $ProductArrivalPackageLinesTable extends ProductArrivalPackageLines
    with
        TableInfo<$ProductArrivalPackageLinesTable, ProductArrivalPackageLine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductArrivalPackageLinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _productArrivalPackageIdMeta =
      const VerificationMeta('productArrivalPackageId');
  @override
  late final GeneratedColumn<int> productArrivalPackageId =
      GeneratedColumn<int>('product_arrival_package_id', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'REFERENCES product_arrival_packages (id) ON DELETE CASCADE'));
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES products (id) ON DELETE CASCADE'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, productArrivalPackageId, productId, amount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_arrival_package_lines';
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductArrivalPackageLine(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      productArrivalPackageId: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}product_arrival_package_id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
    );
  }

  @override
  $ProductArrivalPackageLinesTable createAlias(String alias) {
    return $ProductArrivalPackageLinesTable(attachedDatabase, alias);
  }
}

class ProductArrivalPackageLine extends DataClass
    implements Insertable<ProductArrivalPackageLine> {
  final int id;
  final int productArrivalPackageId;
  final int productId;
  final int amount;
  const ProductArrivalPackageLine(
      {required this.id,
      required this.productArrivalPackageId,
      required this.productId,
      required this.amount});
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

class $ProductArrivalNewPackagesTable extends ProductArrivalNewPackages
    with TableInfo<$ProductArrivalNewPackagesTable, ProductArrivalNewPackage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductArrivalNewPackagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _productArrivalIdMeta =
      const VerificationMeta('productArrivalId');
  @override
  late final GeneratedColumn<int> productArrivalId = GeneratedColumn<int>(
      'product_arrival_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES product_arrivals (id) ON DELETE CASCADE'));
  static const VerificationMeta _typeIdMeta = const VerificationMeta('typeId');
  @override
  late final GeneratedColumn<int> typeId = GeneratedColumn<int>(
      'type_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _typeNameMeta =
      const VerificationMeta('typeName');
  @override
  late final GeneratedColumn<String> typeName = GeneratedColumn<String>(
      'type_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
      'number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, productArrivalId, typeId, typeName, number];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_arrival_new_packages';
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductArrivalNewPackage(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      productArrivalId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}product_arrival_id'])!,
      typeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type_id'])!,
      typeName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type_name'])!,
      number: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}number'])!,
    );
  }

  @override
  $ProductArrivalNewPackagesTable createAlias(String alias) {
    return $ProductArrivalNewPackagesTable(attachedDatabase, alias);
  }
}

class ProductArrivalNewPackage extends DataClass
    implements Insertable<ProductArrivalNewPackage> {
  final int id;
  final int productArrivalId;
  final int typeId;
  final String typeName;
  final String number;
  const ProductArrivalNewPackage(
      {required this.id,
      required this.productArrivalId,
      required this.typeId,
      required this.typeName,
      required this.number});
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

class $ProductArrivalPackageNewLinesTable extends ProductArrivalPackageNewLines
    with
        TableInfo<$ProductArrivalPackageNewLinesTable,
            ProductArrivalPackageNewLine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductArrivalPackageNewLinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _productArrivalPackageIdMeta =
      const VerificationMeta('productArrivalPackageId');
  @override
  late final GeneratedColumn<int> productArrivalPackageId =
      GeneratedColumn<int>('product_arrival_package_id', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'REFERENCES product_arrival_packages (id) ON DELETE CASCADE'));
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES products (id) ON DELETE CASCADE'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, productArrivalPackageId, productId, amount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_arrival_package_new_lines';
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductArrivalPackageNewLine(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      productArrivalPackageId: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}product_arrival_package_id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
    );
  }

  @override
  $ProductArrivalPackageNewLinesTable createAlias(String alias) {
    return $ProductArrivalPackageNewLinesTable(attachedDatabase, alias);
  }
}

class ProductArrivalPackageNewLine extends DataClass
    implements Insertable<ProductArrivalPackageNewLine> {
  final int id;
  final int productArrivalPackageId;
  final int productId;
  final int amount;
  const ProductArrivalPackageNewLine(
      {required this.id,
      required this.productArrivalPackageId,
      required this.productId,
      required this.amount});
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

class $StorageCellsTable extends StorageCells
    with TableInfo<$StorageCellsTable, StorageCell> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StorageCellsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'storage_cells';
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StorageCell(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $StorageCellsTable createAlias(String alias) {
    return $StorageCellsTable(attachedDatabase, alias);
  }
}

class StorageCell extends DataClass implements Insertable<StorageCell> {
  final int id;
  final String name;
  const StorageCell({required this.id, required this.name});
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

class $ProductArrivalPackageNewCellsTable extends ProductArrivalPackageNewCells
    with
        TableInfo<$ProductArrivalPackageNewCellsTable,
            ProductArrivalPackageNewCell> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductArrivalPackageNewCellsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _productArrivalPackageIdMeta =
      const VerificationMeta('productArrivalPackageId');
  @override
  late final GeneratedColumn<int> productArrivalPackageId =
      GeneratedColumn<int>('product_arrival_package_id', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'REFERENCES product_arrival_packages (id) ON DELETE CASCADE'));
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES products (id) ON DELETE CASCADE'));
  static const VerificationMeta _storageCellIdMeta =
      const VerificationMeta('storageCellId');
  @override
  late final GeneratedColumn<int> storageCellId = GeneratedColumn<int>(
      'storage_cell_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES storage_cells (id) ON DELETE CASCADE'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, productArrivalPackageId, productId, storageCellId, amount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_arrival_package_new_cells';
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductArrivalPackageNewCell(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      productArrivalPackageId: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}product_arrival_package_id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id'])!,
      storageCellId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}storage_cell_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
    );
  }

  @override
  $ProductArrivalPackageNewCellsTable createAlias(String alias) {
    return $ProductArrivalPackageNewCellsTable(attachedDatabase, alias);
  }
}

class ProductArrivalPackageNewCell extends DataClass
    implements Insertable<ProductArrivalPackageNewCell> {
  final int id;
  final int productArrivalPackageId;
  final int productId;
  final int storageCellId;
  final int amount;
  const ProductArrivalPackageNewCell(
      {required this.id,
      required this.productArrivalPackageId,
      required this.productId,
      required this.storageCellId,
      required this.amount});
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

class $ProductArrivalPackageNewCodesTable extends ProductArrivalPackageNewCodes
    with
        TableInfo<$ProductArrivalPackageNewCodesTable,
            ProductArrivalPackageNewCode> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductArrivalPackageNewCodesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _productArrivalPackageIdMeta =
      const VerificationMeta('productArrivalPackageId');
  @override
  late final GeneratedColumn<int> productArrivalPackageId =
      GeneratedColumn<int>('product_arrival_package_id', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'REFERENCES product_arrival_packages (id) ON DELETE CASCADE'));
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES products (id) ON DELETE CASCADE'));
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, productArrivalPackageId, productId, code];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_arrival_package_new_codes';
  @override
  VerificationContext validateIntegrity(
      Insertable<ProductArrivalPackageNewCode> instance,
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
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductArrivalPackageNewCode map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductArrivalPackageNewCode(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      productArrivalPackageId: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}product_arrival_package_id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
    );
  }

  @override
  $ProductArrivalPackageNewCodesTable createAlias(String alias) {
    return $ProductArrivalPackageNewCodesTable(attachedDatabase, alias);
  }
}

class ProductArrivalPackageNewCode extends DataClass
    implements Insertable<ProductArrivalPackageNewCode> {
  final int id;
  final int productArrivalPackageId;
  final int productId;
  final String code;
  const ProductArrivalPackageNewCode(
      {required this.id,
      required this.productArrivalPackageId,
      required this.productId,
      required this.code});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_arrival_package_id'] = Variable<int>(productArrivalPackageId);
    map['product_id'] = Variable<int>(productId);
    map['code'] = Variable<String>(code);
    return map;
  }

  ProductArrivalPackageNewCodesCompanion toCompanion(bool nullToAbsent) {
    return ProductArrivalPackageNewCodesCompanion(
      id: Value(id),
      productArrivalPackageId: Value(productArrivalPackageId),
      productId: Value(productId),
      code: Value(code),
    );
  }

  factory ProductArrivalPackageNewCode.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductArrivalPackageNewCode(
      id: serializer.fromJson<int>(json['id']),
      productArrivalPackageId:
          serializer.fromJson<int>(json['productArrivalPackageId']),
      productId: serializer.fromJson<int>(json['productId']),
      code: serializer.fromJson<String>(json['code']),
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
      'code': serializer.toJson<String>(code),
    };
  }

  ProductArrivalPackageNewCode copyWith(
          {int? id,
          int? productArrivalPackageId,
          int? productId,
          String? code}) =>
      ProductArrivalPackageNewCode(
        id: id ?? this.id,
        productArrivalPackageId:
            productArrivalPackageId ?? this.productArrivalPackageId,
        productId: productId ?? this.productId,
        code: code ?? this.code,
      );
  @override
  String toString() {
    return (StringBuffer('ProductArrivalPackageNewCode(')
          ..write('id: $id, ')
          ..write('productArrivalPackageId: $productArrivalPackageId, ')
          ..write('productId: $productId, ')
          ..write('code: $code')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, productArrivalPackageId, productId, code);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductArrivalPackageNewCode &&
          other.id == this.id &&
          other.productArrivalPackageId == this.productArrivalPackageId &&
          other.productId == this.productId &&
          other.code == this.code);
}

class ProductArrivalPackageNewCodesCompanion
    extends UpdateCompanion<ProductArrivalPackageNewCode> {
  final Value<int> id;
  final Value<int> productArrivalPackageId;
  final Value<int> productId;
  final Value<String> code;
  const ProductArrivalPackageNewCodesCompanion({
    this.id = const Value.absent(),
    this.productArrivalPackageId = const Value.absent(),
    this.productId = const Value.absent(),
    this.code = const Value.absent(),
  });
  ProductArrivalPackageNewCodesCompanion.insert({
    this.id = const Value.absent(),
    required int productArrivalPackageId,
    required int productId,
    required String code,
  })  : productArrivalPackageId = Value(productArrivalPackageId),
        productId = Value(productId),
        code = Value(code);
  static Insertable<ProductArrivalPackageNewCode> custom({
    Expression<int>? id,
    Expression<int>? productArrivalPackageId,
    Expression<int>? productId,
    Expression<String>? code,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productArrivalPackageId != null)
        'product_arrival_package_id': productArrivalPackageId,
      if (productId != null) 'product_id': productId,
      if (code != null) 'code': code,
    });
  }

  ProductArrivalPackageNewCodesCompanion copyWith(
      {Value<int>? id,
      Value<int>? productArrivalPackageId,
      Value<int>? productId,
      Value<String>? code}) {
    return ProductArrivalPackageNewCodesCompanion(
      id: id ?? this.id,
      productArrivalPackageId:
          productArrivalPackageId ?? this.productArrivalPackageId,
      productId: productId ?? this.productId,
      code: code ?? this.code,
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
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductArrivalPackageNewCodesCompanion(')
          ..write('id: $id, ')
          ..write('productArrivalPackageId: $productArrivalPackageId, ')
          ..write('productId: $productId, ')
          ..write('code: $code')
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
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _productArrivalIdMeta =
      const VerificationMeta('productArrivalId');
  @override
  late final GeneratedColumn<int> productArrivalId = GeneratedColumn<int>(
      'product_arrival_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES product_arrivals (id) ON DELETE CASCADE'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _typeIdMeta = const VerificationMeta('typeId');
  @override
  late final GeneratedColumn<int> typeId = GeneratedColumn<int>(
      'type_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _typeNameMeta =
      const VerificationMeta('typeName');
  @override
  late final GeneratedColumn<String> typeName = GeneratedColumn<String>(
      'type_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, productArrivalId, amount, typeId, typeName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_arrival_new_unload_packages';
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductArrivalNewUnloadPackage(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      productArrivalId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}product_arrival_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      typeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type_id'])!,
      typeName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type_name'])!,
    );
  }

  @override
  $ProductArrivalNewUnloadPackagesTable createAlias(String alias) {
    return $ProductArrivalNewUnloadPackagesTable(attachedDatabase, alias);
  }
}

class ProductArrivalNewUnloadPackage extends DataClass
    implements Insertable<ProductArrivalNewUnloadPackage> {
  final int id;
  final int productArrivalId;
  final int amount;
  final int typeId;
  final String typeName;
  const ProductArrivalNewUnloadPackage(
      {required this.id,
      required this.productArrivalId,
      required this.amount,
      required this.typeId,
      required this.typeName});
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

class $ProductStoresTable extends ProductStores
    with TableInfo<$ProductStoresTable, ProductStore> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductStoresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_stores';
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductStore(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $ProductStoresTable createAlias(String alias) {
    return $ProductStoresTable(attachedDatabase, alias);
  }
}

class ProductStore extends DataClass implements Insertable<ProductStore> {
  final String id;
  final String name;
  const ProductStore({required this.id, required this.name});
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
  final Value<int> rowid;
  const ProductStoresCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductStoresCompanion.insert({
    required String id,
    required String name,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<ProductStore> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductStoresCompanion copyWith(
      {Value<String>? id, Value<String>? name, Value<int>? rowid}) {
    return ProductStoresCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
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
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductStoresCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
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
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _storeFromIdMeta =
      const VerificationMeta('storeFromId');
  @override
  late final GeneratedColumn<String> storeFromId = GeneratedColumn<String>(
      'store_from_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES product_stores (id) ON DELETE CASCADE'));
  static const VerificationMeta _storeToIdMeta =
      const VerificationMeta('storeToId');
  @override
  late final GeneratedColumn<String> storeToId = GeneratedColumn<String>(
      'store_to_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES product_stores (id) ON DELETE CASCADE'));
  static const VerificationMeta _commentMeta =
      const VerificationMeta('comment');
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
      'comment', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _gatherFinishedMeta =
      const VerificationMeta('gatherFinished');
  @override
  late final GeneratedColumn<bool> gatherFinished = GeneratedColumn<bool>(
      'gather_finished', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("gather_finished" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, storeFromId, storeToId, comment, gatherFinished];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_transfers';
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductTransfer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      storeFromId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}store_from_id']),
      storeToId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}store_to_id']),
      comment: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}comment']),
      gatherFinished: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}gather_finished'])!,
    );
  }

  @override
  $ProductTransfersTable createAlias(String alias) {
    return $ProductTransfersTable(attachedDatabase, alias);
  }
}

class ProductTransfer extends DataClass implements Insertable<ProductTransfer> {
  final int id;
  final String? storeFromId;
  final String? storeToId;
  final String? comment;
  final bool gatherFinished;
  const ProductTransfer(
      {required this.id,
      this.storeFromId,
      this.storeToId,
      this.comment,
      required this.gatherFinished});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || storeFromId != null) {
      map['store_from_id'] = Variable<String>(storeFromId);
    }
    if (!nullToAbsent || storeToId != null) {
      map['store_to_id'] = Variable<String>(storeToId);
    }
    if (!nullToAbsent || comment != null) {
      map['comment'] = Variable<String>(comment);
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
          Value<String?> storeFromId = const Value.absent(),
          Value<String?> storeToId = const Value.absent(),
          Value<String?> comment = const Value.absent(),
          bool? gatherFinished}) =>
      ProductTransfer(
        id: id ?? this.id,
        storeFromId: storeFromId.present ? storeFromId.value : this.storeFromId,
        storeToId: storeToId.present ? storeToId.value : this.storeToId,
        comment: comment.present ? comment.value : this.comment,
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
    Expression<String>? storeFromId,
    Expression<String>? storeToId,
    Expression<String>? comment,
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
      map['store_from_id'] = Variable<String>(storeFromId.value);
    }
    if (storeToId.present) {
      map['store_to_id'] = Variable<String>(storeToId.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
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

class $ProductTransferFromCellsTable extends ProductTransferFromCells
    with TableInfo<$ProductTransferFromCellsTable, ProductTransferFromCell> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductTransferFromCellsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _productTransferIdMeta =
      const VerificationMeta('productTransferId');
  @override
  late final GeneratedColumn<int> productTransferId = GeneratedColumn<int>(
      'product_transfer_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES product_transfers (id) ON DELETE CASCADE'));
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES products (id) ON DELETE CASCADE'));
  static const VerificationMeta _storageCellIdMeta =
      const VerificationMeta('storageCellId');
  @override
  late final GeneratedColumn<int> storageCellId = GeneratedColumn<int>(
      'storage_cell_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES storage_cells (id) ON DELETE CASCADE'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, productTransferId, productId, storageCellId, amount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_transfer_from_cells';
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductTransferFromCell(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      productTransferId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}product_transfer_id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id'])!,
      storageCellId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}storage_cell_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
    );
  }

  @override
  $ProductTransferFromCellsTable createAlias(String alias) {
    return $ProductTransferFromCellsTable(attachedDatabase, alias);
  }
}

class ProductTransferFromCell extends DataClass
    implements Insertable<ProductTransferFromCell> {
  final int id;
  final int productTransferId;
  final int productId;
  final int storageCellId;
  final int amount;
  const ProductTransferFromCell(
      {required this.id,
      required this.productTransferId,
      required this.productId,
      required this.storageCellId,
      required this.amount});
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

class $ProductTransferToCellsTable extends ProductTransferToCells
    with TableInfo<$ProductTransferToCellsTable, ProductTransferToCell> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductTransferToCellsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _productTransferIdMeta =
      const VerificationMeta('productTransferId');
  @override
  late final GeneratedColumn<int> productTransferId = GeneratedColumn<int>(
      'product_transfer_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES product_transfers (id) ON DELETE CASCADE'));
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES products (id) ON DELETE CASCADE'));
  static const VerificationMeta _storageCellIdMeta =
      const VerificationMeta('storageCellId');
  @override
  late final GeneratedColumn<int> storageCellId = GeneratedColumn<int>(
      'storage_cell_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES storage_cells (id) ON DELETE CASCADE'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, productTransferId, productId, storageCellId, amount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_transfer_to_cells';
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductTransferToCell(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      productTransferId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}product_transfer_id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id'])!,
      storageCellId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}storage_cell_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
    );
  }

  @override
  $ProductTransferToCellsTable createAlias(String alias) {
    return $ProductTransferToCellsTable(attachedDatabase, alias);
  }
}

class ProductTransferToCell extends DataClass
    implements Insertable<ProductTransferToCell> {
  final int id;
  final int productTransferId;
  final int productId;
  final int storageCellId;
  final int amount;
  const ProductTransferToCell(
      {required this.id,
      required this.productTransferId,
      required this.productId,
      required this.storageCellId,
      required this.amount});
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

class $OrdersTable extends Orders with TableInfo<$OrdersTable, Order> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _courierNameMeta =
      const VerificationMeta('courierName');
  @override
  late final GeneratedColumn<String> courierName = GeneratedColumn<String>(
      'courier_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _trackingNumberMeta =
      const VerificationMeta('trackingNumber');
  @override
  late final GeneratedColumn<String> trackingNumber = GeneratedColumn<String>(
      'tracking_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
      'number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _deliveryDateMeta =
      const VerificationMeta('deliveryDate');
  @override
  late final GeneratedColumn<DateTime> deliveryDate = GeneratedColumn<DateTime>(
      'delivery_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deliveryDateTimeFromMeta =
      const VerificationMeta('deliveryDateTimeFrom');
  @override
  late final GeneratedColumn<DateTime> deliveryDateTimeFrom =
      GeneratedColumn<DateTime>('delivery_date_time_from', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _deliveryDateTimeToMeta =
      const VerificationMeta('deliveryDateTimeTo');
  @override
  late final GeneratedColumn<DateTime> deliveryDateTimeTo =
      GeneratedColumn<DateTime>('delivery_date_time_to', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _statusNameMeta =
      const VerificationMeta('statusName');
  @override
  late final GeneratedColumn<String> statusName = GeneratedColumn<String>(
      'status_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _packagesMeta =
      const VerificationMeta('packages');
  @override
  late final GeneratedColumn<int> packages = GeneratedColumn<int>(
      'packages', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
      'weight', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _volumeMeta = const VerificationMeta('volume');
  @override
  late final GeneratedColumn<int> volume = GeneratedColumn<int>(
      'volume', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _deliveryAddressNameMeta =
      const VerificationMeta('deliveryAddressName');
  @override
  late final GeneratedColumn<String> deliveryAddressName =
      GeneratedColumn<String>('delivery_address_name', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pickupAddressNameMeta =
      const VerificationMeta('pickupAddressName');
  @override
  late final GeneratedColumn<String> pickupAddressName =
      GeneratedColumn<String>('pickup_address_name', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _storageFromIdMeta =
      const VerificationMeta('storageFromId');
  @override
  late final GeneratedColumn<int> storageFromId = GeneratedColumn<int>(
      'storage_from_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES storages (id)'));
  static const VerificationMeta _storageToIdMeta =
      const VerificationMeta('storageToId');
  @override
  late final GeneratedColumn<int> storageToId = GeneratedColumn<int>(
      'storage_to_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES storages (id)'));
  static const VerificationMeta _storageIssuedMeta =
      const VerificationMeta('storageIssued');
  @override
  late final GeneratedColumn<DateTime> storageIssued =
      GeneratedColumn<DateTime>('storage_issued', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _storageAcceptedMeta =
      const VerificationMeta('storageAccepted');
  @override
  late final GeneratedColumn<DateTime> storageAccepted =
      GeneratedColumn<DateTime>('storage_accepted', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _firstMovementDateMeta =
      const VerificationMeta('firstMovementDate');
  @override
  late final GeneratedColumn<DateTime> firstMovementDate =
      GeneratedColumn<DateTime>('first_movement_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _deliveredMeta =
      const VerificationMeta('delivered');
  @override
  late final GeneratedColumn<DateTime> delivered = GeneratedColumn<DateTime>(
      'delivered', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _documentsReturnMeta =
      const VerificationMeta('documentsReturn');
  @override
  late final GeneratedColumn<bool> documentsReturn = GeneratedColumn<bool>(
      'documents_return', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("documents_return" IN (0, 1))'));
  static const VerificationMeta _paidSumMeta =
      const VerificationMeta('paidSum');
  @override
  late final GeneratedColumn<double> paidSum = GeneratedColumn<double>(
      'paid_sum', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _paySumMeta = const VerificationMeta('paySum');
  @override
  late final GeneratedColumn<double> paySum = GeneratedColumn<double>(
      'pay_sum', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _markingScannedMeta =
      const VerificationMeta('markingScanned');
  @override
  late final GeneratedColumn<DateTime> markingScanned =
      GeneratedColumn<DateTime>('marking_scanned', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _needMarkingScanMeta =
      const VerificationMeta('needMarkingScan');
  @override
  late final GeneratedColumn<bool> needMarkingScan = GeneratedColumn<bool>(
      'need_marking_scan', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("need_marking_scan" IN (0, 1))'));
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
        paySum,
        markingScanned,
        needMarkingScan
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'orders';
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
    if (data.containsKey('marking_scanned')) {
      context.handle(
          _markingScannedMeta,
          markingScanned.isAcceptableOrUnknown(
              data['marking_scanned']!, _markingScannedMeta));
    }
    if (data.containsKey('need_marking_scan')) {
      context.handle(
          _needMarkingScanMeta,
          needMarkingScan.isAcceptableOrUnknown(
              data['need_marking_scan']!, _needMarkingScanMeta));
    } else if (isInserting) {
      context.missing(_needMarkingScanMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Order map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Order(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      courierName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}courier_name']),
      trackingNumber: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}tracking_number'])!,
      number: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}number'])!,
      deliveryDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}delivery_date'])!,
      deliveryDateTimeFrom: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}delivery_date_time_from']),
      deliveryDateTimeTo: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}delivery_date_time_to']),
      statusName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status_name'])!,
      packages: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}packages'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}weight']),
      volume: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}volume']),
      deliveryAddressName: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}delivery_address_name'])!,
      pickupAddressName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}pickup_address_name'])!,
      storageFromId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}storage_from_id']),
      storageToId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}storage_to_id']),
      storageIssued: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}storage_issued']),
      storageAccepted: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}storage_accepted']),
      firstMovementDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}first_movement_date']),
      delivered: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}delivered']),
      documentsReturn: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}documents_return'])!,
      paidSum: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}paid_sum'])!,
      paySum: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}pay_sum'])!,
      markingScanned: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}marking_scanned']),
      needMarkingScan: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}need_marking_scan'])!,
    );
  }

  @override
  $OrdersTable createAlias(String alias) {
    return $OrdersTable(attachedDatabase, alias);
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
  final DateTime? markingScanned;
  final bool needMarkingScan;
  const Order(
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
      required this.paySum,
      this.markingScanned,
      required this.needMarkingScan});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || courierName != null) {
      map['courier_name'] = Variable<String>(courierName);
    }
    map['tracking_number'] = Variable<String>(trackingNumber);
    map['number'] = Variable<String>(number);
    map['delivery_date'] = Variable<DateTime>(deliveryDate);
    if (!nullToAbsent || deliveryDateTimeFrom != null) {
      map['delivery_date_time_from'] = Variable<DateTime>(deliveryDateTimeFrom);
    }
    if (!nullToAbsent || deliveryDateTimeTo != null) {
      map['delivery_date_time_to'] = Variable<DateTime>(deliveryDateTimeTo);
    }
    map['status_name'] = Variable<String>(statusName);
    map['packages'] = Variable<int>(packages);
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<int>(weight);
    }
    if (!nullToAbsent || volume != null) {
      map['volume'] = Variable<int>(volume);
    }
    map['delivery_address_name'] = Variable<String>(deliveryAddressName);
    map['pickup_address_name'] = Variable<String>(pickupAddressName);
    if (!nullToAbsent || storageFromId != null) {
      map['storage_from_id'] = Variable<int>(storageFromId);
    }
    if (!nullToAbsent || storageToId != null) {
      map['storage_to_id'] = Variable<int>(storageToId);
    }
    if (!nullToAbsent || storageIssued != null) {
      map['storage_issued'] = Variable<DateTime>(storageIssued);
    }
    if (!nullToAbsent || storageAccepted != null) {
      map['storage_accepted'] = Variable<DateTime>(storageAccepted);
    }
    if (!nullToAbsent || firstMovementDate != null) {
      map['first_movement_date'] = Variable<DateTime>(firstMovementDate);
    }
    if (!nullToAbsent || delivered != null) {
      map['delivered'] = Variable<DateTime>(delivered);
    }
    map['documents_return'] = Variable<bool>(documentsReturn);
    map['paid_sum'] = Variable<double>(paidSum);
    map['pay_sum'] = Variable<double>(paySum);
    if (!nullToAbsent || markingScanned != null) {
      map['marking_scanned'] = Variable<DateTime>(markingScanned);
    }
    map['need_marking_scan'] = Variable<bool>(needMarkingScan);
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
      markingScanned: markingScanned == null && nullToAbsent
          ? const Value.absent()
          : Value(markingScanned),
      needMarkingScan: Value(needMarkingScan),
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
      markingScanned: serializer.fromJson<DateTime?>(json['markingScanned']),
      needMarkingScan: serializer.fromJson<bool>(json['needMarkingScan']),
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
      'markingScanned': serializer.toJson<DateTime?>(markingScanned),
      'needMarkingScan': serializer.toJson<bool>(needMarkingScan),
    };
  }

  Order copyWith(
          {int? id,
          Value<String?> courierName = const Value.absent(),
          String? trackingNumber,
          String? number,
          DateTime? deliveryDate,
          Value<DateTime?> deliveryDateTimeFrom = const Value.absent(),
          Value<DateTime?> deliveryDateTimeTo = const Value.absent(),
          String? statusName,
          int? packages,
          Value<int?> weight = const Value.absent(),
          Value<int?> volume = const Value.absent(),
          String? deliveryAddressName,
          String? pickupAddressName,
          Value<int?> storageFromId = const Value.absent(),
          Value<int?> storageToId = const Value.absent(),
          Value<DateTime?> storageIssued = const Value.absent(),
          Value<DateTime?> storageAccepted = const Value.absent(),
          Value<DateTime?> firstMovementDate = const Value.absent(),
          Value<DateTime?> delivered = const Value.absent(),
          bool? documentsReturn,
          double? paidSum,
          double? paySum,
          Value<DateTime?> markingScanned = const Value.absent(),
          bool? needMarkingScan}) =>
      Order(
        id: id ?? this.id,
        courierName: courierName.present ? courierName.value : this.courierName,
        trackingNumber: trackingNumber ?? this.trackingNumber,
        number: number ?? this.number,
        deliveryDate: deliveryDate ?? this.deliveryDate,
        deliveryDateTimeFrom: deliveryDateTimeFrom.present
            ? deliveryDateTimeFrom.value
            : this.deliveryDateTimeFrom,
        deliveryDateTimeTo: deliveryDateTimeTo.present
            ? deliveryDateTimeTo.value
            : this.deliveryDateTimeTo,
        statusName: statusName ?? this.statusName,
        packages: packages ?? this.packages,
        weight: weight.present ? weight.value : this.weight,
        volume: volume.present ? volume.value : this.volume,
        deliveryAddressName: deliveryAddressName ?? this.deliveryAddressName,
        pickupAddressName: pickupAddressName ?? this.pickupAddressName,
        storageFromId:
            storageFromId.present ? storageFromId.value : this.storageFromId,
        storageToId: storageToId.present ? storageToId.value : this.storageToId,
        storageIssued:
            storageIssued.present ? storageIssued.value : this.storageIssued,
        storageAccepted: storageAccepted.present
            ? storageAccepted.value
            : this.storageAccepted,
        firstMovementDate: firstMovementDate.present
            ? firstMovementDate.value
            : this.firstMovementDate,
        delivered: delivered.present ? delivered.value : this.delivered,
        documentsReturn: documentsReturn ?? this.documentsReturn,
        paidSum: paidSum ?? this.paidSum,
        paySum: paySum ?? this.paySum,
        markingScanned:
            markingScanned.present ? markingScanned.value : this.markingScanned,
        needMarkingScan: needMarkingScan ?? this.needMarkingScan,
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
          ..write('paySum: $paySum, ')
          ..write('markingScanned: $markingScanned, ')
          ..write('needMarkingScan: $needMarkingScan')
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
        paySum,
        markingScanned,
        needMarkingScan
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
          other.paySum == this.paySum &&
          other.markingScanned == this.markingScanned &&
          other.needMarkingScan == this.needMarkingScan);
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
  final Value<DateTime?> markingScanned;
  final Value<bool> needMarkingScan;
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
    this.markingScanned = const Value.absent(),
    this.needMarkingScan = const Value.absent(),
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
    this.markingScanned = const Value.absent(),
    required bool needMarkingScan,
  })  : trackingNumber = Value(trackingNumber),
        number = Value(number),
        deliveryDate = Value(deliveryDate),
        statusName = Value(statusName),
        packages = Value(packages),
        deliveryAddressName = Value(deliveryAddressName),
        pickupAddressName = Value(pickupAddressName),
        documentsReturn = Value(documentsReturn),
        paidSum = Value(paidSum),
        paySum = Value(paySum),
        needMarkingScan = Value(needMarkingScan);
  static Insertable<Order> custom({
    Expression<int>? id,
    Expression<String>? courierName,
    Expression<String>? trackingNumber,
    Expression<String>? number,
    Expression<DateTime>? deliveryDate,
    Expression<DateTime>? deliveryDateTimeFrom,
    Expression<DateTime>? deliveryDateTimeTo,
    Expression<String>? statusName,
    Expression<int>? packages,
    Expression<int>? weight,
    Expression<int>? volume,
    Expression<String>? deliveryAddressName,
    Expression<String>? pickupAddressName,
    Expression<int>? storageFromId,
    Expression<int>? storageToId,
    Expression<DateTime>? storageIssued,
    Expression<DateTime>? storageAccepted,
    Expression<DateTime>? firstMovementDate,
    Expression<DateTime>? delivered,
    Expression<bool>? documentsReturn,
    Expression<double>? paidSum,
    Expression<double>? paySum,
    Expression<DateTime>? markingScanned,
    Expression<bool>? needMarkingScan,
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
      if (markingScanned != null) 'marking_scanned': markingScanned,
      if (needMarkingScan != null) 'need_marking_scan': needMarkingScan,
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
      Value<double>? paySum,
      Value<DateTime?>? markingScanned,
      Value<bool>? needMarkingScan}) {
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
      markingScanned: markingScanned ?? this.markingScanned,
      needMarkingScan: needMarkingScan ?? this.needMarkingScan,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (courierName.present) {
      map['courier_name'] = Variable<String>(courierName.value);
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
          Variable<DateTime>(deliveryDateTimeFrom.value);
    }
    if (deliveryDateTimeTo.present) {
      map['delivery_date_time_to'] =
          Variable<DateTime>(deliveryDateTimeTo.value);
    }
    if (statusName.present) {
      map['status_name'] = Variable<String>(statusName.value);
    }
    if (packages.present) {
      map['packages'] = Variable<int>(packages.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    if (volume.present) {
      map['volume'] = Variable<int>(volume.value);
    }
    if (deliveryAddressName.present) {
      map['delivery_address_name'] =
          Variable<String>(deliveryAddressName.value);
    }
    if (pickupAddressName.present) {
      map['pickup_address_name'] = Variable<String>(pickupAddressName.value);
    }
    if (storageFromId.present) {
      map['storage_from_id'] = Variable<int>(storageFromId.value);
    }
    if (storageToId.present) {
      map['storage_to_id'] = Variable<int>(storageToId.value);
    }
    if (storageIssued.present) {
      map['storage_issued'] = Variable<DateTime>(storageIssued.value);
    }
    if (storageAccepted.present) {
      map['storage_accepted'] = Variable<DateTime>(storageAccepted.value);
    }
    if (firstMovementDate.present) {
      map['first_movement_date'] = Variable<DateTime>(firstMovementDate.value);
    }
    if (delivered.present) {
      map['delivered'] = Variable<DateTime>(delivered.value);
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
    if (markingScanned.present) {
      map['marking_scanned'] = Variable<DateTime>(markingScanned.value);
    }
    if (needMarkingScan.present) {
      map['need_marking_scan'] = Variable<bool>(needMarkingScan.value);
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
          ..write('paySum: $paySum, ')
          ..write('markingScanned: $markingScanned, ')
          ..write('needMarkingScan: $needMarkingScan')
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
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _orderIdMeta =
      const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<int> orderId = GeneratedColumn<int>(
      'order_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES orders (id) ON DELETE CASCADE'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _factAmountMeta =
      const VerificationMeta('factAmount');
  @override
  late final GeneratedColumn<int> factAmount = GeneratedColumn<int>(
      'fact_amount', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES products (id) ON DELETE CASCADE'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, orderId, name, amount, price, factAmount, productId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'order_lines';
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
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrderLine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrderLine(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      orderId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price'])!,
      factAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}fact_amount']),
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id']),
    );
  }

  @override
  $OrderLinesTable createAlias(String alias) {
    return $OrderLinesTable(attachedDatabase, alias);
  }
}

class OrderLine extends DataClass implements Insertable<OrderLine> {
  final int id;
  final int orderId;
  final String name;
  final int amount;
  final double price;
  final int? factAmount;
  final int? productId;
  const OrderLine(
      {required this.id,
      required this.orderId,
      required this.name,
      required this.amount,
      required this.price,
      this.factAmount,
      this.productId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['order_id'] = Variable<int>(orderId);
    map['name'] = Variable<String>(name);
    map['amount'] = Variable<int>(amount);
    map['price'] = Variable<double>(price);
    if (!nullToAbsent || factAmount != null) {
      map['fact_amount'] = Variable<int>(factAmount);
    }
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<int>(productId);
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
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
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
      productId: serializer.fromJson<int?>(json['productId']),
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
      'productId': serializer.toJson<int?>(productId),
    };
  }

  OrderLine copyWith(
          {int? id,
          int? orderId,
          String? name,
          int? amount,
          double? price,
          Value<int?> factAmount = const Value.absent(),
          Value<int?> productId = const Value.absent()}) =>
      OrderLine(
        id: id ?? this.id,
        orderId: orderId ?? this.orderId,
        name: name ?? this.name,
        amount: amount ?? this.amount,
        price: price ?? this.price,
        factAmount: factAmount.present ? factAmount.value : this.factAmount,
        productId: productId.present ? productId.value : this.productId,
      );
  @override
  String toString() {
    return (StringBuffer('OrderLine(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('price: $price, ')
          ..write('factAmount: $factAmount, ')
          ..write('productId: $productId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, orderId, name, amount, price, factAmount, productId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderLine &&
          other.id == this.id &&
          other.orderId == this.orderId &&
          other.name == this.name &&
          other.amount == this.amount &&
          other.price == this.price &&
          other.factAmount == this.factAmount &&
          other.productId == this.productId);
}

class OrderLinesCompanion extends UpdateCompanion<OrderLine> {
  final Value<int> id;
  final Value<int> orderId;
  final Value<String> name;
  final Value<int> amount;
  final Value<double> price;
  final Value<int?> factAmount;
  final Value<int?> productId;
  const OrderLinesCompanion({
    this.id = const Value.absent(),
    this.orderId = const Value.absent(),
    this.name = const Value.absent(),
    this.amount = const Value.absent(),
    this.price = const Value.absent(),
    this.factAmount = const Value.absent(),
    this.productId = const Value.absent(),
  });
  OrderLinesCompanion.insert({
    this.id = const Value.absent(),
    required int orderId,
    required String name,
    required int amount,
    required double price,
    this.factAmount = const Value.absent(),
    this.productId = const Value.absent(),
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
    Expression<int>? factAmount,
    Expression<int>? productId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      if (name != null) 'name': name,
      if (amount != null) 'amount': amount,
      if (price != null) 'price': price,
      if (factAmount != null) 'fact_amount': factAmount,
      if (productId != null) 'product_id': productId,
    });
  }

  OrderLinesCompanion copyWith(
      {Value<int>? id,
      Value<int>? orderId,
      Value<String>? name,
      Value<int>? amount,
      Value<double>? price,
      Value<int?>? factAmount,
      Value<int?>? productId}) {
    return OrderLinesCompanion(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      price: price ?? this.price,
      factAmount: factAmount ?? this.factAmount,
      productId: productId ?? this.productId,
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
      map['fact_amount'] = Variable<int>(factAmount.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
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
          ..write('factAmount: $factAmount, ')
          ..write('productId: $productId')
          ..write(')'))
        .toString();
  }
}

class $OrderLineNewCodesTable extends OrderLineNewCodes
    with TableInfo<$OrderLineNewCodesTable, OrderLineNewCode> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrderLineNewCodesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _orderLineIdMeta =
      const VerificationMeta('orderLineId');
  @override
  late final GeneratedColumn<int> orderLineId = GeneratedColumn<int>(
      'order_line_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES order_lines (id) ON DELETE CASCADE'));
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, orderLineId, code];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'order_line_new_codes';
  @override
  VerificationContext validateIntegrity(Insertable<OrderLineNewCode> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order_line_id')) {
      context.handle(
          _orderLineIdMeta,
          orderLineId.isAcceptableOrUnknown(
              data['order_line_id']!, _orderLineIdMeta));
    } else if (isInserting) {
      context.missing(_orderLineIdMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrderLineNewCode map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrderLineNewCode(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      orderLineId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_line_id'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
    );
  }

  @override
  $OrderLineNewCodesTable createAlias(String alias) {
    return $OrderLineNewCodesTable(attachedDatabase, alias);
  }
}

class OrderLineNewCode extends DataClass
    implements Insertable<OrderLineNewCode> {
  final int id;
  final int orderLineId;
  final String code;
  const OrderLineNewCode(
      {required this.id, required this.orderLineId, required this.code});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['order_line_id'] = Variable<int>(orderLineId);
    map['code'] = Variable<String>(code);
    return map;
  }

  OrderLineNewCodesCompanion toCompanion(bool nullToAbsent) {
    return OrderLineNewCodesCompanion(
      id: Value(id),
      orderLineId: Value(orderLineId),
      code: Value(code),
    );
  }

  factory OrderLineNewCode.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderLineNewCode(
      id: serializer.fromJson<int>(json['id']),
      orderLineId: serializer.fromJson<int>(json['orderLineId']),
      code: serializer.fromJson<String>(json['code']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'orderLineId': serializer.toJson<int>(orderLineId),
      'code': serializer.toJson<String>(code),
    };
  }

  OrderLineNewCode copyWith({int? id, int? orderLineId, String? code}) =>
      OrderLineNewCode(
        id: id ?? this.id,
        orderLineId: orderLineId ?? this.orderLineId,
        code: code ?? this.code,
      );
  @override
  String toString() {
    return (StringBuffer('OrderLineNewCode(')
          ..write('id: $id, ')
          ..write('orderLineId: $orderLineId, ')
          ..write('code: $code')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, orderLineId, code);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderLineNewCode &&
          other.id == this.id &&
          other.orderLineId == this.orderLineId &&
          other.code == this.code);
}

class OrderLineNewCodesCompanion extends UpdateCompanion<OrderLineNewCode> {
  final Value<int> id;
  final Value<int> orderLineId;
  final Value<String> code;
  const OrderLineNewCodesCompanion({
    this.id = const Value.absent(),
    this.orderLineId = const Value.absent(),
    this.code = const Value.absent(),
  });
  OrderLineNewCodesCompanion.insert({
    this.id = const Value.absent(),
    required int orderLineId,
    required String code,
  })  : orderLineId = Value(orderLineId),
        code = Value(code);
  static Insertable<OrderLineNewCode> custom({
    Expression<int>? id,
    Expression<int>? orderLineId,
    Expression<String>? code,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderLineId != null) 'order_line_id': orderLineId,
      if (code != null) 'code': code,
    });
  }

  OrderLineNewCodesCompanion copyWith(
      {Value<int>? id, Value<int>? orderLineId, Value<String>? code}) {
    return OrderLineNewCodesCompanion(
      id: id ?? this.id,
      orderLineId: orderLineId ?? this.orderLineId,
      code: code ?? this.code,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (orderLineId.present) {
      map['order_line_id'] = Variable<int>(orderLineId.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrderLineNewCodesCompanion(')
          ..write('id: $id, ')
          ..write('orderLineId: $orderLineId, ')
          ..write('code: $code')
          ..write(')'))
        .toString();
  }
}

class $PrefsTable extends Prefs with TableInfo<$PrefsTable, Pref> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrefsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _logoutAfterMeta =
      const VerificationMeta('logoutAfter');
  @override
  late final GeneratedColumn<DateTime> logoutAfter = GeneratedColumn<DateTime>(
      'logout_after', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [logoutAfter];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prefs';
  @override
  VerificationContext validateIntegrity(Insertable<Pref> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('logout_after')) {
      context.handle(
          _logoutAfterMeta,
          logoutAfter.isAcceptableOrUnknown(
              data['logout_after']!, _logoutAfterMeta));
    } else if (isInserting) {
      context.missing(_logoutAfterMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Pref map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Pref(
      logoutAfter: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}logout_after'])!,
    );
  }

  @override
  $PrefsTable createAlias(String alias) {
    return $PrefsTable(attachedDatabase, alias);
  }
}

class Pref extends DataClass implements Insertable<Pref> {
  final DateTime logoutAfter;
  const Pref({required this.logoutAfter});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['logout_after'] = Variable<DateTime>(logoutAfter);
    return map;
  }

  PrefsCompanion toCompanion(bool nullToAbsent) {
    return PrefsCompanion(
      logoutAfter: Value(logoutAfter),
    );
  }

  factory Pref.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pref(
      logoutAfter: serializer.fromJson<DateTime>(json['logoutAfter']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'logoutAfter': serializer.toJson<DateTime>(logoutAfter),
    };
  }

  Pref copyWith({DateTime? logoutAfter}) => Pref(
        logoutAfter: logoutAfter ?? this.logoutAfter,
      );
  @override
  String toString() {
    return (StringBuffer('Pref(')
          ..write('logoutAfter: $logoutAfter')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => logoutAfter.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pref && other.logoutAfter == this.logoutAfter);
}

class PrefsCompanion extends UpdateCompanion<Pref> {
  final Value<DateTime> logoutAfter;
  final Value<int> rowid;
  const PrefsCompanion({
    this.logoutAfter = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PrefsCompanion.insert({
    required DateTime logoutAfter,
    this.rowid = const Value.absent(),
  }) : logoutAfter = Value(logoutAfter);
  static Insertable<Pref> custom({
    Expression<DateTime>? logoutAfter,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (logoutAfter != null) 'logout_after': logoutAfter,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PrefsCompanion copyWith({Value<DateTime>? logoutAfter, Value<int>? rowid}) {
    return PrefsCompanion(
      logoutAfter: logoutAfter ?? this.logoutAfter,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (logoutAfter.present) {
      map['logout_after'] = Variable<DateTime>(logoutAfter.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrefsCompanion(')
          ..write('logoutAfter: $logoutAfter, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDataStore extends GeneratedDatabase {
  _$AppDataStore(QueryExecutor e) : super(e);
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
  late final $ProductArrivalPackageNewCodesTable productArrivalPackageNewCodes =
      $ProductArrivalPackageNewCodesTable(this);
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
  late final $OrderLineNewCodesTable orderLineNewCodes =
      $OrderLineNewCodesTable(this);
  late final $PrefsTable prefs = $PrefsTable(this);
  late final OrdersDao ordersDao = OrdersDao(this as AppDataStore);
  late final ProductArrivalsDao productArrivalsDao =
      ProductArrivalsDao(this as AppDataStore);
  late final ProductTransfersDao productTransfersDao =
      ProductTransfersDao(this as AppDataStore);
  late final ProductsDao productsDao = ProductsDao(this as AppDataStore);
  late final StoragesDao storagesDao = StoragesDao(this as AppDataStore);
  late final UsersDao usersDao = UsersDao(this as AppDataStore);
  Selectable<AppInfoResult> appInfo() {
    return customSelect(
        'SELECT prefs.*, (SELECT COUNT(*) FROM product_arrivals) AS product_arrivals_total, (SELECT COUNT(*) FROM orders) AS orders_total FROM prefs',
        variables: [],
        readsFrom: {
          productArrivals,
          orders,
          prefs,
        }).map((QueryRow row) => AppInfoResult(
          logoutAfter: row.read<DateTime>('logout_after'),
          productArrivalsTotal: row.read<int>('product_arrivals_total'),
          ordersTotal: row.read<int>('orders_total'),
        ));
  }

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
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
        productArrivalPackageNewCodes,
        productArrivalNewUnloadPackages,
        productStores,
        productTransfers,
        productTransferFromCells,
        productTransferToCells,
        orders,
        orderLines,
        orderLineNewCodes,
        prefs
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('product_arrivals',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('product_arrival_packages', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('product_arrival_packages',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('product_arrival_lines', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('products',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('product_arrival_lines', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('product_arrivals',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('product_arrival_unload_packages',
                  kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('product_arrival_packages',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('product_arrival_package_lines',
                  kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('products',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('product_arrival_package_lines',
                  kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('product_arrivals',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('product_arrival_new_packages',
                  kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('product_arrival_packages',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('product_arrival_package_new_lines',
                  kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('products',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('product_arrival_package_new_lines',
                  kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('product_arrival_packages',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('product_arrival_package_new_cells',
                  kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('products',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('product_arrival_package_new_cells',
                  kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('storage_cells',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('product_arrival_package_new_cells',
                  kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('product_arrival_packages',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('product_arrival_package_new_codes',
                  kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('products',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('product_arrival_package_new_codes',
                  kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('product_arrivals',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('product_arrival_new_unload_packages',
                  kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('product_stores',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('product_transfers', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('product_stores',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('product_transfers', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('product_transfers',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('product_transfer_from_cells',
                  kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('products',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('product_transfer_from_cells',
                  kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('storage_cells',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('product_transfer_from_cells',
                  kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('product_transfers',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('product_transfer_to_cells', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('products',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('product_transfer_to_cells', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('storage_cells',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('product_transfer_to_cells', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('orders',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('order_lines', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('products',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('order_lines', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('order_lines',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('order_line_new_codes', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

class AppInfoResult {
  final DateTime logoutAfter;
  final int productArrivalsTotal;
  final int ordersTotal;
  AppInfoResult({
    required this.logoutAfter,
    required this.productArrivalsTotal,
    required this.ordersTotal,
  });
}

mixin _$OrdersDaoMixin on DatabaseAccessor<AppDataStore> {
  $StoragesTable get storages => attachedDatabase.storages;
  $OrdersTable get orders => attachedDatabase.orders;
  $ProductsTable get products => attachedDatabase.products;
  $OrderLinesTable get orderLines => attachedDatabase.orderLines;
  $OrderLineNewCodesTable get orderLineNewCodes =>
      attachedDatabase.orderLineNewCodes;
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
  $ProductArrivalPackageNewCodesTable get productArrivalPackageNewCodes =>
      attachedDatabase.productArrivalPackageNewCodes;
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
mixin _$ProductsDaoMixin on DatabaseAccessor<AppDataStore> {
  $ProductsTable get products => attachedDatabase.products;
  $ProductStoresTable get productStores => attachedDatabase.productStores;
}
mixin _$StoragesDaoMixin on DatabaseAccessor<AppDataStore> {
  $StoragesTable get storages => attachedDatabase.storages;
  $StorageCellsTable get storageCells => attachedDatabase.storageCells;
}
mixin _$UsersDaoMixin on DatabaseAccessor<AppDataStore> {
  $UsersTable get users => attachedDatabase.users;
}
