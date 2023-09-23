import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/shops/shop_controller.dart';
import 'package:justbuyeight/models/shop/Shop.dart';
import 'package:nb_utils/nb_utils.dart';

part 'get_all_shops_states_events.dart';

class GetAllShopsBloc extends Bloc<GetAllShopsEvent, GetAllShopsState> {
  GetAllShopsBloc() : super(GetAllShopsInitial()) {
    List<Shop> shops = [];
    on<GetAllShops>((event, emit) async {
      emit(GetAllShopsLoading());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (!networkStatus) {
          emit(GetAllShopsFailed(message: AppText.internetError));
          return;
        }
        shops = await ShopController.getAllShops(event.page, event.paginatedBy);

        if (shops.isEmpty) {
          emit(GetAllShopsEmpty());
          return;
        }
        emit(GetAllShopsSuccess(shops: shops));
      } catch (e) {
        if (e is SocketException) {
          emit(GetAllShopsFailed(message: AppText.internetError));
        } else if (e is HttpException) {
          emit(GetAllShopsFailed(message: AppText.serverError));
        } else {
          emit(GetAllShopsFailed(message: e.toString()));
        }
      }
    });

    on<GetMoreShops>((event, emit) async {
      emit(GetAllShopsMoreLoading());
      try {
        shops = await ShopController.getAllShops(event.page, event.paginatedBy);
        emit(GetAllShopsSuccess(shops: shops));
      } catch (error) {}
    });
  }
}
