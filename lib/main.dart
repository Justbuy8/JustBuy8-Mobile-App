// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
// import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/blocs/session_handling/splash_cubit.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/bloc_provider.dart';
import 'package:justbuyeight/screens/authentication/signin_screen.dart';
import 'package:justbuyeight/screens/maintabs/main_tabs_screen.dart';
import 'package:justbuyeight/screens/onboarding/onboarding_screen.dart';
import 'package:justbuyeight/widgets/components/error/error_screen.dart';
import 'package:nb_utils/nb_utils.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Phoenix(child: MyApp()),
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
          return MultiBlocProvider(
            providers: BlocProviders.providers,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'JustBuy8',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSwatch().copyWith(
                  secondary: AppColors.secondaryColor,
                  primary: AppColors.primaryColor,
                ),
                appBarTheme: AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle.light,
                ),
              ),
              home: BlocBuilder<SessionHandlingCubit, SessionHandlingState>(
                builder: (context, state) {
                  if (state is SessionHandlingHomeScreen) {
                    return MainTabsScreen();
                  } else if (state is SessionHandlingLoginScreen) {
                    return SignInScreen();
                  } else if (state is SessionHandlingOnBoarding) {
                    return OnboardingScreen();
                  } else if (state is SessionHandlingFailed) {
                    return ErrorScreen();
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),
          );
        });
  }
}
