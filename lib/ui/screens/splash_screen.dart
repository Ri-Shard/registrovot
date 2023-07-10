import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:registrovot/controller/mainController.dart';
import 'package:registrovot/ui/common/layouts/logindesktop_screen.dart';
import 'package:registrovot/ui/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    MainController mainController = Get.find();
    mainController.getFirebaseUser().then((response) {
      if (response != null) {
        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_) {
          return HomeScreen();
        }));
      } else {
        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_) {
          return const LoginScreen();
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingAnimationWidget.newtonCradle(
            color: const Color(0xffff004e), size: 100));
  }
}
