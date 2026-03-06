import 'package:flutter/material.dart';

void pushReplacment(BuildContext context, Widget newScreen) {
  Navigator.of(
    context,
  ).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => newScreen));
}

Future pushTo(BuildContext context, Widget screen) {
  return Navigator.push(//I maked it future to be able to use .then with it 
    context,
    MaterialPageRoute(builder: (context) => screen),
  );
}
void pop(BuildContext context) {
  Navigator.of(
    context,
  ).pop();
}
