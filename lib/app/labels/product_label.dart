import '/app/data/database.dart';
import '/app/services/printer.dart';
import '/app/utils/format.dart';

class ProductLabel {
  final Product product;
  final User user;
  final Printer _printer = Printer();

  ProductLabel({
    required this.product,
    required this.user
  });

  Future<void> print({ required Function onError }) async {
    String? barcodeType;

    switch (product.barcodeType) {
      case 'code128':
        barcodeType = '128';
        break;
      case 'ean13':
        barcodeType = 'EAN13';
        break;
    }

    String formattedDate = Format.dateTimeStr(DateTime.now());
    String wrappedName = Format.wrapLine(product.name, 35).asMap().entries.map((entry) {
      return 'TEXT 10,${40 + 30 * entry.key},"3",0,1,1,"${entry.value}"';
    }).join('\n');
    String article = product.article ?? '';
    int articleLen = ((Printer.kPaperWidth - (100 * article.length/8))/2).ceil();

    String labelCommand = '''
      SIZE 2.8,4.61
      GAP 0.18,0
      CODEPAGE UTF-8
      COUNTRY 061
      DIRECTION 0
      CLS
      $wrappedName
      TEXT ${articleLen < 0 ? 0 : articleLen},200,"0",0,10,10,"$article"
      BARCODE 50,300,"$barcodeType",200,2,0,5,2,"${product.barcodeCode}"
      TEXT 10,900,"2",0,1,1,"$formattedDate ${user.username}"
      PRINT 1,1
    ''';

    _printer.printLabel(labelCommand, onError: onError);
  }
}
