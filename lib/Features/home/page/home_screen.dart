import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:intl/intl.dart';
import 'package:taskati_app/Features/add_task/page/add_task.dart';
import 'package:taskati_app/Features/home/widget/custom_tab.dart';
import 'package:taskati_app/Features/home/widget/daily_progress.dart';
import 'package:taskati_app/Features/home/widget/home_date_picker.dart';
import 'package:taskati_app/Features/home/widget/home_header.dart';
import 'package:taskati_app/Features/home/widget/tasks_list_view.dart';
import 'package:taskati_app/core/constants/app_formats.dart';
import 'package:taskati_app/core/functions/navigations.dart';
import 'package:taskati_app/core/models/task_model.dart';
import 'package:taskati_app/core/services/hive_helper.dart';
import 'package:taskati_app/core/styles/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTap = 0;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: DefaultTabController(
          length: 3,
          child: SafeArea(
            child: Column(
              children: [
                Gap(25),
                HomeHeader(),
                Gap(23),
                DailyProgress(),
                Gap(29),
                HomeDatePicker(
                  onDateChange: (newDate) => setState(() {
                    selectedDate = newDate;
                  }),
                ),
                Gap(34),
                _statusTabs(),
                Gap(25),
                _tasksList(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pushTo(context, AddEditTaskScreen());
        },
        shape: const CircleBorder(),
        backgroundColor: AppColors.primaryColor,
        child: Icon(Icons.add, color: AppColors.backgroundColor),
      ),
    );
  }

  TabBar _statusTabs() {
    return TabBar(
      indicatorPadding: const EdgeInsets.all(0),
      indicatorWeight: 0,
      indicator: BoxDecoration(),
      padding: const EdgeInsets.all(0),
      onTap: (int index) {
        setState(() {
          _currentTap = index;
        });
      },
      tabs: [
        CustomTab(isSelected: _currentTap == 0, title: 'All'),
        CustomTab(isSelected: _currentTap == 1, title: 'In Progress'),
        CustomTab(isSelected: _currentTap == 2, title: 'Completed'),
      ],
    );
  }

  /// Builds the main tasks list view with tab filtering.
  ///
  /// This widget creates an expanded container with a [ValueListenableBuilder]
  /// that listens to changes in the Hive tasks box. It filters tasks into three
  /// categories based on the selected tab:
  /// - Daily tasks: Tasks with today's date
  /// - In progress tasks: Tasks that are not completed
  /// - Completed tasks: Tasks that are marked as completed
  ///
  /// The filtered lists are then passed to [TasksListView] widgets within a
  /// [TabBarView] that prevents scrolling and displays the appropriate list
  /// based on the current tab selection.
  ///
  /// Returns an [Expanded] widget containing the filterable task lists.
  Expanded _tasksList() {
    return Expanded(
      child: ValueListenableBuilder<Box<TaskModel>>(
        valueListenable: HiveHelper.tasksBox.listenable(),
        builder: (context, box, _) {
          //is we do not need a variable we can use _
          List<TaskModel> selectedDayTasks = [];
          List<TaskModel> inProgressTasks = [];
          List<TaskModel> completedTasks = [];

          String formedDayDate = DateFormat(
            AppFormats.taskDateFormat,
          ).format(selectedDate);

          /// Filter tasks matching selectedDayTasks
          for (TaskModel task in box.values) {
            if (task.date == formedDayDate) {
              selectedDayTasks.add(task);
            } //we can use .where func insted of for loop
          }

          /// Filter tasks that are not completed
          for (TaskModel task in selectedDayTasks) {
            if (!task.isCompleted) {
              inProgressTasks.add(task);
            }
          }

          /// Filter tasks that are completed
          for (TaskModel task in selectedDayTasks) {
            if (task.isCompleted) {
              completedTasks.add(task);
            }
          }

          return TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              TasksListView(tasks: selectedDayTasks), //daily
              TasksListView(tasks: inProgressTasks), //In Progress
              TasksListView(tasks: completedTasks), //Completed
            ],
          );
        },
      ),
    );
  }
}

// 1) handle themes light and dark in core/styles/themes.dart
// 2) use dark and light inside MaterialApp
// 3) use themeMode to change the theme
// 4) use cached data to get the theme mode
// 5) do button to change the theme
// 6) take round for all screens to handle the theme
