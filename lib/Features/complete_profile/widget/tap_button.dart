import 'package:flutter/material.dart';
import 'package:taskati_app/core/styles/app_colors.dart';
import 'package:taskati_app/core/styles/text_styles.dart';

class TapButton extends StatelessWidget {
  const TapButton({
    super.key,required this.text, required this.onTap
  });
  final String text ;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xffEDE8FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
        ),
      ),
    
      child: Text(
       text,
        style: TextStyles.caption1_14.copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
