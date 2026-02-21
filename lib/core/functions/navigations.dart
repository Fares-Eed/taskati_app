import 'package:flutter/material.dart';

void pushReplacment(BuildContext context, Widget newScreen) {
  Navigator.of(
    context,
  ).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => newScreen));
}

void pushTo(BuildContext context, Widget newScreen) {
  Navigator.of(
    context,
  ).push(MaterialPageRoute(builder: (BuildContext context) => newScreen));
}
void pop(BuildContext context, Widget newScreen) {
  Navigator.of(
    context,
  ).pop();
}
