part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginByEmail extends LoginEvent {
  final LoginRequest? model;

  const LoginByEmail({required this.model});
}
