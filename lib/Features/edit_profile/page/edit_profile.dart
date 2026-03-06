import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati_app/Features/complete_profile/widget/tap_button.dart';
import 'package:taskati_app/Features/home/page/home_screen.dart';
import 'package:taskati_app/core/constants/app_assets.dart';
import 'package:taskati_app/core/functions/dialogs.dart';
import 'package:taskati_app/core/functions/navigations.dart';
import 'package:taskati_app/core/services/hive_helper.dart';
import 'package:taskati_app/core/styles/app_colors.dart';
import 'package:taskati_app/core/styles/text_styles.dart';
import 'package:taskati_app/core/widgets/custom_svg_picture.dart';
import 'package:taskati_app/core/widgets/custom_text_field.dart';
import 'package:taskati_app/core/widgets/main_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? path;
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    nameController.text = HiveHelper.getCachedData(HiveHelper.nameKey) ?? '';
    path = HiveHelper.getCachedData(HiveHelper.imageKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Profile'))), 
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(80),
              Row(
                children: [
                  Text(
                    'Profile Image',
                    style: TextStyles.caption2_12.copyWith(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ],
              ),
              Gap(21),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 82,
                    backgroundColor: AppColors.backgroundColor,
                    backgroundImage: path != null
                        ? FileImage(File(path!))
                        : AssetImage(AppAssets.user) as ImageProvider,
                  ),
                  if (path != null)
                    Positioned(
                      right: 7,
                      bottom: 7,
                      child: GestureDetector(
                        onTap: () => setState(() {
                          path = null;
                        }),
                        child: Container(
                          width: 37,
                          height: 37,
                          decoration: BoxDecoration(
                            color: AppColors.backgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: CustomSvgPicture(path: AppAssets.deleteSvg),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Gap(42),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TapButton(
                    text: 'From Camera',
                    onTap: () async {
                      var image = await ImagePicker().pickImage(
                        source: ImageSource.camera,
                      );
                      if (image != null) {
                        setState(() {
                          path = image.path;
                        });
                      }
                    },
                  ),
                  Gap(12),
                  TapButton(
                    text: 'From Gallery',
                    onTap: () {
                      ImagePicker().pickImage(source: ImageSource.gallery).then(
                        (image) {
                          setState(() {
                            if (image != null) {
                              path = image.path;
                            }
                          });
                        },
                      );
                    },
                  ),
                ],
              ),
              Gap(54),
              Row(
                children: [
                  Text(
                    'Your Name',
                    style: TextStyles.caption2_12.copyWith(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ],
              ),
              Gap(8),
              CustomTextField(
                hint: 'Enter your name',
                controller: nameController,
              ),
              Gap(165),
              MainButton(
                text: 'Save',
                onPressed: () async {
                  if (path != null && nameController.text.trim().isNotEmpty) {
                
                    await HiveHelper.setUserInfo(
                      nameController.text.trim(),
                      path!,
                    );

                    if (!context.mounted) return;
                    pop(context);
                  } else if (nameController.text.trim().isEmpty) {
                    showErrorDialog(context, 'Please enter your name');
                  } else if (path == null) {
                    showErrorDialog(context, 'Please upload a profile image');
                  }
                },
              ),
              Gap(30),
            ],
          ),
        ),
      ),
    );
  }
}
