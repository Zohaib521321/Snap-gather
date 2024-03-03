import 'package:event_management/view/Auth/signup.dart';
import 'package:event_management/view/BottomNav/all_binding.dart';
import 'package:event_management/view/BottomNav/nav_main.dart';
import 'package:event_management/view/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Stripe.publishableKey = "Your publish key";
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AllBindingController(),
      smartManagement: SmartManagement.full,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(useMaterial3: true, primaryColor: Colors.blue),
      home: SplashScreen(),
    );
  }
}
