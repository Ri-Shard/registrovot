import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:registrovot/controller/mainController.dart';
import 'package:registrovot/ui/screens/splash_screen.dart';

void main() async {
  initializeDateFormatting('es');

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        storageBucket: "vota-734bf.appspot.com",
        measurementId: "G-5SJMR18MR6",
        authDomain: "vota-734bf.firebaseapp.com",
        databaseURL: "https://drinki-f70e7-default-rtdb.firebaseio.com",
        apiKey: 'AIzaSyDqdhnZZ-pn1wEsiyi1icGKWCnFOFuB9gE',
        appId: "1:599170961042:web:30a34a9157b0c79e69e04b",
        messagingSenderId: "599170961042",
        projectId: "vota-734bf"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    return GetMaterialApp(
      locale: const Locale('es'),
      debugShowCheckedModeBanner: false,
      title: 'VCO',
      theme: ThemeData(
        fontFamily: 'AvantGardeStd',
        primarySwatch: Colors.pink,
      ),
      home: const SplashScreen(),
    );
  }

  Widget _showloading() {
    return AlertDialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: LoadingAnimationWidget.newtonCradle(
            color: Colors.green, size: 100));
  }

  void _stoploading(BuildContext context) {
    Navigator.pop(context);
  }
}
