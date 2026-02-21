import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati_app/Features/complete_profile/page/complete_profile_screen.dart';
import 'package:taskati_app/core/constants/app_assets.dart';
import 'package:taskati_app/core/functions/navigations.dart';
import 'package:taskati_app/core/styles/app_colors.dart';
import 'package:taskati_app/core/styles/text_styles.dart';

class SplashScreen extends StatefulWidget{
  
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
Future.delayed(const Duration(seconds: 3), () {
      pushReplacment(context,  CompleteProfileScreen());
    });  }
@override
  Widget build(BuildContext context) {
    
    return Scaffold( 
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(AppAssets.logo,),
            Text(
              'Taskati',
              style: TextStyles.headline_24.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
            Gap(18),
            Text(
              'It’s time to get organized',
              style: TextStyles.caption1_14.copyWith(
                color: AppColors.secondaryColor,
              ),
            ),
          ],
      ),)
    );
  }
}