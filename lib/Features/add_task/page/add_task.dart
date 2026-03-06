import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskati_app/Features/add_task/Widget/date_time_cart.dart';
import 'package:taskati_app/core/constants/app_assets.dart';
import 'package:taskati_app/core/constants/app_formats.dart';
import 'package:taskati_app/core/functions/navigations.dart';
import 'package:taskati_app/core/models/task_model.dart';
import 'package:taskati_app/core/services/hive_helper.dart';
import 'package:taskati_app/core/styles/app_colors.dart';
import 'package:taskati_app/core/styles/text_styles.dart';
import 'package:taskati_app/core/widgets/custom_svg_picture.dart';
import 'package:taskati_app/core/widgets/custom_text_field.dart';
import 'package:taskati_app/core/widgets/main_button.dart';

class AddEditTaskScreen extends StatefulWidget {
  const AddEditTaskScreen({super.key, this.task});
  final TaskModel? task;

  @override
  State<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String date = DateFormat(AppFormats.taskDateFormat).format(DateTime.now());

  String startTime = DateFormat(
    AppFormats.taskTimeFormat,
  ).format(DateTime.now());

  String endTime = DateFormat(
    AppFormats.taskTimeFormat,
  ).format(DateTime.now().add(Duration(hours: 1)));
  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      titleController.text = widget.task?.title ?? '';
      descriptionController.text = widget.task?.description ?? '';
      date = widget.task?.date ?? '';
      startTime = widget.task?.startTime ?? '';
      endTime = widget.task?.endTime ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: UnconstrainedBox(
          child: CustomSvgPicture(
            path: AppAssets.arrowLeftSvg,
            width: 24,
            height: 24,
            onTap: () => pop(context),
          ),
        ),
        title: Text(widget.task != null ? 'Edit Task' : 'Add Task',style: TextStyles.title_19),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(44),
              Text(
                'Title',
                style: TextStyles.caption2_12.copyWith(
                  color: AppColors.secondaryColor,
                ),
              ),
              Gap(8),
              CustomTextField(controller: titleController),
              Gap(18),
              Text(
                'Description',
                style: TextStyles.caption2_12.copyWith(
                  color: AppColors.secondaryColor,
                ),
              ),
              Gap(14),
              CustomTextField(
                minLines: 4,
                maxLines: 4,
                controller: descriptionController,
              ),
              Gap(41),

              DateTimeCart(
                prefixIcon: AppAssets.calendarSvg,
                title: 'Date',
                subTitle: date,
                onTap: () async {
                  var selectedDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2050),
                    initialDate: DateTime.now(),
                  );

                  if (selectedDate != null) {
                    setState(() {
                      date = DateFormat(
                        AppFormats.taskDateFormat,
                      ).format(selectedDate);
                    });
                  }
                },
              ),
              Gap(24),
              DateTimeCart(
                prefixIcon: AppAssets.timeSvg,
                title: 'Start Time',
                subTitle: startTime,
                onTap: () async {
                  var selectedStartTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (selectedStartTime != null) {
                    setState(() {
                      startTime = selectedStartTime.format(context);
                    });
                  }
                },
              ),
              Gap(24),
              DateTimeCart(
                prefixIcon: AppAssets.timeSvg,
                title: 'End Time',
                subTitle: endTime,
                onTap: () async {
                  var selectedEndTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (selectedEndTime != null) {
                    setState(() {
                      endTime = selectedEndTime.format(context);
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 22, right: 22, bottom: 32),
        child: MainButton(
          text: widget.task != null ? 'Save' : 'Add Task',
          onPressed: () {
              if (widget.task != null) {
              // update task
              HiveHelper.cacheTask(
                widget.task?.id ?? '',
                widget.task!.copyWith(
                  title: titleController.text,
                  description: descriptionController.text,
                  date: date,
                  startTime: startTime,
                  endTime: endTime,
                  isCompleted: false,
                ),
              );
            } else {
              // add task
              String key = DateTime.now().millisecondsSinceEpoch.toString();
              HiveHelper.cacheTask(
                key,
                TaskModel(
                  id: key,
                  title: titleController.text,
                  description: descriptionController.text,
                  date: date,
                  startTime: startTime,
                  endTime: endTime,
                  isCompleted: false,
                  createdAt: DateTime.now().toIso8601String(),
                ),
              );
            }
            pop(context);
          },
        ),
      ),
    );
  }
}
