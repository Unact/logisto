part of 'entities.dart';

class ApiOrder {
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
  final ApiOrderStorage? storageFrom;
  final ApiOrderStorage? storageTo;

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
    this.storageTo
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
      storageFrom: json['storageFrom'] != null ? ApiOrderStorage.fromJson(json['storageFrom']) : null,
      storageTo: json['storageTo'] != null ? ApiOrderStorage.fromJson(json['storageTo']) : null,
    );
  }

  OrderExtended toDatabaseEnt() {
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
      documentsReturn: documentsReturn == 1
    );
    List<OrderLine> orderLines = lines.map((e) => OrderLine(
      id: e.id,
      orderId: id,
      name: e.name,
      amount: e.amount,
      price: e.price,
      factAmount: e.factAmount
    )).toList();
    OrderStorage? storageFromOrder = storageFrom == null ? null : OrderStorage(
      id: storageFrom!.id,
      name: storageFrom!.name,
      sequenceNumber: storageFrom!.sequenceNumber
    );
    OrderStorage? storageToOrder = storageTo == null ? null : OrderStorage(
      id: storageTo!.id,
      name: storageTo!.name,
      sequenceNumber: storageTo!.sequenceNumber
    );

    return OrderExtended(order, orderLines, storageFromOrder, storageToOrder);
  }
}
