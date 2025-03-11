import 'package:badges/badges.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notepad/blocs/theme_blocs/theme_bloc.dart';
import 'package:notepad/blocs/theme_blocs/theme_event.dart';
import 'package:notepad/core/app_color.dart';
import 'package:notepad/page/food/widget/widget_tabbar.dart';
import 'package:notepad/utils/extension.dart';

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
          onPressed: () {},
          icon: Badge(
            badgeStyle: const BadgeStyle(
              badgeColor: LightThemeColor.accent,
            ),
            badgeContent: const Text(
              "2",
              style: TextStyle(color: Colors.white),
            ),
            position: BadgePosition.topEnd(end: -8, top: -15),
            child: const Icon(Icons.notifications_none, size: 30),
          ),
        ),
        IconButton(
            onPressed: () {},
            //为图标添加徽章，类似消息红点
            icon: Badge(
              badgeStyle: const BadgeStyle(
                badgeColor: LightThemeColor.accent,
              ),
              badgeContent: const Text(
                "2",
                style: TextStyle(color: Colors.white),
              ),
              position: BadgePosition.topEnd(end: -8, top: -15),
              child: Icon(
                Icons.shopping_cart,
                size: 30,
              ),
            )),
      ],
    );
  }

  Widget _searchBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search Food",
          hintStyle: context.displaySmall.copyWith(color: Colors.grey),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildSliver(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Morning, Sina",
            style: context.headlineSmall,
          ).fadeAnimation(0.2),
          Text(
            "What do you want to eat \ntoday",
            style: context.displayLarge,
          ).fadeAnimation(0.2),
          _searchBar(context),
          Text(
            "Available for you",
            style: context.displaySmall,
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => SystemChannels.textInput.invokeMethod("TextInput.hide"),
      child: Scaffold(
        appBar: _appBar(context),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: NestedScrollView(
            dragStartBehavior: DragStartBehavior.start,
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(child: _buildSliver(context)),
            ],
            body: WidgetTabbar(),
          ),
        ),
      ),
    );
  }
}
