// ignore_for_file: use_key_in_widget_constructors

import 'package:flowerdecorations/project_imports.dart';
import 'package:telephony/telephony.dart';

class FinalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserUID?>(context);

    final contents = ModalRoute.of(context)!.settings.arguments as List;
    final payMethod = contents[1];
    final selectedItems = contents[0] as SelectedItems;

    return StreamBuilder(
        stream: DataBaseServices(uid: user!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data as UserData?;
            final invoice = Invoice(
                title: Strings.title,
                userdata: UserData(
                    fullName: userData!.fullName,
                    email: userData.email,
                    phoneNumber: userData.phoneNumber,
                    url: userData.url),
                selectedItems: selectedItems,
                date: DateTime.now(),
                payMethod: payMethod);
            return Scaffold(
              body: Container(
                width: ScreenUtil().screenWidth,
                height: ScreenUtil().screenHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.srcOver),
                      image: AssetImage(ImageStrings.finalBG)),
                ),
                child: Stack(
                  children: <Widget>[
                    titleUI(20.w, 110.h, 25.sp, 4.sp, Strings.successOrder),

                    //SVG Image
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: 220.h),
                        child: SizedBox(
                          width: 150.w,
                          height: 160.h,
                          child: SvgPicture.asset(ImageStrings.confirmedImg),
                        ),
                      ),
                    ),

                    titleUI(52.w, 420.h, 25.sp, 4.sp, Strings.downloadInvoice),

                    downloadButton(context, invoice)
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }

  ///Invoice Download
  Widget downloadButton(BuildContext context, Invoice invoice) {
    return Padding(
      padding: EdgeInsets.only(top: 497.h, bottom: 65.h),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 178.w,
          height: 78.h,
          child: ElevatedButton.icon(
            onPressed: () async {
              final Telephony telephony = Telephony.instance;
              final String message =
                  messageBuild(invoice.userdata, invoice.selectedItems);
              telephony.sendSms(
                  to: "7021058163", message: message, isMultipart: true);
              final pdfFile = await PdfInvoice.generate(invoice);
              return PdfApi.openFile(pdfFile);
            },
            icon: ProjectIcons.downloadIcon,
            label: Text(
              Strings.download,
              style: TextStyle(
                fontSize: 20.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String messageBuild(UserData userdata, SelectedItems selectedItems) {
    String message = '';
    final customer = 'Customer ${userdata.fullName}has placed order for\n';
    final String itemTitles = itemMessage(selectedItems.selectedItems);
    final total = '\nand total will be Rs.${selectedItems.total}';
    message += customer + itemTitles + total;
    return message;
  }

  String itemMessage(data) {
    List itemTitle = [];
    String itemMsg = '';
    for (var item in data) {
      itemTitle.add(item['title']);
    }
    itemMsg = itemTitle.join('\n');
    return itemMsg;
  }
}
