import 'package:final_app/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

changeScreen(){
  Future.delayed(const Duration(seconds:3 ),(){
    Get.to(()=>const AuthPage());
  });
}

@override
  void initState() {
    changeScreen();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(
                height: 210,
                ),
              Image(image: AssetImage('assets/images/app_logo.png'),
              width: 200,
              
              ),
              SizedBox(
                height: 50,
                ),
                SpinKitFadingCircle(
                  color: Colors.black,
                  size: 50,
                )
            ],
          ),
        ),
      ),
        
    );
  }
}