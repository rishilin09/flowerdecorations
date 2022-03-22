// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:form_field_validator/form_field_validator.dart';
import 'package:flowerdecorations/project_imports.dart';

class LoginPage extends StatefulWidget {
  final Function toggleView;

  LoginPage({required this.toggleView});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// ignore: camel_case_types
class _LoginPageState extends State<LoginPage> {
  ///Declarations and Initializations
  final _formkey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String email = '';
  String password = '';
  String error = '';
  bool _passwordVisible = true;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    ///Error Text modifications
    final midPoint = error.isNotEmpty ? error.lastIndexOf('Internet') : 0;
    String invalidError = error.isNotEmpty ? error.substring(0, midPoint) : '';
    String connectionError =
        error.isNotEmpty ? error.substring(midPoint, error.length) : '';

    return loading
        ? Loading()
        : Scaffold(
            body: Container(
            width: ScreenUtil().screenWidth,
            height: ScreenUtil().screenHeight,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5), BlendMode.srcOver),
                    image: AssetImage(ImageStrings.loginBG))),
            child: SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  titleUI(43.w, 77.h, 36.sp, 4.sp, Strings.login),
                  Form(
                      key: _formkey,
                      child: loginBuild(invalidError, connectionError)),
                ],
              ),
            ),
          ));
  }

  Widget loginBuild(invalidError, connectionError) {
    return Stack(
      children: <Widget>[
        ///Email TextFormField
        Padding(
          padding: EdgeInsets.only(top: 233.h, left: 30.w, right: 30.w),
          child: SizedBox(
            width: 300.w,
            child: TextFormField(
              decoration: textInputDecoration.copyWith(
                  hintText: Strings.email,
                  prefixIcon: ProjectIcons.emailIcon,
                  errorStyle: TextStyle(
                      fontSize: 12.sp,
                      height: 1.h,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1.sp
                        ..color = ProjectColors.toggleColor)),
              validator: MultiValidator([
                RequiredValidator(errorText: Strings.rEmail),
                EmailValidator(errorText: Strings.eEmail),
              ]),
              onChanged: (val) {
                setState(() => email = val);
              },
            ),
          ),
        ),

        ///Password TextFormField
        Padding(
          padding: EdgeInsets.only(top: 329.h, left: 27.w, right: 27.w),
          child: SizedBox(
            width: 300.w,
            child: TextFormField(
              decoration: textInputDecoration.copyWith(
                  hintText: Strings.password,
                  prefixIcon: ProjectIcons.prefixPasswordIcon,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                    icon: Icon(_passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                  errorStyle: TextStyle(
                      fontSize: 12.sp,
                      height: 1.h,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1.sp
                        ..color = ProjectColors.toggleColor)),
              validator: MultiValidator([
                RequiredValidator(errorText: Strings.rPassword),
                LengthRangeValidator(
                    min: 8, max: 15, errorText: Strings.ePassword)
              ]),
              obscureText: _passwordVisible,
              onChanged: (val) {
                setState(() => password = val);
              },
            ),
          ),
        ),

        ///Login button
        Padding(
          padding: EdgeInsets.only(top: 429.h, left: 133.w),
          child: SizedBox(
            width: 100.w,
            child: ElevatedButton.icon(
              onPressed: () => loginProcess(),
              icon: ProjectIcons.loginIcon,
              label: Text(Strings.login),
              style: ElevatedButton.styleFrom(
                primary: ProjectColors.loginRegisterButton,
              ),
            ),
          ),
        ),

        ///Error Text
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(top: 480.h),
            child: Column(
              children: [
                Text(
                  invalidError,
                  style: TextStyle(color: Colors.red, fontSize: 14.sp),
                ),
                Text(
                  connectionError,
                  style: TextStyle(color: Colors.red, fontSize: 14.sp),
                ),
              ],
            ),
          ),
        ),

        ///Registration Toggle
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(
              top: 530.h,
            ),
            child: TextButton(
              onPressed: () => widget.toggleView(),
              child: Stack(children: [
                Text(
                  Strings.registration,
                  style: TextStyle(
                      fontSize: 16.sp,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1.sp
                        ..color = Colors.black),
                ),
                Text(
                  Strings.registration,
                  style: TextStyle(
                      fontSize: 16.sp, color: ProjectColors.toggleColor),
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }

  loginProcess() async {
    if (_formkey.currentState!.validate()) {
      setState(() => loading = true);
      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
      if (result == null) {
        setState(() {
          error =
              'Username/Password is incorrect or Internet Connection might not be initialized';
          loading = false;
        });
      }
    }
  }
}
