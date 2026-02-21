import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati_app/core/constants/app_assets.dart';
import 'package:taskati_app/core/styles/app_colors.dart';
import 'package:taskati_app/core/styles/text_styles.dart';
import 'package:taskati_app/core/widgets/custom_svg_picture.dart';

class CompleteProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Complete You Profile'))),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          children: [
            Gap(80),
            Row(
              children: [
                Text(
                  'Profile Image',
                  style: TextStyles.caption2_12.copyWith(
                    color: AppColors.secondaryColor,
                  ),
                ),
              ],
            ),
            Gap(21),
            Stack(
              children: [
                CircleAvatar(
                  radius: 82,
                  child: Image.asset(AppAssets.user, width: 165, height: 165),
                ),
                Positioned(
                  right: 7,
                  bottom: 7,
                  child: Container(
                    width: 37,
                    height: 37,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: CustomSvgPicture(path: AppAssets.deleteSvg),
                    ),
                  ),
                ),
              ],
            ),
            Gap(42),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffEDE8FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),

                  child: Text(
                    'From Camera',
                    style: TextStyles.caption1_14.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                Gap(12),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
