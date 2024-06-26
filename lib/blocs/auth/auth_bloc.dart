import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_flutter_mobile_app/blocs/auth/auth_event.dart';
import 'package:note_app_flutter_mobile_app/blocs/auth/auth_state.dart';
import 'package:note_app_flutter_mobile_app/data/repository/auth_repository.dart';
import 'package:note_app_flutter_mobile_app/exceptions/custom_exceptions.dart';
import 'package:note_app_flutter_mobile_app/services/shared_preferences_services.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthInitialState()) {
    on<AuthVerifyAcesstokenEvent>(handleAuthVerifyAcesstokenEvent);
  }

  void handleAuthVerifyAcesstokenEvent(
      AuthVerifyAcesstokenEvent event, Emitter<AuthState> emit) async {
    try {
      String? accessToken = SharedPreferenceServices.getAccessToken();
      if (accessToken == null) {
        // access token == null means user has not loggedin yet!
        emit(AuthFailedState(
            errorMessage: "Welcome! please proceed with login or signup"));
      } else {
        String message = await authRepository.verifyAccesstoken(
          accessToken: accessToken,
        );
        emit(AuthSucessState(message: message));
      }
    } on CustomException catch (e) {
      emit(AuthFailedState(errorMessage: e.message));
    } on SocketException {
      emit(AuthFailedState(errorMessage: "No internet connection!!"));
    } catch (e) {
      emit(AuthFailedState(errorMessage: "Something went wrong!!"));
    }
    return;
  }
}
