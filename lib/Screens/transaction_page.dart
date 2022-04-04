// ignore_for_file: use_key_in_widget_constructors

import 'package:flowerdecorations/project_imports.dart';

///This class will be a dummy payment gateway page where user will select
///any of the desired payment method
class TransactionPage extends StatelessWidget {
  final List<Map<String, dynamic>> paymentMethods = [
    {'method': 'Net Banking', 'image': ImageStrings.netBanking},
    {'method': 'Debit card', 'image': ImageStrings.card},
    {'method': 'UPI', 'image': ImageStrings.upi},
    {'method': 'Cash', 'image': ImageStrings.cash},
  ];

  @override
  Widget build(BuildContext context) {
    final items = ModalRoute.of(context)!.settings.arguments as SelectedItems;
    final total = items.total;

    return Scaffold(
      body: Container(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.srcOver),
                image: AssetImage(ImageStrings.transactionBG))),
        child: Stack(
          children: <Widget>[
            ///Title
            titleUI(159.w, 51.h, 25.sp, 4.sp, Strings.pay),

            ///Pay and total texts
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding:
                    EdgeInsets.only(top: 100.h),
                child: Stack(children: [
                  Text(
                    'Rs.$total',
                    style: TextStyle(
                        fontSize: 36.sp,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 4
                          ..color = Colors.black),
                  ),
                  Text(
                    'Rs.$total',
                    style: TextStyle(fontSize: 36.sp, color: Colors.white),
                  ),
                ]),
              ),
            ),

            ///select payment method text
            titleUI(17.w, 176.h, 18.sp, 4.sp, Strings.selectPayMethod),

            ///Appbar
            buildAppBar(context),

            ///List of Payment Methods
            payMethod(items),
          ],
        ),
      ),
    );
  }

  ///List of Payment Methods
  Widget payMethod(SelectedItems items) {
    return Container(
      alignment: Alignment.center,
      //color: Colors.transparent.withOpacity(0.5),
      padding: EdgeInsets.only(top: 180.h),
      child: ListView.builder(
          itemCount: paymentMethods.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 85.h,
              child: Card(
                shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        color: ProjectColors.formFieldBordersActive,
                        width: 0.5),
                    borderRadius: BorderRadius.circular(5)),
                child: Theme(
                  data: ThemeData(
                    //highlightColor: ProjectColors,
                    fontFamily: 'Ubuntu',
                  ),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.h),
                    onTap: () {
                      ///Navigation to FinalPage() with selected payment method and selectedItems as a argument,
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FinalPage(),
                              settings: RouteSettings(arguments: [
                                items,
                                paymentMethods[index]['method']
                              ])));
                    },
                    title: Text(
                      paymentMethods[index]['method'],
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    leading: Container(
                      width: 60.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(paymentMethods[index]['image']),
                        ),
                      ),
                    ),
                    trailing: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15.sp),
                            bottomRight: Radius.circular(15.sp)),
                        color: ProjectColors.loginRegisterButton,
                      ),
                      width: 10.sp,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  ///Appbar
  Widget buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      elevation: 0.0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: ProjectIcons.popIcon,
        color: ProjectColors.loginRegisterButton,
        iconSize: 30.sp,
      ),
    );
  }
}
