import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/products/products_by_shop_controller.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';
import 'package:nb_utils/nb_utils.dart';

part 'products_by_shop_states_events.dart';

// Define a Bloc class for managing the state of products by shop.
class ProductsByShopBloc
    extends Bloc<ProductsByShopEvent, ProductsByShopState> {
  ProductsByShopBloc() : super(ProductsByShopInitial()) {
    List<ProductModel> products = [];

    // Handle the event to get initial products by shop.
    on<GetProductsByShopInitial>((event, emit) async {
      // Emit a loading state to indicate that data is being fetched.
      emit(ProductsByShopLoading());
      try {
        // Check if there is an internet connection.
        bool network = await isNetworkAvailable();
        if (!network) {
          // Emit a failed state with an internet connectivity message.
          emit(ProductsByShopFailed(message: AppText.internetError));
          return;
        }
        // Fetch products by shop using the controller.
        products = await ProductsByShopController.getProductsByShop(
          event.page,
          event.paginateBy,
          event.shopId,
        );
        if (products.isEmpty) {
          // Emit an empty state if no products are found.
          emit(ProductsByShopEmpty());
        } else {
          // Emit a loaded state with the fetched products.
          emit(ProductsByShopLoaded(products: products));
        }
      } catch (e) {
        // Handle and print any exceptions.
        print(e);
      }
    });

    // Handle the event to get more products by shop.
    on<GetProductsByShopMore>((event, emit) async {
      // Emit a loading state to indicate that more data is being fetched.
      emit(ProductsByShopMoreLoading());
      try {
        // Check if there is an internet connection.
        bool network = await isNetworkAvailable();
        if (!network) {
          // Emit a failed state with an internet connectivity message.
          emit(ProductsByShopFailed(message: AppText.internetError));
          return;
        }
        // Fetch more products by shop using the controller.
        products = await ProductsByShopController.getProductsByShop(
          event.page,
          event.paginateBy,
          event.shopId,
        );

        // Emit a loaded state with the fetched products.
        emit(ProductsByShopLoaded(products: products));
      } catch (e) {
        // Handle and print any exceptions.
        print(e);
      }
    });
  }
}
