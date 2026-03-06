import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:taskati_app/core/styles/app_colors.dart';
import 'package:taskati_app/core/styles/text_styles.dart';

class HomeDatePicker extends StatefulWidget {
  const HomeDatePicker({
    super.key,this.onDateChange
  });
  final Function(DateTime)? onDateChange;

  @override
  State<HomeDatePicker> createState() => _HomeDatePickerState();
}

class _HomeDatePickerState extends State<HomeDatePicker> {
   final DatePickerController _controller= DatePickerController();
  @override
  void initState() {
    
    Future.delayed(Duration(seconds: 1),() => _controller.animateToSelection());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DatePicker(
      DateTime.now().subtract(const Duration(days: 30)),
      height: 90,
      width: 64,
      controller: _controller,
      initialSelectedDate: DateTime.now(),
      selectionColor: AppColors.primaryColor,
      selectedTextColor: Colors.white,
      dateTextStyle: TextStyles.title_19.copyWith(fontWeight: FontWeight.w700),
      monthTextStyle: TextStyles.caption2_12,
      dayTextStyle: TextStyles.caption2_12,
      calendarType: CalendarType.gregorianDate,
      onDateChange: widget.onDateChange,
     
    );
  }
}

