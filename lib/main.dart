// import 'package:final_app/consts/theme_data.dart';
import 'package:final_app/components/splash_screen.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:final_app/firebase_options.dart';
// import 'package:final_app/pages/auth_page.dart';
// import 'package:final_app/pages/btm_bar.dart';
// import 'package:final_app/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

// import 'consts/theme_data.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  initStripe();
  
  
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions().currentPlatform,
  );
  runApp(const MyApp());
}
void initStripe() {
  Stripe.publishableKey = 'your_publishable_key_here';
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // bool _isDark = true;
    return const   GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: Styles.themeData(true, context),
      home:  SplashScreen(),
    );
  }
}

 