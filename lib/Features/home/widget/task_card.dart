import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati_app/core/constants/app_assets.dart';
import 'package:taskati_app/core/styles/app_colors.dart';
import 'package:taskati_app/core/styles/text_styles.dart';
import 'package:taskati_app/core/widgets/custom_svg_picture.dart';


class TaskCard extends StatelessWidget {
  const TaskCard({super.key,});



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 32,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Market Research',
            style: TextStyles.caption1_14.copyWith(fontWeight: FontWeight.w600),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Gap(6),
          Text(
            'Grocery shopping app design Grocery shopping app design',
            style: TextStyles.caption2_12.copyWith(
              color: AppColors.secondaryColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Gap(12),
          Row(
            children: [
              CustomSvgPicture(path: AppAssets.timeSvg, width: 20),
              Gap(6),
              Text(
                '10:00 AM - 12:00 AM',
                style: TextStyles.caption2_12.copyWith(
                  color: AppColors.primary50Color,
                ),
              ),
              Spacer(),
              Text(
                'Done',
                style: TextStyles.caption2_12.copyWith(
                  color: AppColors.primaryColor
                      
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}