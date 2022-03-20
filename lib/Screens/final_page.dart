// ignore_for_file: use_key_in_widget_constructors

import 'package:flowerdecorations/Shared_Widgets/titleUI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../config/styling.dart';

class FinalPage extends StatelessWidget {

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
                image: AssetImage(ImageStrings.finalBG)
            ),
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

            downloadButton()
          ],
        ),
      ),
    );
  }

  ///Invoice Download
  Widget downloadButton() {
    return Padding(
      padding: EdgeInsets.only(top: 497.h, bottom: 65.h),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 178.w,
          height: 78.h,
          child: ElevatedButton.icon(
            onPressed: () {},
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


}
