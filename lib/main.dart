// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flowerdecorations/project_imports.dart';

Future<void> main() async {
  ///This will help to bind all the widgets used in the project
  WidgetsFlutterBinding.ensureInitialized();

  ///Functions related to Firebase will get initialize in the app
  await Firebase.initializeApp();

  ///Root of the Project
  runApp(MyApp());
}

///This class will be the root of the project and also has a MultiProvider widget for StreamProvider
///and ChangeNotifierProvider.StreamProvider will basically provide a stream of changes for the user
///like Signing In or Signing Out and will rebuild the whole app.
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => StreamProvider<UserUID?>(
          create: (_) => AuthService().user,
          initialData: UserUID(uid: 'No User Found'),
          builder: (context, snapshot) {
            return MaterialApp(
              title: 'Flower Decorations',
              theme: ThemeData(fontFamily: 'Ubuntu'),
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
            );
          }),
      designSize: const Size(360, 640),
    );
  }
}
