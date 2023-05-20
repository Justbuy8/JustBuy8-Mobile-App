import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/authentication/login/login_cubit.dart';
import 'package:justbuyeight/blocs/authentication/registration/registration_cubit.dart';
import 'package:justbuyeight/blocs/authentication/reset_password_cubit/reset_password_cubit.dart';
import 'package:justbuyeight/blocs/authentication/send_otp/send_otp_cubit.dart';
import 'package:justbuyeight/blocs/authentication/timer_cubit/timer_cubit.dart';
import 'package:justbuyeight/blocs/authentication/validate_email/validate_email_cubit.dart';
import 'package:justbuyeight/blocs/authentication/verify_email_cubit/verify_email_cubit.dart';
import 'package:justbuyeight/blocs/brands/brands_bloc.dart';
import 'package:justbuyeight/blocs/brands/brands_events_and_states.dart';
import 'package:justbuyeight/blocs/products/arrivals/new_arrival_bloc.dart';
import 'package:justbuyeight/blocs/products/arrivals/new_arrival_state_and_events.dart';
import 'package:justbuyeight/blocs/session_handling/splash_cubit.dart';

class BlocProviders {
  static final List<BlocProvider> providers = [
    BlocProvider<ValidateEmailCubit>(create: (context) => ValidateEmailCubit()),
    BlocProvider<SendOtpCubit>(create: (context) => SendOtpCubit()),
    BlocProvider<OtpTimerCubit>(create: (context) => OtpTimerCubit()),
    BlocProvider<RegistrationCubit>(create: (context) => RegistrationCubit()),
    BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
    BlocProvider<VerifyEmailCubit>(create: (context) => VerifyEmailCubit()),
    BlocProvider<ResetPasswordCubit>(create: (context) => ResetPasswordCubit()),
    BlocProvider<SessionHandlingCubit>(
        create: (context) => SessionHandlingCubit()..initliazeRoute()),
    BlocProvider<NewArrivalBloc>(
      create: (context) => NewArrivalBloc()
        ..add(
          NewArrivalGetAllEvent("1", "10", "all"),
        ),
    ),
    BlocProvider<BrandsBloc>(
      create: (context) => BrandsBloc()
        ..add(
          BrandsLoadEvent("1", "5"),
        ),
    ),
  ];
}
