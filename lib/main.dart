import 'dart:io';


import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:taskati_app/Features/splash/splash_screen.dart';
import 'package:taskati_app/core/constants/app_assets.dart';
import 'package:taskati_app/core/services/hive_helper.dart';
import 'package:taskati_app/core/services/shared_pref.dart';
import 'package:taskati_app/core/styles/app_colors.dart';
import 'package:taskati_app/core/styles/themes.dart';
import 'package:taskati_app/hive/hive_adapters.dart';
import 'package:taskati_app/hive/hive_registrar.g.dart';

//to setup the hive 
// initialize hive
// open boxes
// if you need to cache Object, create a custom adapter for that object
// create model class
// add file for hive adapters
// register adapters

 Future<void> main()async {
    WidgetsFlutterBinding.ensureInitialized();//to do a service befor the run app

  // await SharedPref.init();
  await Hive.initFlutter();
  Hive.registerAdapters();
  await HiveHelper.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      builder: (context, child) {
        return SafeArea(
          top: false,
          bottom: Platform.isAndroid,
          child: Scaffold(
            body: Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: AppColors.backgroundColor,
                ),
                Image.asset(
                  AppAssets.bg,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                child!,
              ],
            ),
          ),
        );
      },
    );
  }
}

