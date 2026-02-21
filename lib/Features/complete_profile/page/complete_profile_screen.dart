import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati_app/Features/complete_profile/widget/tap_button.dart';
import 'package:taskati_app/core/constants/app_assets.dart';
import 'package:taskati_app/core/functions/dialogs.dart';
import 'package:taskati_app/core/styles/app_colors.dart';
import 'package:taskati_app/core/styles/text_styles.dart';
import 'package:taskati_app/core/widgets/custom_svg_picture.dart';
import 'package:taskati_app/core/widgets/custom_text_field.dart';
import 'package:taskati_app/core/widgets/main_button.dart';
//to pick an Image from gallery or camera 
// 1) use ImagePicker to pick image from camera or gallery
// 2) extract path from XFile that is returned
// 3) use path to display image using FileImage(File(path))

// XFile(path) ==> ImagePicker
// File(path) ==> dart:io

class CompleteProfileScreen extends StatefulWidget {
  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  String? path;
final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Complete You Profile'))),
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
                    
                    
                    backgroundImage:  path!=null?FileImage(File(path!))
                    : AssetImage(
                     
                      AppAssets.user,
                     
                    ), 
                  ),
                  if(path!=null)
                  Positioned(
                    right: 7,
                    bottom: 7,
                    child: GestureDetector(onTap: () => setState(() {
                      path=null;
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
                      //bec it is a Future func
                      var image = await ImagePicker().pickImage(
                        source: ImageSource.camera,
                      );
                      if(image!=null){
                        setState(() {
                          path=image.path;
                        });
                      }
                    },
                  ),
                  Gap(12),
                  TapButton(
                    text: 'From Gallery',
                    onTap: () {
                      ImagePicker()
                          .pickImage(source: ImageSource.gallery)
                          .then((image) {
                            setState(() {
                              if(image!=null)
                              {path=image.path;}
                            });
                          });
                    },
                  ), //another way (.then)
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
              CustomTextField(hint: 'Fares Eed',controller: nameController,),
              Gap(165),
              MainButton(text: 'Let`s Start !', onPressed: () {
                 if (path != null && nameController.text.isNotEmpty) {
              // navigate to home screen
            } else if (path != null && nameController.text.isEmpty) {
              showErrorDialog(context, 'Please enter your name');
            } else if (path == null && nameController.text.isNotEmpty) {
              showErrorDialog(context, 'Please upload your image');
            } else {
              showErrorDialog(
                context,
                'Please upload your image and name',
              );
            }
              }),
              Gap(30),
            ],
          ),
        ),
      ),
    );
  }
}
