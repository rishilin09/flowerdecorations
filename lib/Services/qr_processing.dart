
import 'dart:ui' as ui;
import 'package:flowerdecorations/project_imports.dart';

///This class will help to upload QRCode of current user to FireBaseStorage
class QrProcessing {
  ///This variable will provide instance for FirebaseStorage to access
  ///different functions of FirebaseStorage
  final FirebaseStorage reference = FirebaseStorage.instance;

  ///This function will upload QRCode Image to FirebaseStorage with $username-qr.png as filename
  Future<void> uploadImage(String path, key) async {
    final _key = key;
    final RenderRepaintBoundary boundary =
    _key?.currentContext?.findRenderObject() as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();

    try {
      await reference
          .ref(
          'userQRCodes/$path-qr.png') //eg :- userQRCodes/Rishikesh Lingayat-qr.png
          .putData(pngBytes!);
    } on FirebaseException {
      // e.g, e.code == 'canceled'
     return;
    }
  }

  Future<String> qrURL(String path) async {
    try {
      String downloadURL =
      await reference.ref('userQRCodes/$path-qr.png').getDownloadURL();
      return downloadURL;
    } on FirebaseException {
      return 'No QR Image found';
    }
  }
}
