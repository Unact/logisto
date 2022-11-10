enum QRTypes {
  order,
  storage,
  productArrivalPackage;

  String get typeName {
    switch (this) {
      case order:
        return 'ORDER';
      case storage:
        return 'STORAGE';
      case productArrivalPackage:
        return 'PRODUCT-ARRIVAL-PACKAGE';
    }
  }
}
