// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppNavigator {
  static goToPage({required BuildContext context, required Widget screen}) {
    return Navigator.push(
        context,
        PageTransition(
            duration: const Duration(milliseconds: 400),
            type: PageTransitionType.rightToLeft,
            child: screen));
  }
}
