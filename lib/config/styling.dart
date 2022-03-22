import 'package:flutter/material.dart';

///This class will contain all the colors required during building project
class ProjectColors {
  ProjectColors._();

  static const loginRegisterButton = Color.fromRGBO(246, 122, 73, 1);
  static const toggleColor = Color.fromRGBO(255, 0, 0, 1);
  static const formFieldBordersFocused = Color.fromRGBO(248, 59, 0, 1);
  static const formFieldBordersActive = Color.fromRGBO(255, 111, 69, 1);
  static const primaryT = Color.fromRGBO(217, 25, 25, 0.81);
  static const secondaryT = Color.fromRGBO(222, 179, 67, 0.81);
  static const primary = Colors.deepOrange; //(217, 25, 25, 1);
  static const secondary = Colors.red; //(222, 179, 67, 1);

}

///This class will contain all the image strings required during building project
class ImageStrings {
  ImageStrings._();

  static String splashLogo = 'assets/SVG/SplashScreenLogo.svg';
  static String confirmedImg = 'assets/SVG/confirmed.svg';
  static String splashBG = 'assets/JPG/Splash_Screen_BG.jpg';
  static String loginBG = 'assets/JPG/Login_Page_BG.jpg';
  static String registerBG = 'assets/JPG/Register_Page_BG.jpg';
  static String transactionBG = 'assets/JPG/Transaction_Page_BG.jpg';
  static String detailsBG = 'assets/JPG/Details_Page_BG.jpg';
  static String finalBG = 'assets/JPG/Final_Page_BG.jpg';
  static String cash = 'assets/PNG/cash.png';
  static String card = 'assets/PNG/card.png';
  static String invoiceImg = 'assets/PNG/flowerUI.png';
  static String netBanking = 'assets/PNG/net-banking.png';
  static String upi = 'assets/PNG/upi.png';
  static String wedding = 'assets/PNG/wedding.png';
  static String temple = 'assets/PNG/temple.png';
  static String home = 'assets/PNG/home.png';
  static String babyShower = 'assets/PNG/baby-shower.png';
  static String car = 'assets/PNG/car.png';
  static String others = 'assets/PNG/others.png';
}

///This class will contain all the string values required during building project
class Strings {
  Strings._();

  static String title = 'Flower Decorations';
  static String flower = 'Flower';
  static String decoration = 'Decorations';
  static String login = 'Login';
  static String invoice = 'Invoice';
  static String logout = 'LogOut';
  static String register = 'Register';
  static String details = 'Details';
  static String upload = 'Upload';
  static String email = 'Email';
  static String password = 'Password';
  static String fullName = 'FullName';
  static String phoneNumber = 'Phone Number';
  static String registration = 'Not a User? Create Account';
  static String signIn = 'Already a User?';
  static String fPassword = 'Forgot Password?';
  static String rEmail = 'Email is Required';
  static String rPassword = 'Password is Required';
  static String rPhoneNumber = 'PhoneNumber is Required';
  static String rFullName = 'FullName is required';
  static String eEmail = 'Enter valid email';
  static String ePassword = 'Enter a password between 8 and 15 characters';
  static String ePhoneNumber = 'Enter a 10-digit Number';
  static String services = 'Select your desired service';
  static String noOfClothes = 'Enter the no of the clothes';
  static String download = 'Download';
  static String successOrder = 'Your order has been placed successfully';
  static String barcodeUploaded = 'Your Barcode has been successfully uploaded';
  static String downloadInvoice = 'Download your Invoice';
  static String successRegister = 'You have successfully been register!!!';
  static String barcode = 'This is your Generated Barcode';
  static String orderPlaced = 'Order Placed for ';
  static String invoiceNumber = 'Invoice Number';
  static String selectPayMethod = 'Select your payment method';
  static String pay = 'PAY';
  static String imgRetrieveError = "Error couldn't load images";
  static String add = 'Add';
  static String remove = 'Remove';
}

///This class will contain all the icons required during building project
class ProjectIcons {
  ProjectIcons._();

  static const loginIcon = Icon(Icons.login);
  static const emailIcon = Icon(Icons.email_outlined);
  static const prefixPasswordIcon = Icon(Icons.vpn_key_outlined);
  static const fullNameIcon = Icon(Icons.people_alt_rounded);
  static const phoneNumberIcon = Icon(Icons.phone);
  static const popIcon = Icon(Icons.arrow_back_ios_rounded);
  static const downloadIcon = Icon(Icons.download_rounded);
  static const detailsIcon = Icon(Icons.people_alt_rounded);
  static const logOutIcon = Icon(Icons.logout);
  static const uploadIcon = Icon(Icons.arrow_circle_up);
  static const addIcon = Icon(Icons.add_circle_outline);
  static const removeIcon = Icon(Icons.remove_circle_outline);
}

///Gradient with Transparency value
LinearGradient gradientLayoutT = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      ProjectColors.primaryT,
      ProjectColors.secondaryT,
    ]);

///Gradient without Transparency value
LinearGradient gradientLayout = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      ProjectColors.primary,
      ProjectColors.secondary,
    ]);
