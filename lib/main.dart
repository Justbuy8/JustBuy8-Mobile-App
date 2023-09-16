// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_field
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
// import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/blocs/session_handling/splash_cubit.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/bloc_provider.dart';
import 'package:justbuyeight/firebase_options.dart';
import 'package:justbuyeight/screens/authentication/signin_screen.dart';
import 'package:justbuyeight/screens/maintabs/main_tabs_screen.dart';
import 'package:justbuyeight/screens/onboarding/onboarding_screen.dart';
import 'package:justbuyeight/widgets/components/error/error_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
  String _debugLabelString = "";
  String? _emailAddress;
  String? _smsNumber;
  String? _externalUserId;
  String? _language;
  bool _enableConsentButton = false;
  bool _requireConsent = false;

  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;

    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    OneSignal.Debug.setAlertLevel(OSLogLevel.none);
    OneSignal.consentRequired(_requireConsent);

    OneSignal.initialize("c4e398b2-9dce-4c53-b772-65eb97e8a889");

    OneSignal.Notifications.clearAll();

    OneSignal.User.pushSubscription.addObserver((state) {});

    OneSignal.Notifications.addPermissionObserver((state) {
      print("Has permission " + state.toString());
    });

    OneSignal.Notifications.addClickListener((event) {
      print('NOTIFICATION CLICK LISTENER CALLED WITH EVENT: $event');
      this.setState(() {
        _debugLabelString =
            "Clicked notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      print(
          'NOTIFICATION WILL DISPLAY LISTENER CALLED WITH: ${event.notification.jsonRepresentation()}');

      /// Display Notification, preventDefault to not display
      event.preventDefault();

      /// Do async work

      /// notification.display() to display after preventing default
      event.notification.display();

      this.setState(() {
        _debugLabelString =
            "Notification received in foreground notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    OneSignal.InAppMessages.addClickListener((event) {
      this.setState(() {
        _debugLabelString =
            "In App Message Clicked: \n${event.result.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });
    OneSignal.InAppMessages.addWillDisplayListener((event) {
      print("ON WILL DISPLAY IN APP MESSAGE ${event.message.messageId}");
    });
    OneSignal.InAppMessages.addDidDisplayListener((event) {
      print("ON DID DISPLAY IN APP MESSAGE ${event.message.messageId}");
    });
    OneSignal.InAppMessages.addWillDismissListener((event) {
      print("ON WILL DISMISS IN APP MESSAGE ${event.message.messageId}");
    });
    OneSignal.InAppMessages.addDidDismissListener((event) {
      print("ON DID DISMISS IN APP MESSAGE ${event.message.messageId}");
    });

    this.setState(() {
      _enableConsentButton = _requireConsent;
    });

    OneSignal.InAppMessages.paused(true);
  }

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
