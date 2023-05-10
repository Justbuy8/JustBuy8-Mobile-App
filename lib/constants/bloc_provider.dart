import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/authentication/send_otp/send_otp_cubit.dart';
import 'package:justbuyeight/blocs/authentication/timer_cubit/timer_cubit.dart';
import 'package:justbuyeight/blocs/authentication/validate_email/validate_email_cubit.dart';

class BlocProviders {
  static final List<BlocProvider> providers = [
    BlocProvider<ValidateEmailCubit>(create: (context) => ValidateEmailCubit()),
    BlocProvider<SendOtpCubit>(create: (context) => SendOtpCubit()),
    BlocProvider<OtpTimerCubit>(create: (context) => OtpTimerCubit()),
  ];
}
