import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_flutter_mobile_app/blocs/login/login_event.dart';
import 'package:note_app_flutter_mobile_app/blocs/login/login_state.dart';
import 'package:note_app_flutter_mobile_app/data/models/login_response_model.dart';
import 'package:note_app_flutter_mobile_app/data/repository/user_repository.dart';
import 'package:note_app_flutter_mobile_app/exceptions/custom_exceptions.dart';
import 'package:note_app_flutter_mobile_app/services/shared_preferences_services.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  LoginBloc({required this.userRepository}) : super(LoginInitialState()) {
    on<LoginButtonPressedEvent>(handleLoginButtonPressedEvent);
  }

  FutureOr<void> handleLoginButtonPressedEvent(
      LoginButtonPressedEvent event, Emitter<LoginState> emit) async {
    if (event.email.isEmpty || event.password.isEmpty) {
      emit(LoginValidationErrorState(message: "All fields are required"));
    } else {
      try {
        emit(LoginLoadingState());
        LoginResponse loginResponse = await userRepository.loginUser(
            email: event.email, password: event.password);
        SharedPreferenceServices.setAccessToken(
            loginResponse.data!.accessToken!);
        emit(LoginSucessState(loginResponse: loginResponse));
      } on CustomException catch (e) {
        emit(LoginFailedState(message: e.message));
      } on SocketException {
        emit(LoginFailedState(
            message:
                "No internet detected\nPlease check your internet connection"));
      } catch (e) {
        emit(
          LoginFailedState(
            message: "Something went wrong while login try again",
          ),
        );
      }
    }
  }
}
