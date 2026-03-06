import 'package:flutter/material.dart';
import 'package:taskati_app/core/services/hive_helper.dart';

extension ThemeExtension on BuildContext {
  bool get isDark => HiveHelper.getCachedThemeMode();
  ThemeData get theme => Theme.of(this);
  Color get cardColor => theme.cardColor;
  Color? get iconColor => theme.iconTheme.color;
}


// The Different between the function and the extention
// pushTO(context, newScreen)  ==> Function
// context.pushTo(newScreen)  ==> Extension
// verticalSpace(10) ==> Function
// 10.h ==> extension