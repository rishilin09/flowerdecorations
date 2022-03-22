// ignore_for_file: use_key_in_widget_constructors

import 'package:flowerdecorations/project_imports.dart';

///This class will build loading page after User Signs In or User gets newly register
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradientLayoutT,
      ),
      child: Center(
        child: SpinKitThreeInOut(
          color: Colors.white,
          size: 50.h,
        ),
      ),
    );
  }
}

// static const primary = Color.fromRGBO(217, 25, 25, 1);
// static const secondary = Color.fromRGBO(222, 179, 67, 1);
