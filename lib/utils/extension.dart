import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:notepad/animations/fade_animation.dart';
import 'package:notepad/data/model/food.dart';

extension BlocBaseExt on BlocBase {
  void dispose() {}
}

extension IterableExt on List<Food> {
  getIndex(Food food) {
    int index = indexWhere((Element) => Element.id == food.id);
    return index;
  }
}

extension FadeAnminationExt on Widget {
  Widget fadeAnimation(double delay) {
    return FadeAnimation(
      delay: delay,
      child: this,
    );
  }
}

extension TextThemeExt on BuildContext {
  TextStyle get headlineSmall => Theme.of(this).textTheme.headlineSmall!;

  TextStyle get headlineMedium => Theme.of(this).textTheme.headlineMedium!;

  TextStyle get displayMedium => Theme.of(this).textTheme.displayMedium!;

  TextStyle get displaySmall => Theme.of(this).textTheme.displaySmall!;

  TextStyle get displayLarge => Theme.of(this).textTheme.displayLarge!;

  TextStyle get bodyLarge => Theme.of(this).textTheme.bodyLarge!;

  TextStyle get titleMedium => Theme.of(this).textTheme.titleMedium!;
}
