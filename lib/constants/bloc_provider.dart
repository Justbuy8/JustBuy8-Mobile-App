import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/address/create_address/create_address_cubit.dart';
import 'package:justbuyeight/blocs/address/delete_address/delete_address_cubit.dart';
import 'package:justbuyeight/blocs/address/get_address/get_address_cubit.dart';
import 'package:justbuyeight/blocs/authentication/login/login_cubit.dart';
import 'package:justbuyeight/blocs/authentication/registration/registration_cubit.dart';
import 'package:justbuyeight/blocs/authentication/reset_password_cubit/reset_password_cubit.dart';
import 'package:justbuyeight/blocs/authentication/send_otp/send_otp_cubit.dart';
import 'package:justbuyeight/blocs/authentication/timer_cubit/timer_cubit.dart';
import 'package:justbuyeight/blocs/authentication/validate_email/validate_email_cubit.dart';
import 'package:justbuyeight/blocs/authentication/verify_email_cubit/verify_email_cubit.dart';
import 'package:justbuyeight/blocs/contact_us/contact_us_cubit.dart';
import 'package:justbuyeight/blocs/myaccount/myaccount_cubit.dart';
import 'package:justbuyeight/blocs/products/arrivals/new_arrival_bloc.dart';
import 'package:justbuyeight/blocs/session_handling/splash_cubit.dart';
import 'package:justbuyeight/blocs/support_cubit/support_cubit.dart';
import 'package:justbuyeight/blocs/update_address/update_address_cubit.dart';
import 'package:justbuyeight/blocs/update_user_profile/update_user_profile_cubit.dart';
import 'package:justbuyeight/blocs/upload_image/upload_image_cubit.dart';
import 'package:justbuyeight/blocs/wishlist/delete_from_wishlist/delete_from_wishlist_bloc.dart';
import 'package:justbuyeight/blocs/wishlist/wishlist_bloc.dart';

class BlocProviders {
  static List<BlocProvider> providers = [
    BlocProvider<ValidateEmailCubit>(create: (context) => ValidateEmailCubit()),
    BlocProvider<SendOtpCubit>(create: (context) => SendOtpCubit()),
    BlocProvider<OtpTimerCubit>(create: (context) => OtpTimerCubit()),
    BlocProvider<RegistrationCubit>(create: (context) => RegistrationCubit()),
    BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
    BlocProvider<VerifyEmailCubit>(create: (context) => VerifyEmailCubit()),
    BlocProvider<ResetPasswordCubit>(create: (context) => ResetPasswordCubit()),
    BlocProvider<SessionHandlingCubit>(
        create: (context) => SessionHandlingCubit()..initliazeRoute()),
    BlocProvider<NewArrivalBloc>(create: (context) => NewArrivalBloc()),
    BlocProvider<MyaccountCubit>(create: (context) => MyaccountCubit()),
    BlocProvider<UploadImageCubit>(create: (context) => UploadImageCubit()),
    BlocProvider<UpdateUserProfileCubit>(
        create: (context) => UpdateUserProfileCubit()),
    BlocProvider<CreateAddressCubit>(create: (context) => CreateAddressCubit()),
    BlocProvider<GetAddressCubit>(
        create: (context) => GetAddressCubit()..getAddress()),
    BlocProvider<UpdateAddressCubit>(create: (context) => UpdateAddressCubit()),
    BlocProvider<DeleteAddressCubit>(create: (context) => DeleteAddressCubit()),
    BlocProvider<WishlistBloc>(create: (context) => WishlistBloc()),
    BlocProvider<SupportCubit>(create: (context) => SupportCubit()),
    BlocProvider<ContactUsCubit>(create: (context) => ContactUsCubit()),
    BlocProvider<DeleteFromWishlistBloc>(
        create: (context) => DeleteFromWishlistBloc()),
  ];
}
