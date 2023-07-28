import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/products/product_details_controller.dart';
import 'package:justbuyeight/models/products/ProductDetailsModel.dart';
import 'package:nb_utils/nb_utils.dart';

part 'product_details_states_events.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc() : super(ProductDetailsInitialState()) {
    ProductDetailsModel? product;
    on<ProductDetailsGetDataEvent>((event, emit) async {
      bool isInternet = await isNetworkAvailable();
      if (isInternet) {
        emit(ProductDetailsLoadingState());
        product = await ProductDetailsController.getProducts(event.productId);
        if (product != null) {
          emit(ProductDetailsSuccessState(product: product!));
        } else {
          emit(ProductDetailsErrorState(error: AppText.noProductsFound));
        }
      } else {
        emit(ProductDetailsErrorState(error: AppText.internetError));
      }
    });
  }
}
