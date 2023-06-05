// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/myaccount/myaccount_cubit.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/screens/maintabs/home/home_screen.dart';
import 'package:justbuyeight/screens/maintabs/widgets/FadeIndexedStack.dart';
import 'package:justbuyeight/screens/maintabs/widgets/HomeBottomNavBar.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import 'my_account/my_account_screen.dart';

class MainTabsScreen extends StatefulWidget {
  const MainTabsScreen({Key? key}) : super(key: key);

  @override
  _MainTabsScreenState createState() => _MainTabsScreenState();
}

class _MainTabsScreenState extends State<MainTabsScreen> {
  late PersistentTabController tabsController;

  int tabindex = 0;
  static List<Widget> homepageTabs = <Widget>[
    HomeScreen(),
    Container(
      color: Colors.green,
    ),
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.yellow,
    ),
    MyAccountScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedSwitcher(
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            duration: const Duration(milliseconds: 500),
            child: FadeIndexedStack(
              index: tabindex,
              children: homepageTabs,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              alignment: Alignment.center,
              height: Platform.isAndroid ? 55 : 60,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: HomeBottomNavBar(context, onTabChange: (index) {
                if (tabindex != index) {
                  setState(() {
                    tabindex = index;
                  });

                  //Home Page
                  if (tabindex == 0) {}

                  //Search Page
                  if (tabindex == 1) {}

                  //Cart Page
                  if (tabindex == 2) {}

                  //WishList Page
                  if (tabindex == 3) {}

                  //Account Page
                  if (index == 4) {
                    context.read<MyaccountCubit>().myAccount();
                  }
                }
              }),
            ),
          )
        ],
      ),
    );
  }
}
