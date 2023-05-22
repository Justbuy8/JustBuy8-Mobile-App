// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/constants/app_textstyle.dart';
import 'package:justbuyeight/constants/bloc_provider.dart';
import 'package:justbuyeight/screens/maintabs/home/home_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'my_account/my_account_screen.dart';

class MainTabsScreen extends StatefulWidget {
  const MainTabsScreen({Key? key}) : super(key: key);

  @override
  _MainTabsScreenState createState() => _MainTabsScreenState();
}

class _MainTabsScreenState extends State<MainTabsScreen> {
  late PersistentTabController tabsController;

  @override
  void initState() {
    super.initState();

    tabsController = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: tabsController,
      screens: [
        MultiBlocProvider(
          providers: BlocProviders.providers,
          child: HomeScreen(),
        ),
        Container(
          color: Colors.green,
        ),
        Container(
          color: Colors.blue,
        ),
        Container(
          color: Colors.yellow,
        ),
        MultiBlocProvider(
          providers: BlocProviders.providers,
          child: MyAccountScreen(),
        ),
      ],
      items: [
        PersistentBottomNavBarItem(
          icon: const Icon(Ionicons.home_outline),
          title: (AppText.homeText),
          textStyle: AppTextStyle.tabsTextStyle,
          iconSize: 20,
          activeColorPrimary: AppColors.appWhiteColor,
          activeColorSecondary: AppColors.primaryColor,
          inactiveColorPrimary: AppColors.appWhiteColor,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Ionicons.search_outline),
          title: (AppText.searchText),
          textStyle: AppTextStyle.tabsTextStyle,
          iconSize: 20,
          activeColorPrimary: AppColors.appWhiteColor,
          activeColorSecondary: AppColors.primaryColor,
          inactiveColorPrimary: AppColors.appWhiteColor,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Ionicons.cart_outline),
          title: (AppText.cartText),
          textStyle: AppTextStyle.tabsTextStyle,
          iconSize: 20,
          activeColorPrimary: AppColors.appWhiteColor,
          activeColorSecondary: AppColors.primaryColor,
          inactiveColorPrimary: AppColors.appWhiteColor,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Ionicons.heart_outline),
          title: (AppText.wishlistText),
          textStyle: AppTextStyle.tabsTextStyle,
          iconSize: 20,
          activeColorPrimary: AppColors.appWhiteColor,
          activeColorSecondary: AppColors.primaryColor,
          inactiveColorPrimary: AppColors.appWhiteColor,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Ionicons.person_outline),
          title: (AppText.accountText),
          textStyle: AppTextStyle.tabsTextStyle,
          iconSize: 20,
          activeColorPrimary: AppColors.appWhiteColor,
          activeColorSecondary: AppColors.primaryColor,
          inactiveColorPrimary: AppColors.appWhiteColor,
        ),
      ],
      confineInSafeArea: true,
      backgroundColor: AppColors.primaryColor,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      padding: const NavBarPadding.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.only(
        bottom: 20.0,
        left: 15,
        right: 15,
      ),
      bottomScreenMargin: 0,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(30.0),
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInCirc,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.easeIn,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style7,
    );
  }
}
