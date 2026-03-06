import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati_app/Features/add_task/page/add_task.dart';
import 'package:taskati_app/Features/home/widget/task_card.dart';
import 'package:taskati_app/core/constants/app_assets.dart';
import 'package:taskati_app/core/functions/navigations.dart';
import 'package:taskati_app/core/models/task_model.dart';
import 'package:taskati_app/core/services/hive_helper.dart';
import 'package:taskati_app/core/styles/app_colors.dart';

class TasksListView extends StatelessWidget {
  const TasksListView({super.key, required this.tasks});

  final List<TaskModel> tasks;

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return LottieBuilder.asset(AppAssets.emptyState,repeat: false,);
    }
    return ListView.separated(
      itemCount: tasks.length,
      separatorBuilder: (BuildContext context, int index) {
        return Gap(12);
      },
      itemBuilder: (BuildContext context, int index) {
        TaskModel task = tasks[index];

        return Slidable(
          key: UniqueKey(),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(
              onDismissed: () {
                HiveHelper.deleteTask(task.id ?? '');
              },
            ),
            children: [
              SlidableAction(
                onPressed: (context) {
                  HiveHelper.deleteTask(task.id ?? '');
                },
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  HiveHelper.cacheTask(
                    task.id ?? '',
                    task.copyWith(isCompleted: true),
                  );
                },
                backgroundColor: Color(0xFF7BC043),
                foregroundColor: Colors.white,
                icon: Icons.check,
                label: 'Complete',
              ),
              SlidableAction(
                onPressed: (context) {
                  pushTo(context, AddEditTaskScreen(task: task));
                },
                backgroundColor: AppColors.primary50Color,
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Edit',
              ),
            ],
          ),
          child: TaskCard(task: task),
        );
      },
    );
  }
}
