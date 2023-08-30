import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/controllers/payment_gateway/payment_gateway_controller.dart';
import 'package:justbuyeight/models/cart/payment_gateway/payment_gateway.dart';

part 'payment_gateway_states_events.dart';

class PaymentGatewayBloc
    extends Bloc<PaymentGatewayEvent, PaymentGatewayState> {
  PaymentGatewayBloc() : super(PaymentGatewayInitial()) {
    // Listen to events
    on<GetPaymentGateways>((event, emit) async {
      // emit loading state
      emit(PaymentGatewayLoading());
      // get payment gateways
      try {
        PaymentGateway paymentGateways =
            await PaymentGatewayController.getPaymentGateways();
        // emit loaded state
        emit(PaymentGatewayLoaded(paymentGateways: paymentGateways));
      } catch (error) {
        // emit no internet connection state
        if (error.toString().contains('SocketException')) {
          emit(PaymentGatewayError(message: 'No Internet Connection'));
        } else
          emit(PaymentGatewayError(message: error.toString()));
      }
    });
  }
}
