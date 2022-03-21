// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_constructors_in_immutables, must_be_immutable

import 'package:flowerdecorations/project_imports.dart';


class SelectionProvider extends StatelessWidget {

  SelectionProvider({required this.items});

  final List<Map<String,dynamic>> items;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => PayLogic(),
      child: SelectionPage(items: items),
    );
  }
}


class SelectionPage extends StatefulWidget {

  SelectionPage({required this.items});

  final List<Map<String,dynamic>> items;

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {

  List<Map<String, dynamic>> selectedItems = [];



  @override
  Widget build(BuildContext context) {

    final selection =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final counter = Provider.of<PayLogic>(context);
    final String occasion = selection['occasion'];
    final String occasionImg = selection['image'];
    List<Map<String, dynamic>> imageList = widget.items;

    //List<Map<String, dynamic>> imageList =
    //     occasionSelection(imageData, occasion);

    // final FirebaseStorage reference = FirebaseStorage.instance;
    //
    // Future<ImageDataInfo> info(String docID){
    //   final CollectionReference<Map<String,dynamic>> imageCollection = FirebaseFirestore.instance.collection(occasion);
    //   final DocumentReference<Map<String, dynamic>> imgDocument = imageCollection.doc(docID);
    //   return imgDocument.get().then((value){
    //     return ImageDataInfo(
    //         description: value.get('description'),
    //         price: value.get('price')
    //     );
    //   });
    // }
    //
    // Future<List<Map<String, dynamic>>> fetchData(String occasion) async {
    //   List<Map<String, dynamic>> files = [];
    //   final ImageDetails imageDetails = ImageDetails(occasion: occasion);
    //   final Future<ListResult> result =  reference.ref().child(occasion).list(); //reference.ref(occasion+'/').list(), reference.ref().child(occasion).list();
    //   result.then((value) async {
    //     final List<Reference> allFiles = value.items;
    //     await Future.forEach<Reference>(allFiles, (file) async {
    //       final String imageUrl = await file.getDownloadURL();
    //       debugPrint(imageUrl);
    //       List<String> urlSplit = imageUrl.split('/');
    //       String docID = urlSplit.join();
    //       debugPrint(docID);
    //       final ImageDataInfo data = await info(docID);
    //       files.add({
    //         'url': imageUrl,
    //         'description': data.description,
    //         'price': data.price
    //       });
    //     });
    //   });
    //   return files;
    // }

    return Scaffold(
      body: Stack(
        children: <Widget>[

          buildDescription(occasion, occasionImg),

          buildAppBar(),

          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 290.h),
            child: ListView.builder(

                scrollDirection: Axis.vertical,
                itemCount: imageList.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedItems.contains(imageList[index]);
                  return SizedBox(
                    height: 420.h,
                    child: Card(
                      child: Theme(
                          data: ThemeData(fontFamily: 'Ubuntu'),
                          child: ListTile(

                            title: Stack(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 10.h),
                                  child: Container(
                                    height: 200.h,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 2.sp),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                imageList[index]['url']),
                                            fit: BoxFit.fitHeight)),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 10.w, top: 220.h),
                                  child: Text(
                                    imageList[index]['title'],
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                            subtitle: Stack(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 10.h, left: 10.w),
                                  child: Text(imageList[index]['description']),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 60.h,left: 180.w),
                                  child: SizedBox(
                                    height: 40.h,
                                    width: 120.w,
                                    child: ElevatedButton.icon(
                                        onPressed: () => onSelected(imageList[index],counter),
                                        icon: isSelected ? ProjectIcons.removeIcon : ProjectIcons.addIcon,
                                        label: isSelected ? Text(Strings.remove) : Text(Strings.add),
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 70.h,left: 10.w),
                                    child: Text(
                                      'Rs.${imageList[index]['price']}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp,
                                        color: ProjectColors.toggleColor,
                                      ),
                                    ),
                                )
                              ],
                            ),
                          )),
                    ),
                  );
                }),
          ),

          Visibility(
              visible: selectedItems.isNotEmpty,
              child: Padding(
                padding: EdgeInsets.only(top: 560.h),
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 60.h,
                    width: 330.w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange.shade300,
                        side: BorderSide(width: 5.sp,color: Colors.pink),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.sp)),
                        ),
                        elevation: 10.sp,
                      ),
                      onPressed: (){
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TransactionPage(),
                            settings: RouteSettings(
                              arguments: SelectedItems(selectedItems: selectedItems, noOfItems: selectedItems.length, total: counter.totalPay, occasion: occasion)
                            )
                          )
                        );
                      },
                      child: Stack(

                        children: <Widget>[

                          titleUI(15.w, 0.h, 14.sp, 3.sp, 'Items Selected: ${selectedItems.length}'),

                          titleUI(15.w, 20.h, 14.sp, 3.sp, 'Rs.${counter.totalPay}'),

                          Padding(
                            padding: EdgeInsets.only(left: 260.w,top: 8.h),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.pink,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              )
          ),

        ],
      ),
    );
  }

  Widget buildDescription(String occasion, String occasionImg) {
    return Container(
      height: 270.h,
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
        gradient: gradientLayoutT,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60.h)),
      ),
      child: Stack(
        children: <Widget>[
          titleUI(35.w, 180.h, 36.sp, 4.sp,
              occasion), //'Wedding','Religious Occasions','Home Occasions','Baby Shower','Cars','Others'

          Padding(
            padding: EdgeInsets.only(top: 30.h, left: 200.w),
            child: Container(
              width: 140.w,
              height: 120.h,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                    occasionImg), //ImageStrings.wedding,ImageStrings.temple,ImageStrings.home,ImageStrings.babyShower,ImageStrings.car,ImageStrings.others
              )),
            ),
          )
        ],
      ),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      elevation: 0.0,
      leading: Padding(
        padding: EdgeInsets.only(left: 10.w),
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: ProjectIcons.popIcon,
          //color: ProjectColors.loginRegisterButton,
          iconSize: 30.sp,
        ),
      ),
    );
  }

  void onSelected(item, PayLogic counter) {
    final isSelected = selectedItems.contains(item);
    setState(() {
      debugPrint(isSelected.toString());
      isSelected
          ? selectedItems.remove(item)
          : selectedItems.add(item);
      debugPrint(selectedItems.toString());
      counter.calculateTotal(selectedItems);
    });
  }


}
