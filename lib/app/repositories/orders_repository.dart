import '/app/app.dart';
import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/repositories/app_store.dart';
import '/app/services/api.dart';

class OrdersRepository {
  final AppStore store;

  AppDataStore get dataStore => store.dataStore;
  Api get api => store.api;

  OrdersRepository(this.store);

  Future<List<OrderEx>> getOrderExList() {
    return dataStore.ordersDao.getOrderExList();
  }

  Future<OrderEx> getOrderEx(int id) {
    return dataStore.ordersDao.getOrderEx(id);
  }

  Future<List<OrderLineNewCodeEx>> getOrderLineNewCodesEx(int id) {
    return dataStore.ordersDao.getOrderLineNewCodesEx(id);
  }

  Future<int> upsertOrderLine(int id, OrderLinesCompanion orderLine) {
    return dataStore.ordersDao.upsertOrderLine(id, orderLine);
  }

  Future<void> addOrderLineNewCode(OrderLineNewCodesCompanion newCode) {
    return dataStore.ordersDao.addOrderLineNewCode(newCode);
  }

  Future<void> deleteOrderLineNewCode(OrderLineNewCode newCode) {
    return dataStore.ordersDao.deleteOrderLineNewCode(newCode);
  }

  Future<OrderEx> findOrder(String trackingNumber) async {
    try {
      OrderEx? orderEx = await dataStore.ordersDao.getOrderExByTrackingNumber(trackingNumber);
      if (orderEx != null) return orderEx;

      ApiOrder apiOrder = await api.findOrder(trackingNumber: trackingNumber);
      orderEx = apiOrder.toDatabaseEnt();

      await dataStore.transaction(() async {
        await dataStore.ordersDao.updateOrderEx(orderEx!);
        if (orderEx.storageFrom != null) await dataStore.storagesDao.addStorage(orderEx.storageFrom!);
        if (orderEx.storageTo != null) await dataStore.storagesDao.addStorage(orderEx.storageTo!);
      });

      return orderEx;
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await App.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> updateOrder(OrderEx orderEx, Map<String, dynamic> data) async {
    try {
      ApiOrder newOrder = await api.updateOrder(id: orderEx.order.id, data: data);

      await _saveApiOrder(newOrder);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await App.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> confirmOrder(OrderEx orderEx) async {
    try {
      List<Map<String, int>> lines = orderEx.lines
        .map((e) => { 'id': e.line.id, 'factAmount': e.line.factAmount ?? e.line.amount })
        .toList();
      ApiOrder newOrder = await api.confirmOrder(id: orderEx.order.id, lines: lines);

      await _saveApiOrder(newOrder);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await App.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> cancelOrder(OrderEx orderEx) async {
    try {
      ApiOrder newOrder = await api.cancelOrder(id: orderEx.order.id);

      await _saveApiOrder(newOrder);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await App.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> transferOrder(OrderEx orderEx, Storage storage) async {
    try {
      ApiOrder newOrder = await api.transferOrder(id: orderEx.order.id, storageId: storage.id);

      await _saveApiOrder(newOrder);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await App.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> acceptOrder(OrderEx orderEx, Storage storage) async {
    try {
      ApiOrder newOrder = await api.acceptOrder(id: orderEx.order.id, storageId: storage.id);

      await _saveApiOrder(newOrder);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await App.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> acceptStorageTransferOrder(OrderEx orderEx) async {
    try {
      ApiOrder newOrder = await api.acceptStorageTransferOrder(id: orderEx.order.id);

      await _saveApiOrder(newOrder);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await App.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> acceptTransferOrder(OrderEx orderEx) async {
    try {
      ApiOrder newOrder = await api.acceptTransferOrder(id: orderEx.order.id);

      await _saveApiOrder(newOrder);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await App.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> acceptPayment(Order order, Map<dynamic, dynamic>? transaction) async {
    try {
      ApiOrder newOrder = await api.acceptPayment(
        id: order.id,
        summ: order.paySum,
        transaction: transaction
      );

      await dataStore.ordersDao.upsertOrder(order.id, newOrder.toDatabaseEnt().order.toCompanion(false));
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await App.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> saveOrderLineCodes(
    OrderEx orderEx,
    List<OrderLineNewCodeEx> newCodesEx
  ) async {
    try {
      ApiOrder newOrder = await api.saveOrderLineCodes(
        id: orderEx.order.id,
        codes: newCodesEx.map((e) => {
          'orderLineId': e.line.line.id,
          'code': e.newCode.code
        }).toList()
      );

      await dataStore.ordersDao.cleareOrderLineNewCodes();
      await _saveApiOrder(newOrder);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await App.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> _saveApiOrder(ApiOrder apiOrder) async {
    OrderEx orderEx = apiOrder.toDatabaseEnt();

    await dataStore.transaction(() async {
      await dataStore.ordersDao.updateOrderEx(orderEx);
      if (orderEx.storageFrom != null) await dataStore.storagesDao.addStorage(orderEx.storageFrom!);
      if (orderEx.storageTo != null) await dataStore.storagesDao.addStorage(orderEx.storageTo!);
    });
  }
}
