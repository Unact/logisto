import 'package:drift/drift.dart' show Value;
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/strings.dart';
import '/app/entities/entities.dart';
import '/app/data/database.dart';
import '/app/repositories/app_store.dart';
import '/app/services/logisto_api.dart';

class ProductTransfersRepository {
  final AppStore store;

  AppDataStore get dataStore => store.dataStore;
  RenewApi get api => store.api;

  ProductTransfersRepository(this.store);

  Future<ProductTransferEx?> getCurrentTransfer() {
    return dataStore.productTransfersDao.getCurrentTransfer();
  }

  Future<void> addProductTransfer(ProductTransfersCompanion transfer) {
    return dataStore.productTransfersDao.addProductTransfer(transfer);
  }

  Future<void> addProductTransferFromCell(ProductTransferFromCellsCompanion fromCell) {
    return dataStore.productTransfersDao.addProductTransferFromCell(fromCell);
  }

  Future<void> addProductTransferToCell(ProductTransferToCellsCompanion toCell) {
    return dataStore.productTransfersDao.addProductTransferToCell(toCell);
  }

  Future<void> deleteProductTransferFromCell(ProductTransferFromCellEx fromCellEx) {
    return dataStore.productTransfersDao.deleteProductTransferFromCell(fromCellEx.fromCell);
  }

  Future<void> deleteProductTransferToCell(ProductTransferToCellEx toCellEx) {
    return dataStore.productTransfersDao.deleteProductTransferToCell(toCellEx.toCell);
  }

  Future<void> upsertProductTransfer(ProductTransfersCompanion transfer) {
    return dataStore.productTransfersDao.upsertProductTransfer(transfer.id.value, transfer);
  }

  Future<void> finishProductTransfer(ProductTransferEx transferEx) async {
    try {
      await api.productsTransfer(
        id: transferEx.productTransfer.id,
        fromStore: transferEx.productTransfer.storeFromId!,
        toStore: transferEx.productTransfer.storeToId!,
        comment: transferEx.productTransfer.comment,
        fromCells: transferEx.fromCells.map(
          (e) => { 'productId': e.product.id, 'storageCellId': e.storageCell.id, 'amount': e.fromCell.amount }
        ).toList(),
        toCells: transferEx.toCells.map(
          (e) => { 'productId': e.product.id, 'storageCellId': e.storageCell.id, 'amount': e.toCell.amount }
        ).toList()
      );
      await dataStore.productTransfersDao.clearProductTransfers();
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await Misc.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> finishProductTransferGather(ProductTransferEx transferEx) {
    final newTransfer = transferEx.productTransfer.toCompanion(false).copyWith(gatherFinished: const Value(true));

    return dataStore.productTransfersDao.upsertProductTransfer(newTransfer.id.value, newTransfer);
  }

  Future<void> cancelProductTransferGather(ProductTransferEx transferEx) async {
    final newTransfer = transferEx.productTransfer.toCompanion(false).copyWith(gatherFinished: const Value(false));

    await dataStore.transaction(() async {
      await dataStore.productTransfersDao.upsertProductTransfer(newTransfer.id.value, newTransfer);
      await dataStore.productTransfersDao.clearProductTransferToCells();
    });
  }
}
