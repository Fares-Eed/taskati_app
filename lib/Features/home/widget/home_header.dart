import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati_app/Features/edit_profile/page/edit_profile.dart';
import 'package:taskati_app/core/constants/app_assets.dart';
import 'package:taskati_app/core/functions/extensions.dart';
import 'package:taskati_app/core/functions/navigations.dart';
import 'package:taskati_app/core/services/hive_helper.dart';
import 'package:taskati_app/core/styles/text_styles.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  String name = '';
  String image = '';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    name = HiveHelper.getCachedData(HiveHelper.nameKey);
    image = HiveHelper.getCachedData(HiveHelper.imageKey);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              pushTo(context, EditProfileScreen()).then((value) {
                setState(() {
                  image = HiveHelper.getCachedData(HiveHelper.imageKey) ?? '';
                   name = HiveHelper.getCachedData(HiveHelper.nameKey) ?? '';
                });
              });
            },
            child: ClipOval(
              child: image.isEmpty
                  ? Image.asset(AppAssets.user, width: 50, height: 50)
                  : Image.file(
                      File(image),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      // errorBuilder handles cases where the image file fails to load
                      // (file not found, corrupted, etc.) by displaying a default user icon
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          AppAssets.user,
                          width: 50,
                          height: 50,
                        );
                      },
                    ),
            ),
          ),
          Gap(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello!', style: TextStyles.caption1_14),

              Text(name.isEmpty ? 'User' : name, style: TextStyles.title_19),
            ],
          ),
          Spacer(),
          IconButton(
            onPressed: () {
              bool isDark = HiveHelper.getCachedThemeMode();
              HiveHelper.cacheThemeMode(!isDark);
              setState(() {});
            },
            icon: Icon(context.isDark ? Icons.light_mode : Icons.dark_mode),
          ),
        ],
      ),
    );
  }
}
