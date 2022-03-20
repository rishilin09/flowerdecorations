// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flowerdecorations/project_imports.dart';

Future<void> main() async {

  ///This will help to bind all the widgets used in the project
  WidgetsFlutterBinding.ensureInitialized();

  ///Functions related to Firebase will get initialize in the app
  await Firebase.initializeApp();

  runApp(MyApp());
}

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
              home: SplashScreen(),  //SelectionPage(),
            );
          }
        ),
      designSize: const Size(360, 640),
    );
  }
}
