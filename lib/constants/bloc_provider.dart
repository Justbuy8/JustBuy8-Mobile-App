import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/authentication/validate_email/validate_email_cubit.dart';

class BlocProviders {
  static final List<BlocProvider> providers = [
    BlocProvider<ValidateEmailCubit>(create: (context) => ValidateEmailCubit()),
  ];
}
