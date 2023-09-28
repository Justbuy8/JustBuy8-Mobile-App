import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/products/product_details_controller.dart';
import 'package:justbuyeight/models/products/ProductDetailsModel.dart';
import 'package:nb_utils/nb_utils.dart';

// Define a Bloc class for managing the state of product details.
part 'product_details_states_events.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc() : super(ProductDetailsInitialState()) {
    ProductDetailsModel? product;

    // Handle the event to get product details.
    on<ProductDetailsGetDataEvent>((event, emit) async {
      // Check if there is internet connectivity.
      bool isInternet = await isNetworkAvailable();
      if (isInternet) {
        // Emit a loading state to indicate that data is being fetched.
        emit(ProductDetailsLoadingState());

        // Fetch product details using the controller.
        product = await ProductDetailsController.getProducts(event.productId);
        if (product != null) {
          // Emit a success state with the fetched product details.
          emit(ProductDetailsSuccessState(product: product!));
        } else {
          // Emit an error state if no products are found.
          emit(ProductDetailsErrorState(error: AppText.noProductsFound));
        }
      } else {
        // Emit an error state for no internet connectivity.
        emit(ProductDetailsErrorState(error: AppText.internetError));
      }
    });
  }
}
