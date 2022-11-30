enum QRTypes {
  order,
  storage,
  productArrivalPackage,
  productArrival,
  storageUnloadPoint;

  String get typeName {
    switch (this) {
      case order:
        return 'ORDER';
      case storage:
        return 'STORAGE';
      case productArrivalPackage:
        return 'PRODUCT-ARRIVAL-PACKAGE';
      case productArrival:
        return 'PRODUCT-ARRIVAL';
      case storageUnloadPoint:
        return 'STORAGE-UNLOAD-POINT';
    }
  }
}
