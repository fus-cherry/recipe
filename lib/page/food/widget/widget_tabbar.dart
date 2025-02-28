import 'package:flutter/material.dart';

class WidgetTabbar extends StatefulWidget {
  const WidgetTabbar({super.key});

  @override
  State<WidgetTabbar> createState() => _WidgetTabbarState();
}

class _WidgetTabbarState extends State<WidgetTabbar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: TabBar(controller: _tabController, tabs: [
            Text("All"),
            Text("Sushi"),
            Text("Kebab"),
            Text("Tempura")
          ]),
        ),
        SizedBox(
          height: 300, // 或者你可以根据内容的大小来调整高度
          child: TabBarView(controller: _tabController, children: [
            _foodList(context),
            _foodList(context),
            _foodList(context),
            _foodList(context),
          ]),
        ),
      ],
    );
  }

  // 返回 ListView.builder
  Widget _foodList(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // 假设这里的数量为 10
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.fastfood),
          title: Text("Food Item $index"),
          subtitle: Text("Description for food item $index"),
        );
      },
    );
  }
}
