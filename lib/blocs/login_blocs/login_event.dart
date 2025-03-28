part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class SignUp extends LoginEvent {}

final class SignInInitial extends LoginEvent {}

final class SignUpLoading extends LoginEvent {}

final class SignUpSuccess extends LoginEvent {}

final class LoginInitial extends LoginEvent {}

final class LoginLoading extends LoginEvent {}

final class LoginSuccess extends LoginEvent {}

final class LogOut extends LoginEvent {}
