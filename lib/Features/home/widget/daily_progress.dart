import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskati_app/core/styles/app_colors.dart';
import 'package:taskati_app/core/styles/text_styles.dart';

class DailyProgress extends StatelessWidget {
  const DailyProgress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(padding:EdgeInsets.symmetric(horizontal: 25) ,
      width: double.infinity,height: 105,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(//to make a boundries to the column 
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                
              children: [
                Gap(14),
              Text(DateFormat('EEEE, dd MMM').format(DateTime.now()),style: TextStyles.body_16.copyWith(color: AppColors.backgroundColor,fontWeight: FontWeight.w600),)
              ,Gap(13),
              Text('Your today’s task almost almost ',style: TextStyles.caption1_14.copyWith(color: AppColors.backgroundColor),)
            ],),
          ),
          Gap(33),
    
          _circularProgress()
        ],
      ),
    );
  }

  Stack _circularProgress() {
    return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(width: 76,height: 76,
              child: CircularProgressIndicator(
                color:AppColors.backgroundColor ,
                value: 0.85,
                backgroundColor: Color(0XFF8764FF),
                strokeWidth: 8, 
                strokeCap: StrokeCap.round,
              
              )
              
              ),
              Text('85%',style: TextStyles.caption1_14.copyWith(color: AppColors.backgroundColor),)
          ],
        );
  }
}
