import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:taskati_app/Features/add_task/page/add_task.dart';
import 'package:taskati_app/Features/home/widget/custom_tab.dart';
import 'package:taskati_app/Features/home/widget/daily_progress.dart';
import 'package:taskati_app/Features/home/widget/home_date_picker.dart';
import 'package:taskati_app/Features/home/widget/home_header.dart';
import 'package:taskati_app/Features/home/widget/task_card.dart';
import 'package:taskati_app/Features/home/widget/tasks_list_view.dart';
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
  
  List<TaskModel> tasks=[];
  @override
  void initState() {
    super.initState();
    tasks=HiveHelper.tasksBox.values.toList();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: DefaultTabController(length: 3,
          child: Column(
            children: [
              Gap(25),
              HomeHeader(),
              Gap(23),
              DailyProgress(),
              Gap(29),
              HomeDatePicker(),
              Gap(34),
           _statusTabs(),
              Gap(25),
              _tasksList()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {pushTo(context, AddTask());},
        shape: const CircleBorder(),
        backgroundColor: AppColors.primaryColor,
        child: Icon(Icons.add,color: AppColors.backgroundColor,),
      ),
    );
  }

  Expanded _tasksList() {
    return Expanded(
      child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              TasksListView(tasks: tasks),
              TasksListView(tasks: tasks),
              TasksListView(tasks: tasks),

            ],
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
  
}
