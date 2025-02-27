import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notepad/blocs/theme_blocs/theme_bloc.dart';
import 'package:notepad/blocs/theme_blocs/theme_event.dart';
import 'package:notepad/core/app_color.dart';

class FoodListScreen extends StatelessWidget {
  const FoodListScreen({super.key});

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const FaIcon(FontAwesomeIcons.dice),
        onPressed: () {
          context.read<ThemeBloc>().add(ThemeBlocEvent());
        },
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.location_on_outlined, color: LightThemeColor.accent),
          Text("Location", style: Theme.of(context).textTheme.bodyLarge)
        ],
      ),
      actions: [
        IconButton(
          icon: FaIcon(FontAwesomeIcons.magnifyingGlassArrowRight),
          onPressed: () {},
        ),
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.bullseye),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: const Center(
        child: Text('Food List Screen'),
      ),
    );
  }
}
