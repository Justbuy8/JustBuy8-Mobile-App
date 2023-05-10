part of 'send_otp_cubit.dart';

@immutable
abstract class SendOtpState {}

class SendOtpInitial extends SendOtpState {}

class SendOtpLoading extends SendOtpState {}

class SendOtpSuccessfuly extends SendOtpState {}

class SendOtpFailed extends SendOtpState {}

class SendOtpInternetError extends SendOtpState {}

class SendOtpTimeOut extends SendOtpState {}
