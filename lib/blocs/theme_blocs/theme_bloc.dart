import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notepad/core/app_theme.dart';
import 'package:notepad/blocs/theme_blocs/theme_event.dart';
import 'package:notepad/blocs/theme_blocs/theme_state.dart';

class ThemeBloc extends Bloc<ThemeBlocEvent, ThemeBlocState> {
  ThemeBloc() : super(ThemeBlocState.initial()) {
    on<ThemeBlocEvent>(_switchTheme);
  }

  void _switchTheme(ThemeBlocEvent event, Emitter<ThemeBlocState> emit) {
    if (state.theme == AppThemes.appThemeData[AppTheme.lightTheme]) {
      emit(ThemeBlocState(AppThemes.appThemeData[AppTheme.darkTheme]!));
    } else {
      emit(ThemeBlocState(AppThemes.appThemeData[AppTheme.lightTheme]!));
    }
  }

  bool get isLightTheme =>
      state.theme == AppThemes.appThemeData[AppTheme.lightTheme];
}
