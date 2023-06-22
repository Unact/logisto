part of 'entities.dart';

class ApiOrder extends Equatable {
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
  final DateTime? storageIssued;
  final DateTime? storageAccepted;
  final DateTime? firstMovementDate;
  final DateTime? delivered;
  final double paidSum;
  final double paySum;
  final int documentsReturn;
  final List<ApiOrderLine> lines;
  final ApiStorage? storageFrom;
  final ApiStorage? storageTo;
  final int needMarkingScan;
  final DateTime? markingScanned;

  const ApiOrder({
    required this.id,
    required this.courierName,
    required this.trackingNumber,
    required this.number,
    required this.deliveryDate,
    this.deliveryDateTimeFrom,
    this.deliveryDateTimeTo,
    required this.statusName,
    required this.packages,
    required this.weight,
    required this.volume,
    required this.deliveryAddressName,
    required this.pickupAddressName,
    this.storageIssued,
    this.storageAccepted,
    this.firstMovementDate,
    this.delivered,
    required this.paidSum,
    required this.paySum,
    required this.documentsReturn,
    required this.lines,
    this.storageFrom,
    this.storageTo,
    required this.needMarkingScan,
    this.markingScanned,
  });

  factory ApiOrder.fromJson(dynamic json) {
    return ApiOrder(
      id: json['id'],
      courierName: json['courierName'],
      trackingNumber: json['trackingNumber'],
      number: json['number'],
      deliveryDate: Parsing.parseDate(json['deliveryDate'])!,
      deliveryDateTimeFrom: Parsing.parseDate(json['deliveryDateTimeFrom']),
      deliveryDateTimeTo: Parsing.parseDate(json['deliveryDateTimeTo']),
      statusName: json['statusName'],
      packages: json['packages'],
      weight: json['weight'],
      volume: json['volume'],
      deliveryAddressName: json['deliveryAddressName'],
      pickupAddressName: json['pickupAddressName'],
      storageIssued: Parsing.parseDate(json['storageIssued']),
      storageAccepted: Parsing.parseDate(json['storageAccepted']),
      firstMovementDate: Parsing.parseDate(json['firstMovementDate']),
      delivered: Parsing.parseDate(json['delivered']),
      paidSum: Parsing.parseDouble(json['paidSum'])!,
      paySum: Parsing.parseDouble(json['paySum'])!,
      documentsReturn: json['documentsReturn'],
      lines: json['lines'].map<ApiOrderLine>((e) => ApiOrderLine.fromJson(e)).toList(),
      storageFrom: json['storageFrom'] != null ? ApiStorage.fromJson(json['storageFrom']) : null,
      storageTo: json['storageTo'] != null ? ApiStorage.fromJson(json['storageTo']) : null,
      needMarkingScan: json['needMarkingScan'],
      markingScanned: Parsing.parseDate(json['markingScanned']),
    );
  }

  OrderEx toDatabaseEnt() {
    Order order = Order(
      id: id,
      courierName: courierName,
      trackingNumber: trackingNumber,
      number: number,
      deliveryDate: deliveryDate,
      deliveryDateTimeFrom: deliveryDateTimeFrom,
      deliveryDateTimeTo: deliveryDateTimeTo,
      statusName: statusName,
      packages: packages,
      weight: weight,
      volume: volume,
      deliveryAddressName: deliveryAddressName,
      pickupAddressName: pickupAddressName,
      storageIssued: storageIssued,
      storageAccepted: storageAccepted,
      storageFromId: storageFrom?.id,
      storageToId: storageTo?.id,
      firstMovementDate: firstMovementDate,
      delivered: delivered,
      paidSum: paidSum,
      paySum: paySum,
      documentsReturn: documentsReturn == 1,
      needMarkingScan: needMarkingScan == 1,
      markingScanned: markingScanned
    );
    List<OrderLineEx> orderLines = lines.map((line) {
        final product = line.product?.toDatabaseEnt();
        final orderLine = OrderLine(
          id: line.id,
          orderId: id,
          name: line.name,
          amount: line.amount,
          price: line.price,
          factAmount: line.factAmount,
          productId: product?.id
        );

        return OrderLineEx(orderLine, product);
    }).toList();
    Storage? storageFromOrder = storageFrom == null ? null : Storage(
      id: storageFrom!.id,
      name: storageFrom!.name,
      sequenceNumber: storageFrom!.sequenceNumber
    );
    Storage? storageToOrder = storageTo == null ? null : Storage(
      id: storageTo!.id,
      name: storageTo!.name,
      sequenceNumber: storageTo!.sequenceNumber
    );

    return OrderEx(order, orderLines, storageFromOrder, storageToOrder);
  }

  @override
  List<Object?> get props => [
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
    storageIssued,
    storageAccepted,
    firstMovementDate,
    delivered,
    paidSum,
    paySum,
    documentsReturn,
    lines,
    storageFrom,
    storageTo,
    needMarkingScan,
    markingScanned
  ];
}
