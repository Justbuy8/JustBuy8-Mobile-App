import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/shops/shop_controller.dart';
import 'package:justbuyeight/models/shop/ShopDetailsModel.dart';
import 'package:nb_utils/nb_utils.dart';

part 'shop_details_states_events.dart';

class ShopDetailsBloc extends Bloc<ShopDetailsEvent, ShopDetailsState> {
  ShopDetailsBloc() : super(ShopDetailsInitial()) {
    // Handle Event
    on<GetShopDetails>((event, emit) async {
      emit(ShopDetailsLoading());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (!networkStatus) {
          emit(ShopDetailsFailed(message: AppText.internetError));
        } else {
          final shop = await ShopController.getShopDetails(event.shopId);
          emit(ShopDetailsLoaded(shop: shop));
        }
      } catch (error) {
        // handle internet exception
        emit(ShopDetailsFailed(message: error.toString()));
      }
    });
  }
}
