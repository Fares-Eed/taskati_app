import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati_app/Features/home/widget/custom_tab.dart';
import 'package:taskati_app/Features/home/widget/daily_progress.dart';
import 'package:taskati_app/Features/home/widget/home_date_picker.dart';
import 'package:taskati_app/Features/home/widget/home_header.dart';
import 'package:taskati_app/Features/home/widget/task_card.dart';
import 'package:taskati_app/core/styles/app_colors.dart';
import 'package:taskati_app/core/styles/text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTap = 0;
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
              Gap(31),
              _tasksList()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
              ListView(children: [TaskCard(),TaskCard(),TaskCard(),TaskCard(),],),
              ListView(children: [TaskCard(),TaskCard(),TaskCard(),TaskCard(),],),
              ListView(children: [TaskCard(),TaskCard(),TaskCard(),TaskCard(),],),
            
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
