import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart' show DateUtils;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:pub_semver/pub_semver.dart';
import 'package:rxdart/rxdart.dart';

import '/app/constants/strings.dart';

part 'schema.dart';
part 'database.g.dart';
part 'product_arrivals_dao.dart';
part 'product_transfers_dao.dart';
part 'storages_dao.dart';
part 'orders_dao.dart';
part 'products_dao.dart';
part 'users_dao.dart';

@DriftDatabase(
  tables: [
    Users,
    PackageTypes,
    Products,
    ProductArrivals,
    ProductArrivalLines,
    ProductArrivalPackages,
    ProductArrivalUnloadPackages,
    ProductArrivalPackageLines,
    ProductArrivalNewPackages,
    ProductArrivalPackageNewLines,
    ProductArrivalPackageNewCells,
    ProductArrivalPackageNewCodes,
    ProductArrivalNewUnloadPackages,
    ProductStores,
    ProductTransfers,
    ProductTransferFromCells,
    ProductTransferToCells,
    Orders,
    OrderLines,
    OrderLineNewCodes,
    Storages,
    StorageCells,
    Prefs
  ],
  daos: [
    OrdersDao,
    ProductArrivalsDao,
    ProductTransfersDao,
    ProductsDao,
    StoragesDao,
    UsersDao,
  ],
  queries: {
    'appInfo': '''
      SELECT
        prefs.*,
        (SELECT COUNT(*) FROM product_arrivals) AS "product_arrivals_total",
        (SELECT COUNT(*) FROM orders) AS "orders_total"
      FROM prefs
    '''
  },
)
class AppDataStore extends _$AppDataStore {
  AppDataStore({
    required bool logStatements
  }) : super(_openConnection(logStatements));

  Future<void> loadPackageTypes(List<PackageType> packageTypeList) async {
    await batch((batch) {
      batch.deleteWhere(packageTypes, (row) => const Constant(true));
      batch.insertAll(packageTypes, packageTypeList, mode: InsertMode.insertOrReplace);
    });
  }

  Stream<AppInfoResult> watchAppInfo() {
    return appInfo().watchSingle();
  }

  Stream<List<PackageType>> watchPackageTypes() {
    return select(packageTypes).watch();
  }

  Future<int> updatePref(PrefsCompanion pref) {
    return update(prefs).write(pref);
  }

  Future<void> clearData() async {
    await transaction(() async {
      await _clearData();
      await _populateData();
    });
  }

  Future<void> _clearData() async {
    await batch((batch) {
      for (var table in allTables) {
        batch.deleteWhere(table, (row) => const Constant(true));
      }
    });
  }

  Future<void> _populateData() async {
    await batch((batch) {
      batch.insert(users, const User(
        id: UsersDao.kGuestId,
        username: UsersDao.kGuestUsername,
        email: '',
        name: '',
        version: '0.0.0',
        total: 0,
        storageIds: []
      ));
      batch.insert(prefs, Pref(
        logoutAfter: DateUtils.dateOnly(DateTime.now().add(const Duration(days: 1)))
      ));
    });
  }

  @override
  int get schemaVersion => 20;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (m, from, to) async {
      for (final table in allTables) {
        await m.deleteTable(table.actualTableName);
        await m.createTable(table);
      }
    },
    beforeOpen: (details) async {
      if (details.hadUpgrade || details.wasCreated) await _populateData();
    },
  );
}

LazyDatabase _openConnection(bool logStatements) {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, '${Strings.appName}.sqlite'));

    return NativeDatabase(file, logStatements: logStatements);
  });
}

extension UserX on User {
  Future<bool> get newVersionAvailable async {
    final currentVersion = (await PackageInfo.fromPlatform()).version;

    return Version.parse(version) > Version.parse(currentVersion);
  }
}
