import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/controllers/wishlist/wishlist_controller.dart';
import 'package:nb_utils/nb_utils.dart';

part 'add_to_wishlist_events_states.dart';

class AddToWishlistBloc extends Bloc<AddToWishlistEvent, AddToWishlistState> {
  AddToWishlistBloc() : super(AddToWishlistInitState()) {
    on<AddToWishlistOnClickEvent>((event, emit) async {
      emit(AddToWishlistLoadingState());
      try {
        final networkStatus = await isNetworkAvailable();
        if (!networkStatus) {
          emit(AddToWishlistErrorState("No internet connection"));
          return;
        }
        final message = await WishlistController.deleteOrAddWishlist(
          productId: event.productId,
          addToWishlist: true,
        );
        emit(AddToWishlistSuccessState(message));
      } catch (e) {
        emit(AddToWishlistErrorState(e.toString()));
      }
    });
  }
}
