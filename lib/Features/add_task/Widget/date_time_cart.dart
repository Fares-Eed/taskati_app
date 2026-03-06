import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati_app/core/constants/app_assets.dart';
import 'package:taskati_app/core/functions/extensions.dart';
import 'package:taskati_app/core/styles/app_colors.dart';
import 'package:taskati_app/core/styles/text_styles.dart';
import 'package:taskati_app/core/widgets/custom_svg_picture.dart';

class DateTimeCart extends StatelessWidget {
  
  const DateTimeCart({
    super.key,required this.prefixIcon,required this.title,required this.subTitle,this.onTap
  });
  final String title ; 
  final String subTitle ; 
  final String prefixIcon ;
  final  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap:  onTap,
      child: Container(
       width: double.infinity,height: 63,
       decoration: BoxDecoration(
         color: context.cardColor,
         borderRadius: BorderRadius.circular(15),
         boxShadow: [BoxShadow(
           offset: Offset(0, 4),
           blurRadius: 16,
           color: Color(0x0A000000)
         )]
       ),
       child:  Row(children: [
         Gap(16),
       CustomSvgPicture(path: prefixIcon,width: 24,height: 24,),
       
       Gap(12),
       Column(mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.start,
         children: [
         Text(title,style: TextStyles.caption3_9.copyWith(color: AppColors.secondaryColor),),
         Text(subTitle,style: TextStyles.caption1_14.copyWith(color: AppColors.secondaryColor),),
         
       ],),
       Spacer(),
       CustomSvgPicture(path: AppAssets.arrowDownSvg ,width: 24,height: 24,),
       Gap(16)
      ],),
      ),
    );
  }
}