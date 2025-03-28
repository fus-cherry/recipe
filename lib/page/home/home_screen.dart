import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:notepad/animations/page_translation.dart';
import 'package:notepad/core/app_data.dart';
import 'package:notepad/page/cart/cart_screen.dart';
import 'package:notepad/page/favorite/favorite_screen.dart';
import 'package:notepad/page/food/food_screen.dart';
import 'package:notepad/page/profile/profile_screen.dart';

class HomeScreen extends HookWidget {
  HomeScreen({super.key});

  final List<Widget> screen = [
    const FoodListScreen(),
    const MessagePage(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final selecIndex = useState(0);
    return Scaffold(
      body: PageTranslation(child: screen[selecIndex.value]),
      bottomNavigationBar: BottomNavigationBar(
          items: AppData.bottomNavigationItems.map((element) {
            return BottomNavigationBarItem(
              icon: element.disableIcon,
              label: element.label,
              activeIcon: element.enableIcon,
            );
          }).toList(),
          currentIndex: selecIndex.value,
          onTap: (index) => selecIndex.value = index),
    );
  }
}
