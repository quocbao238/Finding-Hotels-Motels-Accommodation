  import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/repository/user_repository.dart';
import 'package:findingmotels/validator/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository;

  LoginBloc({this.userRepository});

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressedEvent) {
      yield LoginLoadingState();
      if (Valid.isEmail(event.email)) {
        if (Valid.isPassword(event.password)) {
          try {
            var user = await userRepository.signInEmailAndPassword(
                event.email, event.password);
            if (user != null) {
              ConfigApp.fbuser = user;
              ConfigApp.userRepository = userRepository;
              yield LoginSuccessState(user: user);
            } else {
              yield LoginFailState(
                  message: "Email & Password is incorrect! Please check again");
            }
          } catch (e) {
            yield LoginFailState(
                message: "An error occurred, please try again later");
          }
        } else {
          yield LoginFailState(message: "Password format is incorrect");
        }
      } else {
        yield LoginFailState(message: "Email format is incorrect");
      }
    } else if (event is GotoSignUpPageEvent) {
      yield GotoSignUpPageState();
    } else if (event is HideShowPasswordEvent) {
      yield HideShowPasswordState(isHide: event.isHide);
    } else if (event is GoogleOnClickEvent) {
      yield LoginLoadingState();
      try {
        var user = await userRepository.loginWithGoogle();
        if (user != null) {
          ConfigApp.fbuser = user;
          ConfigApp.userRepository = userRepository;
          yield LoginSuccessState(user: user);
        } else {
          yield LoginFailState(
              message: "An error occurred, please try again later");
        }
      } catch (e) {
        yield LoginFailState(
            message: "An error occurred, please try again later");
      }
    }
    yield LoginInitial();
  }
}
