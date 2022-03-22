// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flowerdecorations/project_imports.dart';
import 'package:form_field_validator/form_field_validator.dart';

///This Class will show RegisterPage for users if account is not been registered
class RegisterPage extends StatefulWidget {
  final Function toggleView;

  RegisterPage({required this.toggleView});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  ///Declarations and Initializations
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  String fullName = '';
  String email = '';
  String password = '';
  final String url = 'No URL';
  int phoneNumber = 0;
  String error = '';
  bool loading = false;
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    ///If loading yields to be true then it will be redirected to Loading function in Loading.dart file
    ///else if it is false then Login Page will be displayed. This will happen when user has inputted
    ///some wrong values and it doesn't get authorized.
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
                      image: AssetImage(ImageStrings.registerBG))),
              child: SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    ///PageUI
                    titleUI(31.w, 83.h, 36.sp, 4.sp, Strings.register),

                    ///Register Form
                    Form(key: _formkey, child: registerBuild()),
                  ],
                ),
              ),
            ),
          );
  }

  ///Building Registration form
  Widget registerBuild() {
    return Stack(
      children: <Widget>[
        ///FullName TextFormField
        Padding(
          padding: EdgeInsets.only(top: 165.h, left: 30.w, right: 30.w),
          child: SizedBox(
            width: 300.w,
            child: TextFormField(
              decoration: textInputDecoration.copyWith(
                  hintText: Strings.fullName,
                  prefixIcon: ProjectIcons.fullNameIcon,
                  errorStyle: TextStyle(
                      fontSize: 12.sp,
                      height: 1.h,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1.sp
                        ..color = ProjectColors.toggleColor)),
              validator: RequiredValidator(errorText: Strings.rFullName),
              onChanged: (val) {
                setState(() => fullName = val);
              },
            ),
          ),
        ),

        ///Email TextFormField
        Padding(
          padding: EdgeInsets.only(top: 245.h, left: 30.w, right: 30.w),
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
          padding: EdgeInsets.only(top: 325.h, left: 30.w, right: 30.w),
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

        ///PhoneNumber TextFormField
        Padding(
          padding: EdgeInsets.only(top: 405.h, left: 30.w, right: 30.w),
          child: SizedBox(
            width: 300.w,
            child: TextFormField(
              decoration: textInputDecoration.copyWith(
                hintText: Strings.phoneNumber,
                prefixIcon: ProjectIcons.phoneNumberIcon,
                errorStyle: TextStyle(
                    fontSize: 12.sp,
                    height: 1.h,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1.sp
                      ..color = ProjectColors.toggleColor),
              ),
              keyboardType: TextInputType.number,
              validator: MultiValidator([
                RequiredValidator(errorText: Strings.rPhoneNumber),
                LengthRangeValidator(
                    min: 10, max: 10, errorText: Strings.ePhoneNumber),
              ]),
              onChanged: (val) {
                setState(() => val.isNotEmpty
                    ? phoneNumber = int.parse(val)
                    : phoneNumber = int.parse('0'));
              },
            ),
          ),
        ),

        ///Error Text
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(top: 480.h),
            child: Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 14.sp),
            ),
          ),
        ),

        ///Register button
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 510.h),
          child: ElevatedButton.icon(
            onPressed: () => registerProcess(),
            icon: ProjectIcons.loginIcon,
            label: Text(Strings.register),
            style: ElevatedButton.styleFrom(
              primary: ProjectColors.loginRegisterButton,
            ),
          ),
        ),

        ///LoginPage Toggle
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(
              top: 564.h,
            ),
            child: TextButton(
              onPressed: () => widget.toggleView(),
              child: Stack(children: [
                Text(
                  Strings.signIn,
                  style: TextStyle(
                      fontSize: 16.sp,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1.sp
                        ..color = Colors.black),
                ),
                Text(
                  Strings.signIn,
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

  ///Registration Process
  ///This function will validate all the TextFormFields with help of '_formkey.currentState!.validate()'.
  ///Since we declared the key globally for all the FormFields it will check the currentState of each and
  ///every field combined. If the validation comes out to be true then state of loading variable will be
  ///changed to True and the registration process will be carried out by calling '_auth.registerWithEmailAndPassword'
  ///function which takes email,password,fullName and URL as the parameters. Since it is a await function it
  ///will wait for the process to be completed to proceed further. If the result of the function is null then
  ///error message will be thrown and the state of the loading will be set to false again. If it is not null
  ///then user will get register in FireBase and the 'AuthService().user' in main.dart file will start to
  ///stream UserUID object values which contains UID of the user. Wrapper() widget will catch the provided
  ///values and since user is not null it will redirect to HomePage() widget.
  registerProcess() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      dynamic result = await _auth.registerWithEmailAndPassword(
          email, password, fullName, phoneNumber, url);
      if (result == null) {
        setState(() {
          error = 'Please supply a valid details';
          loading = false;
        });
      }
    }
  }
}
