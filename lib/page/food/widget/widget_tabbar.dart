import 'package:flutter/material.dart';
import 'package:notepad/page/food/widget/list_container.dart';
import 'package:notepad/utils/extension.dart';

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
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[400],
              ),
              overlayColor: WidgetStatePropertyAll(Colors.transparent),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              dividerHeight: 0,
              tabs: [
                _buildBar(context, "All"),
                _buildBar(context, "Sushi"),
                _buildBar(context, "Kebab"),
                _buildBar(context, "Tempura"),
              ],
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // _foodList(context, 'All'),
              ListContainer(),
              _foodList(context, 'Sushi'),
              _foodList(context, 'Kebab'),
              _foodList(context, 'Tempura'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _foodList(BuildContext context, String category) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.fastfood),
          title: Text("$category Item $index"),
          subtitle: Text("Description for $category item $index"),
        );
      },
    );
  }

  Widget _buildBar(BuildContext context, String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 9),
      child: Text(
        text,
        style: context.headlineMedium,
      ),
    );
  }
}
