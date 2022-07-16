import 'package:authen_app/src/resources/login.dart';
import 'package:flutter/material.dart';
// import 'package:authen_app/src/resources/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Login(),
    );
  }
}