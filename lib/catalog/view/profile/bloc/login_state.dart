part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccessfully extends LoginState {
  final LoginResponse? userTokens;

  const LoginSuccessfully({required this.userTokens});
}

class LoginError extends LoginState {
  final String? message;

  const LoginError(this.message);
}
