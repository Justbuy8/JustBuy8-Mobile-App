import 'package:bloc/bloc.dart';
import 'package:justbuyeight/constants/secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:nb_utils/nb_utils.dart';

part 'splash_state.dart';

class SessionHandlingCubit extends Cubit<SessionHandlingState> {
  SessionHandlingCubit() : super(SessionHandlingInitial());

  initliazeRoute() async {
    try {
      bool connectionValue = await isNetworkAvailable();
      if (connectionValue) {
        var userToken = await UserSecureStorage.fetchToken();
        var userId = await UserSecureStorage.fetchUserId();
        var newUser = await UserSecureStorage.fetchNewUser();

        if (userToken != null && userId != null) {
          emit(SessionHandlingHomeScreen());
        } else if (userToken == null && userId == null && newUser == null) {
          emit(SessionHandlingHomeScreen());
        } else {
          // emit(SessionHandlingOnBoardingScreen());
        }
      } else {
        emit(SessionHandlingFailed());
      }
    } catch (e) {
      emit(SessionHandlingFailed());
    }
  }
}
