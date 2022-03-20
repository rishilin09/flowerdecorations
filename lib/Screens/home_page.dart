// ignore_for_file: use_key_in_widget_constructors

import 'package:flowerdecorations/Screens/selection_page.dart';
import 'package:flowerdecorations/project_imports.dart';

import '../Shared_Widgets/image_data.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final AuthService _auth = AuthService();
  final imageData = ImageDataInfo();

  final List<Map<String,dynamic>> servicesList = [
    {'occasion':'Wedding', 'image':ImageStrings.wedding},
    {'occasion':'Religious Occasions', 'image':ImageStrings.temple},
    {'occasion':'Home Occasions', 'image':ImageStrings.home},
    {'occasion':'Baby Shower', 'image':ImageStrings.babyShower},
    {'occasion':'Cars', 'image':ImageStrings.car},
    {'occasion':'Others', 'image':ImageStrings.others}
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: <Widget>[

          ///Logo and Background
          homeLogo(),

          ///HomeBar
          homeBar(),

          titleUI(18.w, 197.h, 24.sp, 4.sp, Strings.services),

          ///Services List
          services()

        ],
      ),
    );
  }

  ///HomePage AppBar
  Widget homeBar() {
    return Padding(
      padding: EdgeInsets.only(right: 15.w),
      //EdgeInsets.only(top: 10.h,right: 18.w),
      child: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        actions: [
          ///Navigation to DetailsPage
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 18.sp,
                foregroundColor: ProjectColors.primaryT,
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: () {
                    ///Navigation to DetailsPage
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DetailsPage()));
                  },
                  icon: ProjectIcons.detailsIcon,
                  iconSize: 20.sp,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  Strings.details,
                  style: TextStyle(
                    fontSize: 8.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          ///Space Between the two Columns
          SizedBox(
            width: 10.w,
          ),

          ///Signing Out From Current Account
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 18.sp,
                foregroundColor: ProjectColors.primaryT,
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  icon: ProjectIcons.logOutIcon,
                  iconSize: 20.sp,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  Strings.logout,
                  style: TextStyle(
                    fontSize: 8.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget homeLogo() {
    return Container(
      height: 180.h,
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
        gradient: gradientLayoutT,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70.h)),
      ),
      child: Stack(
        children: <Widget>[

          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: 18.h),//EdgeInsets.fromLTRB(15.w, 108.h, 13.w, 229.h),
              child: SvgPicture.asset(
                ImageStrings.splashLogo,
                width: 166.w,
                height: 152.h,
                color: Colors.black,
              ),
            ),
          ),

          titleUI(200.w, 90.h, 16.sp, 4.sp, Strings.flower),

          titleUI(160.w, 110.h, 16.sp, 4.sp, Strings.decoration),

        ],
      ),
    );
  }

  Widget services() {
    return Padding(
      padding: EdgeInsets.only(top: 230.h),
      child: GridView.builder(
          itemCount: servicesList.length,
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12.h,
            crossAxisSpacing: 10.w
          ),
          itemBuilder: (context, index) {
            final List<Map<String, dynamic>> imageList =
            occasionSelection(imageData, servicesList[index]['occasion']);
            return Card(
              child: Theme(
                data: ThemeData(
                  fontFamily: 'Ubuntu'
                ),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectionProvider(items: imageList),
                        settings: RouteSettings(
                          arguments: servicesList[index],
                        ),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Container(
                          height: 100.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(servicesList[index]['image']),
                              //fit: BoxFit.fill
                            )
                          ),
                        ),
                      ),
                      
                      Text(servicesList[index]['occasion'])

                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }

  List<Map<String, dynamic>> occasionSelection(
      ImageDataInfo imageData, String occasion) {
    List<Map<String, dynamic>> redirectList = [];

    switch (occasion) {
      case 'Wedding':
        {
          redirectList = imageData.wedding();
        }
        break;

      case 'Religious Occasions':
        {
          redirectList = imageData.religiousOccasion();
        }
        break;

      case 'Home Occasions':
        {
          redirectList = imageData.homeOccasion();
        }
        break;

      case 'Baby Shower':
        {
          redirectList = imageData.babyShower();
        }
        break;

      case 'Cars':
        {
          redirectList = imageData.cars();
        }
        break;

      default:
        {
          redirectList = imageData.others();
        }
    }
    return redirectList;
  }

}
