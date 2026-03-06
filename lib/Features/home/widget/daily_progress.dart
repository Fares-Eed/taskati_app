import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:intl/intl.dart';
import 'package:taskati_app/core/constants/app_formats.dart';
import 'package:taskati_app/core/models/task_model.dart';
import 'package:taskati_app/core/services/hive_helper.dart';
import 'package:taskati_app/core/styles/app_colors.dart';
import 'package:taskati_app/core/styles/text_styles.dart';

class DailyProgress extends StatelessWidget {
  const DailyProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<TaskModel>>(
      valueListenable: HiveHelper.tasksBox.listenable(),
      builder: (context, box, child) {
        List<TaskModel> todayTasks = [];
        List<TaskModel> completedTasks = [];

        for (var task in box.values) {
          if (task.date ==
              DateFormat(AppFormats.taskDateFormat).format(DateTime.now())) {
            todayTasks.add(task);
            if (task.isCompleted == true) {
              completedTasks.add(task);
            }
          }
        }

        double completedPercentage = todayTasks.isEmpty
            ? 0
            : (completedTasks.length / todayTasks.length) * 100;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          width: double.infinity,
          height: 105,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Expanded(
                //to make a boundries to the column
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Gap(14),
                    Text(
                      DateFormat(
                        AppFormats.taskDateFormat,
                      ).format(DateTime.now()),
                      style: TextStyles.body_16.copyWith(
                        color: AppColors.backgroundColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gap(13),
                    Text(
                      'Your today’s task almost almost ',
                      style: TextStyles.caption1_14.copyWith(
                        color: AppColors.backgroundColor,
                      ),
                    ),
                  ],
                ),
              ),
              Gap(33),
              _circularProgress(completedPercentage),
            ],
          ),
        );
      },
    );
  }

  Stack _circularProgress(double completedPercentage) {
    double progressValue = completedPercentage / 100;

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 76,
          height: 76,
          child: CircularProgressIndicator(
            color: AppColors.backgroundColor,
            value: progressValue.isNaN ? 0 : progressValue,
            backgroundColor: const Color(0XFF8764FF),
            strokeWidth: 8,
            strokeCap: StrokeCap.round,
          ),
        ),
        Text(
          '${completedPercentage.toInt()}%',
          style: TextStyles.caption1_14.copyWith(
            color: AppColors.backgroundColor,
          ),
        ),
      ],
    );
  }
}
