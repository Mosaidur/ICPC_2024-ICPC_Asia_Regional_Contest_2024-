import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'Hompage/homepage.dart';
import 'SplashScreen/splashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // WebView.platform = SurfaceAndroidWebView();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

      ),
      home: SplashScreen(),
      // home: HomePage(),
    );
  }
}

