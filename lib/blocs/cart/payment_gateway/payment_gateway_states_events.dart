part of 'payment_gateway_bloc.dart';

abstract class PaymentGatewayEvent {}

class GetPaymentGateways extends PaymentGatewayEvent {}

abstract class PaymentGatewayState {}

class PaymentGatewayInitial extends PaymentGatewayState {}

class PaymentGatewayLoading extends PaymentGatewayState {}

class PaymentGatewayLoaded extends PaymentGatewayState {
  final PaymentGateway paymentGateways;

  PaymentGatewayLoaded({required this.paymentGateways});
}

class PaymentGatewayError extends PaymentGatewayState {
  final String message;

  PaymentGatewayError({required this.message});
}
