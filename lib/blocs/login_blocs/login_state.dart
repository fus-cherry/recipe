part of 'login_bloc.dart';

/**
 * 此处处理登录状态,同时作为监控动画状态
 * LoginInitial:初始状态
 * LoginLoadingState:加载状态
 * LoginSuccessState:登录成功
 * LoginSingUpLodingState:注册中,此状态切换到注册界面
 * SingUpSuccessState:注册成功, 之后自动切换到登录界面,在登录界面进行登录
 */
sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitialState extends LoginState {}

final class SignInInitialState extends LoginState {}

final class LoginLoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

final class SingUpLodingState extends LoginState {}

final class LoginSuccessState extends LoginState {}

final class LoginErrorState extends LoginState {}
