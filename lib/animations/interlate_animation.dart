import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notepad/blocs/login_blocs/login_bloc.dart';

/**
  *  @Author:  fus
  *   @date 2025-03-26
  *   @description : 
  *   实现交错动画,两个类似的子部件实现层叠效果,同时,可以在子部件点击的时候实现交错动画
  *   组件在交错到最大的尺寸的时候会进行位置交换,前后位置进行交换
  */

class InterlateAnimation extends StatefulWidget {
  const InterlateAnimation({
    super.key,
    required this.fontChild,
    required this.backChild,
  });

  final Widget fontChild;
  final Widget backChild;

  /**
   *scene用来标定当前的登录状态,这里通过外传参数来进行判断
   *通过外部的bloc发送事件来修改scene的状态
   *同时为通过animationController控制监听screne来播放动画进行交错切换
   */
  // final ValueNotifier<loginScene> screne;

  @override
  State<InterlateAnimation> createState() => _InterlateAnimationState();
}

class _InterlateAnimationState extends State<InterlateAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  bool isLogin = true;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget mainAnimation(Widget child, bool isLogin) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.identity()
            ..translate(
                isLogin
                    ? _animationController.value * 100
                    : -_animationController.value * 100,
                isLogin
                    ? -_animationController.value * 100
                    : _animationController.value * 100),
          alignment: Alignment.center,
          child: child,
        );
      },
      child: child,
    );
  }

  bool _changeState(LoginState previous, LoginState current) {
    if (current is LoginInitialState) {
      _animationController.forward().then((_) {
        isLogin = true;
      }).then((_) {
        _animationController.reverse();
      });
    }
    if (current is SignInInitialState) {
      _animationController.forward().then((_) {
        isLogin = false;
      }).then((_) {
        _animationController.reverse();
      });
    }
    return true;
  }

  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) {
        return _changeState(previous, current);
      },
      builder: (context, state) {
        return Stack(
          children: _buildStack(state),
        );
      },
    );
  }

  List<Widget> _buildStack(LoginState state) {
    switch (state) {
      case LoginInitialState():
        return [
          mainAnimation(widget.backChild, isLogin),
          mainAnimation(widget.fontChild, !isLogin),
        ];

      case SignInInitialState():
        return [
          mainAnimation(widget.fontChild, !isLogin),
          mainAnimation(widget.backChild, isLogin),
        ];
      default:
        return [
          mainAnimation(widget.backChild, isLogin),
          mainAnimation(
            widget.fontChild,
            !isLogin,
          )
        ];
    }
  }
}
