import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '/app/constants/strings.dart';

part 'schema.dart';
part 'database.g.dart';
part 'api_credentials_dao.dart';
part 'product_arrivals_dao.dart';
part 'product_transfers_dao.dart';
part 'storages_dao.dart';
part 'orders_dao.dart';
part 'products_dao.dart';
part 'users_dao.dart';

@DriftDatabase(
  tables: [
    Users,
    Products,
    ProductArrivals,
    ProductArrivalLines,
    ProductArrivalPackages,
    ProductArrivalUnloadPackages,
    ProductArrivalPackageTypes,
    ProductArrivalPackageLines,
    ProductArrivalNewPackages,
    ProductArrivalPackageNewLines,
    ProductArrivalPackageNewCells,
    ProductArrivalNewUnloadPackages,
    ProductStores,
    ProductTransfers,
    ProductTransferFromCells,
    ProductTransferToCells,
    Orders,
    OrderLines,
    Storages,
    StorageCells,
    ApiCredentials,
    Prefs
  ],
  daos: [
    ApiCredentialsDao,
    OrdersDao,
    ProductArrivalsDao,
    ProductTransfersDao,
    ProductsDao,
    StoragesDao,
    UsersDao,
  ]
)
class AppDataStore extends _$AppDataStore {
  AppDataStore({
    required bool logStatements
  }) : super(_openConnection(logStatements));


  Future<Pref> getPref() async {
    return select(prefs).getSingle();
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
      batch.insert(users, User(
        id: UsersDao.kGuestId,
        username: UsersDao.kGuestUsername,
        email: '',
        name: '',
        version: '0.0.0',
        total: 0,
        storageIds: []
      ));
      batch.insert(apiCredentials, ApiCredential(
        refreshToken: '',
        url: '',
        accessToken: ''
      ));
      batch.insert(prefs, Pref());
    });
  }

  @override
  int get schemaVersion => 14;

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
