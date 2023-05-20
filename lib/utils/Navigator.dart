// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class TabNavigator {
  static withoutTabNavigator(
      {required BuildContext context,
      required Widget screen,
      bool? withNavBar}) {
    return PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: screen,
      withNavBar: withNavBar ?? false, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }
}
