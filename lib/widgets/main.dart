import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

// This widget is the root of your application.
@override
Widget build(BuildContext context) {
  // SystemUiOverlayStyle(statusBarColor: Color.tdBlack); 
return MaterialApp(
  title: 'ToDo App',
  home: Home(),
  debugShowCheckedModeBanner: false,
);
}
}





