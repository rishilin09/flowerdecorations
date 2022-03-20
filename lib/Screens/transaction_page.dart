// ignore_for_file: use_key_in_widget_constructors

import 'package:flowerdecorations/Shared_Widgets/titleUI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../config/styling.dart';

class TransactionPage extends StatelessWidget {

  final List<Map<String, dynamic>> paymentMethods = [
    {'method': 'Net Banking', 'image': ImageStrings.netBanking},
    {'method': 'Debit or Credit cards', 'image': ImageStrings.card},
    {'method': 'UPI', 'image': ImageStrings.upi},
    {'method': 'Cash', 'image': ImageStrings.cash},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.srcOver),
              image: AssetImage(ImageStrings.transactionBG)
          )
        ),
        child: Stack(
          children: <Widget>[

            titleUI(159.w, 51.h, 25.sp, 4.sp, Strings.pay),

            titleUI(134.w, 100.h, 36.sp, 4.sp, 'Rs 20'),
            
            titleUI(17.w, 176.h, 18.sp, 4.sp, Strings.selectPayMethod),

            buildAppBar(context),

            payMethod(),

          ],
        ),
      ),
    );
  }

 Widget payMethod() {
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
                   side: const BorderSide(color: ProjectColors.formFieldBordersActive, width: 0.5),
                   borderRadius: BorderRadius.circular(5)),
               child: Theme(
                 data: ThemeData(
                   //highlightColor: ProjectColors,
                   fontFamily: 'Ubuntu',
                 ),
                 child: ListTile(

                   contentPadding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 15.h),
                   onTap: () {},
                   title: Text(
                       paymentMethods[index]['method']
                   ),
                   leading: Container(
                     width: 60.w,
                     alignment: Alignment.center,
                     decoration: BoxDecoration(
                       image: DecorationImage(
                         image: AssetImage(
                             paymentMethods[index]['image']),
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
