// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/main_tabs_screen.dart';
import 'package:justbuyeight/screens/authentication/account_created_screen.dart';
import 'package:justbuyeight/screens/authentication/otp_verification_screen.dart';
import 'package:justbuyeight/screens/home.dart';
import 'package:justbuyeight/screens/onboarding/onboarding_screen.dart';
import 'package:nb_utils/nb_utils.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(context.width(), context.height()),
      builder: (context, child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'JustBuy8',
          home: Home(),
        );
      },
    );
  }
}
