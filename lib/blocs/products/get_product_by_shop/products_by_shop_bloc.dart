import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/products/products_by_shop_controller.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';
import 'package:nb_utils/nb_utils.dart';

part 'products_by_shop_states_events.dart';

class ProductsByShopBloc
    extends Bloc<ProductsByShopEvent, ProductsByShopState> {
  ProductsByShopBloc() : super(ProductsByShopInitial()) {
    List<ProductModel> products = [];
    on<GetProductsByShopInitial>((event, emit) async {
      emit(ProductsByShopLoading());
      try {
        bool network = await isNetworkAvailable();
        if (!network) {
          emit(ProductsByShopFailed(message: AppText.internetError));
          return;
        }
        products = await ProductsByShopController.getProductsByShop(
          event.page,
          event.paginateBy,
          event.shopId,
        );
        if (products.isEmpty)
          emit(ProductsByShopEmpty());
        else
          emit(ProductsByShopLoaded(products: products));
      } catch (e) {
        print(e);
      }
    });

    on<GetProductsByShopMore>((event, emit) async {
      emit(ProductsByShopMoreLoading());
      try {
        bool network = await isNetworkAvailable();
        if (!network) {
          emit(ProductsByShopFailed(message: AppText.internetError));
          return;
        }
        products = await ProductsByShopController.getProductsByShop(
          event.page,
          event.paginateBy,
          event.shopId,
        );

        emit(ProductsByShopLoaded(products: products));
      } catch (e) {
        print(e);
      }
    });
  }
}
