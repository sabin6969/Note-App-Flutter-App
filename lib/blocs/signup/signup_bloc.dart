import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_flutter_mobile_app/blocs/signup/signup_event.dart';
import 'package:note_app_flutter_mobile_app/blocs/signup/signup_state.dart';
import 'package:note_app_flutter_mobile_app/data/repository/user_repository.dart';
import 'package:note_app_flutter_mobile_app/exceptions/custom_exceptions.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  UserRepository userRepository;
  SignupBloc({required this.userRepository}) : super(SignupInitialState()) {
    on<SignupButtonPressedEvent>(handleSignupButtonPressedEvent);
  }
  void handleSignupButtonPressedEvent(
      SignupButtonPressedEvent event, Emitter<SignupState> emit) async {
    if (event.email.isEmpty ||
        event.fullName.isEmpty ||
        event.password.isEmpty) {
      emit(SignupFailedState(errorMessage: "All fields are required"));
    } else {
      if (event.imageFile == null) {
        emit(SignupFailedState(errorMessage: "Please select a profile image"));
      } else {
        try {
          emit(SignupLoadingState());
          String message = await userRepository.signupUser(
            email: event.email,
            password: event.password,
            imageFile: event.imageFile!,
            fullName: event.fullName,
          );
          emit(SignupSucessState(message: message));
        } on CustomException catch (e) {
          emit(SignupFailedState(errorMessage: e.message));
        } catch (e) {
          emit(SignupFailedState(
              errorMessage: "Something went wrong while signing up"));
        }
      }
    }
  }
}
