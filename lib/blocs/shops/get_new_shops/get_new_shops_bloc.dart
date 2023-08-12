import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/shops/shop_controller.dart';
import 'package:justbuyeight/models/shop/Shop.dart';
import 'package:nb_utils/nb_utils.dart';

part 'get_new_shops_states_events.dart';

class NewShopsBloc extends Bloc<NewShopsEvent, NewShopsState> {
  NewShopsBloc() : super(NewShopsInitialState()) {
    List<Shop> newShops = [];
    on<GetNewShopsEvent>((event, emit) async {
      emit(NewShopsLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (!networkStatus) {
          emit(NewShopsErrorState(message: AppText.internetError));
        } else {
          newShops = await ShopController.getNewShops();
          if (newShops.isEmpty) {
            emit(NewShopsEmptyState());
          } else {
            emit(NewShopsSuccessState(shops: newShops));
          }
        }
      } catch (e) {}
    });
  }
}
