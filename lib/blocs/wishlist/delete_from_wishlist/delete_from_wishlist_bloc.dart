import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/wishlist/wishlist_controller.dart';
import 'package:nb_utils/nb_utils.dart';

part 'delete_from_wishlist_events_states.dart';

class DeleteFromWishlistBloc
    extends Bloc<DeleteFromWishlistEvent, DeleteFromWishlistState> {
  DeleteFromWishlistBloc() : super(DeleteFromWishlistInitState()) {
    on<DeleteFromWishlistOnClickEvent>((event, emit) async {
      emit(DeleteFromWishlistLoadingState());
      try {
        final networkStatus = await isNetworkAvailable();
        if (!networkStatus) {
          emit(DeleteFromWishlistErrorState(AppText.internetError));
          return;
        }
        final message = await WishlistController.deleteOrAddWishlist(
          productId: event.productId,
          deleteFromWishlist: true,
        );
        emit(DeleteFromWishlistSuccessState(message, event.productId));
      } catch (e) {
        emit(DeleteFromWishlistErrorState(e.toString()));
      }
    });
  }
}
