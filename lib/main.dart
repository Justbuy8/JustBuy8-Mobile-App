import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final primaryColor = const Color(0xFFF39A35);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JustBuy8',
      theme: ThemeData(
        primarySwatch: MaterialColor(
          primaryColor.value,
          <int, Color>{
            50: const Color(0xFFFFF3E0),
            100: const Color(0xFFFFE0B2),
            200: const Color(0xFFFFCC80),
            300: const Color(0xFFFFB74D),
            400: const Color(0xFFFFA726),
            500: primaryColor,
            600: const Color(0xFFE65100),
            700: const Color(0xFFD84315),
            800: const Color(0xFFBF360C),
            900: const Color(0xFF3E2723),
          },
        ),
      ),
    );
  }
}
