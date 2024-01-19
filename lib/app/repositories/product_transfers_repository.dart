import 'package:drift/drift.dart' show Value;
import 'package:quiver/core.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/strings.dart';
import '/app/entities/entities.dart';
import '/app/data/database.dart';
import '/app/repositories/base_repository.dart';
import '/app/services/logisto_api.dart';

class ProductTransfersRepository extends BaseRepository {
  ProductTransfersRepository(AppDataStore dataStore, RenewApi api) : super(dataStore, api);

  Stream<ProductTransferEx?> watchCurrentTransfer() {
    return dataStore.productTransfersDao.watchCurrentTransfer();
  }

  Future<ProductTransferEx> addProductTransfer() async {
    await dataStore.productTransfersDao.addProductTransfer(ProductTransfersCompanion.insert(gatherFinished: false));

    return (await dataStore.productTransfersDao.watchCurrentTransfer().first)!;
  }

  Future<void> addProductTransferFromCell({
    required int productTransferId,
    required int productId,
    required int storageCellId,
    required int amount
  }) {
    return dataStore.productTransfersDao.addProductTransferFromCell(
      ProductTransferFromCellsCompanion.insert(
        productTransferId: productTransferId,
        productId: productId,
        storageCellId: storageCellId,
        amount: amount
      )
    );
  }

  Future<void> addProductTransferToCell({
    required int productTransferId,
    required int productId,
    required int storageCellId,
    required int amount
  }) {
    return dataStore.productTransfersDao.addProductTransferToCell(
      ProductTransferToCellsCompanion.insert(
        productTransferId: productTransferId,
        productId: productId,
        storageCellId: storageCellId,
        amount: amount
      )
    );
  }

  Future<void> deleteProductTransferFromCell(ProductTransferFromCellEx fromCellEx) {
    return dataStore.productTransfersDao.deleteProductTransferFromCell(fromCellEx.fromCell);
  }

  Future<void> deleteProductTransferToCell(ProductTransferToCellEx toCellEx) {
    return dataStore.productTransfersDao.deleteProductTransferToCell(toCellEx.toCell);
  }

  Future<void> upsertProductTransfer(ProductTransfer productTransfer, {
    Optional<String?>? storeFromId,
    Optional<String?>? storeToId,
    Optional<String?>? comment,
    Optional<bool>? gatherFinished
  }) {
    final updatedProductTransfer = productTransfer.toCompanion(false).copyWith(
      storeFromId: storeFromId == null ? null : Value(storeFromId.orNull),
      storeToId: storeToId == null ? null : Value(storeToId.orNull),
      comment: comment == null ? null : Value(comment.orNull),
      gatherFinished: gatherFinished == null ? null : Value(gatherFinished.value)
    );
    return dataStore.productTransfersDao.upsertProductTransfer(productTransfer.id, updatedProductTransfer);
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
      await dataStore.transaction(() async {
        await dataStore.productTransfersDao.addProductTransfer(ProductTransfersCompanion.insert(gatherFinished: false));
        await dataStore.productTransfersDao.clearProductTransfers();
      });

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
