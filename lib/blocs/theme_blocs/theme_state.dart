import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:notepad/core/app_theme.dart';

class ThemeBlocState extends Equatable {
  final ThemeData theme;

  const ThemeBlocState(this.theme);

  factory ThemeBlocState.initial() {
    return ThemeBlocState(AppThemes.appThemeData[AppTheme.lightTheme]!);
  }
  @override
  List<Object?> get props => [theme];

  get themeData => theme;

  ThemeBlocState copyWith({ThemeData? theme}) {
    return ThemeBlocState(theme ?? this.theme);
  }
}
