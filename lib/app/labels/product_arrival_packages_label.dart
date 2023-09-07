import 'package:u_app_utils/u_app_utils.dart';

import '/app/data/database.dart';
import '/app/services/printer.dart';

class ProductArrivalPackagesLabel {
  final ProductArrivalEx productArrivalEx;
  final Printer _printer = Printer();

  ProductArrivalPackagesLabel({
    required this.productArrivalEx
  });

  Future<void> print({
    required Function onError,
    int amount = 1
  }) async {
    String labelCommand = productArrivalEx.packages.map((e) {
      String formattedDate = Format.dateStr(productArrivalEx.productArrival.arrivalDate);
      String command = '''
        SIZE 2.8,4.61
        GAP 0.18,0
        CODEPAGE UTF-8
        COUNTRY 061
        DIRECTION 0
        CLS
        QRCODE 130,100,Q,10,A,0,M2,"${e.package.qr}"
        TEXT 300,460,"5",0,1,1,2,"${e.package.number}"
        TEXT 300,530,"3",0,1,1,2,"Приемка #${productArrivalEx.productArrival.number} от $formattedDate"
        TEXT 300,560,"3",0,1,1,2,"Всего мест: ${productArrivalEx.packages.length}"
        PRINT 1,$amount
      ''';

      return command;
    }).toList().join('\n');

    _printer.printLabel(labelCommand, onError: onError);
  }
}
