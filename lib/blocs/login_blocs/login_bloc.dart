import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

enum loginScene { logIn, signIn }

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<LoginInitial>(_changeState);
    on<SignInInitial>(_changeSignInState);
  }

  /**
   * 切换登录状态,从登录切换到注册,从注册切换到登录
   * 后续添加切换登录方式的方法,例如从邮箱登录切换到手机号登录
   * 第三方登录使用emit直接发送事件进行处理
   */
  void _changeState(LoginInitial event, Emitter<LoginState> emit) {
    emit(LoginInitialState());
    print("$state");
  }

  void _changeSignInState(SignInInitial event, Emitter<LoginState> emit) {
    emit(SignInInitialState());
    print("$state");
  }
}
