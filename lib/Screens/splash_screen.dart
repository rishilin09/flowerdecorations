
// ignore_for_file: use_key_in_widget_constructors

import 'package:flowerdecorations/project_imports.dart';


class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {

  late Timer _timer;

  ///initState() will run only once in the whole widget tree of SplashScreen class.
  ///It is very similar to Java start() which runs only once in the whole program.
  @override
  void initState() {
    super.initState();
    _timer = Timer(
        const Duration(seconds: 5),

        ///pushReplacement will push the provided Widget('Wrapper()') in the
        ///replacement of the previous Widget('SplashScreen()') and context will also
        ///get shifted.
            () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Wrapper())));
  }

  ///dispose() method will be run at last when the context is shifted or being killed.
  ///It is very similar to Java destroy() which runs at the end of the program.
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }


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
                image: AssetImage(ImageStrings.splashBG),
              )
          ),

          child: Stack(
            children: <Widget>[

              Padding(
                padding: EdgeInsets.only(top: 108.h),//EdgeInsets.fromLTRB(15.w, 108.h, 13.w, 229.h),
                child: SvgPicture.asset(
                  ImageStrings.splashLogo,
                  width: 350.w,
                  height: 300.h,
                  color: Colors.white,
                ),
              ),

              titleUI(200.w, 251.h, 30.sp, 4.sp, Strings.flower),

              titleUI(125.w, 285.h, 30.sp, 4.sp, Strings.decoration),

              Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(51.w, 425.h, 52.w, 110.h),
                  child: SpinKitThreeInOut(
                    color: Colors.white,
                    size: 50.w,
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
