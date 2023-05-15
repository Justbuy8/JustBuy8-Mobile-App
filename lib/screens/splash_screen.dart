<<<<<<< Updated upstream
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/constants/app_images.dart';
import 'package:justbuyeight/constants/secure_storage.dart';
import 'package:justbuyeight/screens/authentication/signin_screen.dart';
import 'package:justbuyeight/screens/maintabs/main_tabs_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  initliazeRoute() async {
    try {
      var userToken = await UserSecureStorage.fetchToken();
      var userId = await UserSecureStorage.fetchUserId();

      if (userToken != null && userId != null) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (builder) => MainTabsScreen()));
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (builder) => SignInScreen()));
      }
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      initliazeRoute();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              ImageAssets.appLogo,
              height: 100.h,
              width: 200.w,
            ),
          ),
        ],
      ),
    );
  }
}
=======
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
>>>>>>> Stashed changes
