// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class TabNavigator {
  static withoutTabNavigator(
      {required BuildContext context,
      required Widget screen,
      bool? withNavBar}) {
    return pushNewScreen(
      context,
      screen: screen,
      withNavBar: withNavBar ?? false, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }
}
