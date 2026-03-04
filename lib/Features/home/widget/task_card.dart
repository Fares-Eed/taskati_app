import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati_app/core/constants/app_assets.dart';
import 'package:taskati_app/core/models/task_model.dart';
import 'package:taskati_app/core/styles/app_colors.dart';
import 'package:taskati_app/core/styles/text_styles.dart';
import 'package:taskati_app/core/widgets/custom_svg_picture.dart';


class TaskCard extends StatelessWidget {
  const TaskCard({super.key,required this.task});


final TaskModel task;
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
           task.title.toString(),
            style: TextStyles.caption1_14.copyWith(fontWeight: FontWeight.w600),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Gap(6),
          Text(
           task.description.toString(),
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
               '${task.startTime.toString()} - ${task.endTime.toString()}',
                style: TextStyles.caption2_12.copyWith(
                  color: AppColors.primary50Color,
                ),
              ),
              Spacer(),
              Text(
                task.isCompleted==true?'done':'In Progress',
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