// ignore_for_file: use_key_in_widget_constructors

import 'package:flowerdecorations/project_imports.dart';

class DetailsPage extends StatefulWidget {
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final QrProcessing qr = QrProcessing();
  final GlobalKey _key = GlobalKey();
  bool isUploaded = false;

  @override
  Widget build(BuildContext context) {
    ///Accessing Current User Details
    final user = Provider.of<UserUID?>(context);

    return StreamBuilder<UserData>(
        stream: DataBaseServices(uid: user!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ///Current User Data is accessed from Cloud_Storage
            UserData? userData = snapshot.data;

            ///FullName is retrieved
            String fullName = userData!.fullName;

            ///Email is retrieved
            String email = userData.email;

            ///PhoneNumber is been retrieved and is been converted to string
            String phoneNumber = (userData.phoneNumber).toString();

            ///String is been created for creation of Barcode
            final qrcode =
                'FullName:$fullName\nEmail:$email\nPhone-Number:$phoneNumber';

            ///List of Maps having key as String Datatype and value as dynamic datatype.
            ///This variable will be useful in the creation of design for user details.
            final List<Map<String, dynamic>> _details = [
              {
                'Title': Strings.fullName,
                'Icon': ProjectIcons.fullNameIcon,
                'SubTitle': fullName,
              },
              {
                'Title': Strings.email,
                'Icon': ProjectIcons.emailIcon,
                'SubTitle': email,
              },
              {
                'Title': Strings.phoneNumber,
                'Icon': ProjectIcons.phoneNumberIcon,
                'SubTitle': phoneNumber,
              }
            ];

            return Scaffold(
              body: Container(
                width: ScreenUtil().screenWidth,
                height: ScreenUtil().screenHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.srcOver),
                      image: AssetImage(ImageStrings.detailsBG)),
                ),
                child: Stack(
                  children: <Widget>[
                    ///AppBar
                    buildAppBar(),

                    titleUI(32.w, 80.h, 36.sp, 4.sp, Strings.details),

                    cardsDetails(_details),

                    barcodeCard(qrcode, fullName, user),
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }

  Widget buildAppBar() {
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

  Widget cardsDetails(List<Map<String, dynamic>> details) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 120.h),
      child: ListView.builder(
        itemCount: details.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(5.sp),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.sp),
                side: BorderSide(width: 2.sp, color: ProjectColors.primaryT)),
            child: SizedBox(
              height: 65.h,
              child: ListTile(

                ///Icon
                leading: Container(
                    padding: EdgeInsets.only(top: 10.h, left: 5.w),
                    child: details[index]['Icon']),

                ///Title
                title: Text(
                  details[index]['Title'],
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: ProjectColors.primaryT,
                  ),
                ),

                ///SubTitle
                subtitle: Container(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Text(
                    details[index]['SubTitle'],
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget barcodeCard(String qrcode, fullName, user) {
    return Container(
      margin: EdgeInsets.only(top: 370.h),
      height: 225.h,
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.all(5.sp),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.sp),
            side: BorderSide(width: 2.sp, color: ProjectColors.primaryT)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ///RepaintBoundary will help to convert User Barcode to Imageformat which further will be uploaded
            RepaintBoundary(
              key: _key,

              ///This function will create QRCode image.
              child: QrImage(
                data: qrcode,
                version: QrVersions.auto,
                size: 150.sp,
                gapless: true,
                backgroundColor: Colors.white,
              ),
            ),

            ///Your Barcode Text
            Text(
              Strings.barcode,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: ProjectColors.primaryT,
              ),
            ),

            ///Upload Barcode Image
            SizedBox(
              height: 30.h,
              child: isUploaded
                  ? const SizedBox.shrink()
                  : ElevatedButton.icon(
                      onPressed: () => barcodeUpload(fullName, user),
                      icon: ProjectIcons.uploadIcon,
                      label: Text(
                        Strings.upload,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  barcodeUpload(fullName, user) async {
    ///QRImage with user details will be uploaded to Firebase Storage
    await qr.uploadImage(fullName, _key);

    ///URL of the QRImage will be retrieved
    final url = await qr.qrURL(fullName);

    ///URL will be stored in respective document of the user
    await DataBaseServices(uid: user!.uid).updateQRString(url);

    setState(() {
      isUploaded = true;
    });

    ///Text Creation for SnackBar
    final snackBar = SnackBar(
      content: Text(Strings.barcodeUploaded),
      backgroundColor: Colors.black,
    );

    ///SnackBar Creation
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}
