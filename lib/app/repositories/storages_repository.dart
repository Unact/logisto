import 'package:u_app_utils/u_app_utils.dart';

import '/app/data/database.dart';
import '/app/repositories/app_store.dart';

class StoragesRepository {
  final AppStore store;

  AppDataStore get dataStore => store.dataStore;
  RenewApi get api => store.api;

  StoragesRepository(this.store);

  Future<List<Storage>> getStorages() {
    return dataStore.storagesDao.getStorages();
  }

  Future<Storage?> getStorageById(int id) {
    return dataStore.storagesDao.getStorageById(id);
  }

  Future<void> addStorageCell(StorageCell storageCell) {
    return dataStore.storagesDao.addStorageCell(storageCell);
  }
}
