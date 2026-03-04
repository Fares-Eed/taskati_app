import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati_app/Features/home/widget/task_card.dart';
import 'package:taskati_app/core/models/task_model.dart';
import 'package:taskati_app/core/services/hive_helper.dart';

class TasksListView extends StatelessWidget {
  const TasksListView({super.key, required this.tasks});

  final List<TaskModel> tasks;

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return Center(child: Text('No tasks found'));
    }
    return ListView.separated(
      itemCount: tasks.length,
      separatorBuilder: (BuildContext context, int index) {
        return Gap(12);
      },
      itemBuilder: (BuildContext context, int index) {
        TaskModel task = tasks[index];
        return TaskCard(task: task);
        
      },
    );
  }
}