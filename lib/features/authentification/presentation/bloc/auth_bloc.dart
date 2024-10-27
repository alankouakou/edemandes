import 'package:demandes/features/authentification/domain/entities/user.dart';
import 'package:demandes/features/authentification/domain/usecases/user_login.dart';
import 'package:demandes/features/authentification/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserLogin _userLogin;
  final UserSignUp _userSignUp;
  AuthBloc({required UserSignUp userSignUp, required UserLogin userLogin})
      : _userSignUp = userSignUp,
        _userLogin = userLogin,
        super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading());
      final res = await _userSignUp(UserSignupParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ));

      res.fold(
        (failure) => emit(AuthFailure(message: failure.message)),
        (user) => emit(AuthSuccess(user: user)),
      );
    });

    on<AuthLogin>((event, emit) async {
      emit(AuthLoading());
      final res = await _userLogin(UserLoginParams(
        email: event.email,
        password: event.password,
      ));
      res.fold(
        (failure) => emit(AuthFailure(message: failure.message)),
        (user) => emit(AuthSuccess(user: user)),
      );
    });
  }
}
