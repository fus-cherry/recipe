import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notepad/blocs/food_blocs/food_bloc.dart';
import 'package:notepad/blocs/login_blocs/login_bloc.dart';
import 'package:notepad/blocs/message_bloc/message_bloc.dart';
import 'package:notepad/blocs/theme_blocs/theme_bloc.dart';
import 'package:notepad/blocs/theme_blocs/theme_state.dart';
import 'package:notepad/data/repository/repository.dart';
import 'package:notepad/page/login/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
  );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<Repository>(
      create: (context) => Repository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<FoodBloc>(
            create: (context) =>
                FoodBloc(repository: context.read<Repository>()),
          ),
          BlocProvider<ThemeBloc>(
            create: (context) => ThemeBloc(),
          ),
          BlocProvider<MessageBloc>(
            create: (context) => MessageBloc(),
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(),
          ),
        ],
        child: BlocBuilder<ThemeBloc, ThemeBlocState>(
          builder: (context, State) {
            return MaterialApp(
              home: LoginScreen(),
              title: 'notepad',
              debugShowCheckedModeBanner: false,
              theme: State.themeData,
            );
          },
        ),
      ),
    );
  }
}
