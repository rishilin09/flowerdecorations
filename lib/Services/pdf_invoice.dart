import 'package:flowerdecorations/project_imports.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfInvoice {
  static Future<File> generate(Invoice invoice) async {
    final String title = invoice.title;

    ///UserDetails Variable
    UserData userData = invoice.userdata;

    ///If the qrImg is null then qrImg will be set to 'No URL' else it will take the
    ///invoice.userdata.url value
    final qrImg =
        userData.url != 'No URL' ? await networkImage(userData.url) : 'No URL';

    ///invoice.date will be stored in variable date of type DateTime
    final DateTime date = invoice.date;

    final String paymentMethod = invoice.payMethod;

    final double total = invoice.selectedItems.total;

    final List<Map<String, dynamic>> items =
        invoice.selectedItems.selectedItems;

    final String occasion = invoice.selectedItems.occasion;

    ///Formatting the date and storing into String dateTime variable
    final d = '${date.day}/${date.month}/${date.year} : ';
    final t = '${date.hour}:${date.minute}:${date.second}';
    final String dateTime = d + t;

    List<String> names = userData.fullName.split(' ');
    String firstName = names[0];
    String lastName = (names.length > 2) ? names[names.length - 1] : names[1];
    String nameCode = firstName.substring(0, 1) + lastName.substring(0, 1);

    final occasionI = occasionInitial(occasion);
    final invoiceNumber =
        '$occasionI$nameCode${date.day}${date.month}${date.year}';

    final List<Map<String, dynamic>> finalList = [];
    for (var item in items) {
      finalList.add({'title': item['title'], 'price': item['price']});
    }
    final header = {'title': 'Items', 'price': 'Unit Price'};
    finalList.insert(0, header);

    ///myTheme will have base, bold, italic, boldItalic font types used for building invoice
    ///withFont is defined method in pdf.dart file which takes base, bold, italic, boldItalic as parameters
    var myTheme = pw.ThemeData.withFont(
      base:
          Font.ttf(await rootBundle.load("assets/fonts/OpenSans-Regular.ttf")),
      bold: Font.ttf(await rootBundle.load("assets/fonts/OpenSans-Bold.ttf")),
      italic:
          Font.ttf(await rootBundle.load("assets/fonts/OpenSans-Italic.ttf")),
      boldItalic: Font.ttf(
          await rootBundle.load("assets/fonts/OpenSans-BoldItalic.ttf")),
    );

    /// Document will be created where all the details will be laid out
    final pdf = pw.Document();

    ///This Function creates invoice with pdf filetype.
    ///addPage will created pages for document which takes MultiPage as parameter.
    ///MultiPage takes two parameters pageTheme and build.
    ///pageTheme will built the theme of document with fonts,decoration etc
    ///build method takes series of widgets which will be build into document. It will build according
    ///to the order it is placed in the build method.
    ///Prefix pw is used with widgets which indicates that we are using widgets from pdf.dart package
    ///and not from material.dart package.
    pdf.addPage(pw.MultiPage(
      pageTheme: _buildTheme(
          dateTime, invoiceNumber, paymentMethod, PdfPageFormat.a4, myTheme),
      build: (context) => [
        pw.Text(title,
            style: pw.TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
        pw.SizedBox(height: 1.0 * PdfPageFormat.cm),
        buildUserDetails(userData, qrImg),
        pw.SizedBox(height: 0.8 * PdfPageFormat.cm),
        orderText(occasion),
        pw.SizedBox(height: 1.0 * PdfPageFormat.cm),
        buildInvoice(10, finalList),
        // pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
        buildPay(total, 25.0),
      ],
    ));

    ///Document will be saved
    return PdfApi.saveDocument('Invoice-$invoiceNumber.pdf', pdf);
  }

  ///Building PageTheme for PDF file
  static pw.PageTheme _buildTheme(dateTime, invoiceNumber, payMethod,
          PdfPageFormat pageFormat, theme) =>
      pw.PageTheme(
        pageFormat: pageFormat,
        theme: theme,
        buildBackground: (context) => pw.FullPage(
            ignoreMargins: true,
            child: invoiceUI(dateTime, invoiceNumber, payMethod, 500.0, 720.0)),
      );

  ///PDF background UI
  static pw.Widget invoiceUI(
          dateTime, invoiceNumber, paymentMethod, horizontal, vertical) =>
      pw.Stack(children: [
        pw.Positioned(
          left: horizontal,
          bottom: vertical,
          child: pw.Container(
            alignment: pw.Alignment.topRight,
            width: 200,
            height: 200,
            decoration: pw.BoxDecoration(
                shape: pw.BoxShape.circle,
                color:
                    PdfColor.fromHex('D91919')), //PdfColor.fromHex('02D1E1CC')
          ),
        ),

        ///Primary Circle
        pw.Positioned(
          right: horizontal,
          top: vertical,
          child: pw.Container(
            width: 200,
            height: 200,
            decoration: pw.BoxDecoration(
                shape: pw.BoxShape.circle, color: PdfColor.fromHex('DEB343')),
          ),
        ),

        pw.Positioned(
          left: 105,
          top: 800,
          child: invoiceTexts(
              'Payment was done via $paymentMethod', 12.sp, 10.0, true),
        ),

        pw.Positioned(
            left: horizontal - 160.0,
            top: vertical + 50.0,
            child: pw.Column(children: [
              pw.Row(children: [
                invoiceTexts(Strings.invoiceNumber + ':', 15.0, 5.0, false),
                invoiceTexts(invoiceNumber, 15.0, 5.0, true)
              ]),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                invoiceTexts('Date:', 15.0, 5.0, false),
                invoiceTexts(dateTime, 15.0, 5.0, true)
              ])
            ])),
      ]);

  static pw.Widget invoiceTexts(text, fontSize, padding, isBold) => pw.Align(
      alignment: pw.Alignment.center,
      child: pw.Container(
          padding: pw.EdgeInsets.all(padding), //20
          child: pw.Text(text,
              style: pw.TextStyle(
                  fontSize: fontSize,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal))));

  ///PDF User Details
  static pw.Widget buildUserDetails(userData, qrImg) => pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(Strings.invoice,
                      style: pw.TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                  pw.SizedBox(height: 1.0 * PdfPageFormat.cm),
                  userInvoiceDetails(Strings.fullName + ':', userData.fullName),
                  userInvoiceDetails(Strings.email + ':', userData.email),
                  userInvoiceDetails(Strings.phoneNumber + ':',
                      (userData.phoneNumber).toString()),
                ]),
            qrImg != 'No URL'
                ? pw.Container(height: 100, width: 100, child: pw.Image(qrImg))
                : pw.Container(
                    height: 100,
                    width: 100,
                    alignment: pw.Alignment.center,
                    padding: const pw.EdgeInsets.all(2),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black),
                    ),
                    child: pw.Text('QR Code was not uploaded from details page',
                        style: const pw.TextStyle(fontSize: 12)))
          ]);

  ///User Details Builder
  static pw.Row userInvoiceDetails(field, value) => pw.Row(children: [
        pw.Text(field, //Strings.fullName+':',
            style: pw.TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        pw.SizedBox(width: 0.5 * PdfPageFormat.cm),
        pw.Text(value, //invoice.userdata.fullName,
            style: const pw.TextStyle(fontSize: 15)),
      ]);

  ///Order Text
  static pw.Text orderText(String text) => pw.Text(Strings.orderPlaced + text,
      style: pw.TextStyle(fontSize: 20, fontWeight: FontWeight.bold));

  ///Item details Builder will be created in the form of Table
  static pw.Widget buildInvoice(
          double padding, List<Map<String, dynamic>> finalList) =>
      pw.Table(
          border: pw.TableBorder.all(),
          defaultColumnWidth: const pw.FixedColumnWidth(50),
          defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
          children: finalList.map((item) {
            return invoiceRows(15.0, padding, item, finalList);
          }).toList());

  ///Individual Items details
  static pw.TableRow invoiceRows(double size, double padding,
          Map<String, dynamic> item, List<Map<String, dynamic>> finalList) =>
      pw.TableRow(children: [
        invoiceTexts('${item['title']}', size, padding,
            finalList.indexOf(item) == 0 ? true : false),
        invoiceTexts('${item['price']}', size, padding,
            finalList.indexOf(item) == 0 ? true : false),
      ]);

  ///Total Amount will be displayed
  static pw.Widget buildPay(double total, double padding) => pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
              invoiceTexts('Total:', 20.0, padding, true),
              pw.Container(
                  decoration: pw.BoxDecoration(
                      border: pw.Border(
                          bottom: pw.BorderSide(
                              color: PdfColor.fromHex('0C55E2FF'), width: 5))),
                  child: invoiceTexts('Rs.$total', 20.0, padding, true))
            ]),
          ]);
}

String occasionInitial(occasion) {
  String initial = '';
  switch (occasion) {
    case 'Wedding':
      {
        initial = 'W';
      }
      break;

    case 'Religious Occasions':
      {
        initial = 'RO';
      }
      break;

    case 'Home Occasions':
      {
        initial = 'HO';
      }
      break;

    case 'Baby Shower':
      {
        initial = 'BS';
      }
      break;

    case 'Cars':
      {
        initial = 'C';
      }
      break;

    default:
      {
        initial = 'O';
      }
  }
  return initial;
}
