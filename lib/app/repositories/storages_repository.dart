import 'package:u_app_utils/u_app_utils.dart';

import '/app/data/database.dart';
import '/app/repositories/base_repository.dart';

class StoragesRepository extends BaseRepository {
  StoragesRepository(AppDataStore dataStore, RenewApi api) : super(dataStore, api);

  Stream<List<Storage>> watchStorages() {
    return dataStore.storagesDao.watchStorages();
  }

  Future<Storage?> getStorageById(int id) {
    return dataStore.storagesDao.getStorageById(id);
  }

  Future<StorageCell> addStorageCell({
    required int id,
    required String name
  }) async {
    final storageCell = StorageCell(id: id, name: name);

    await dataStore.storagesDao.addStorageCell(storageCell);

    return storageCell;
  }
}
