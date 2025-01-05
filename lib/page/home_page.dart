import 'package:flutter/material.dart';
import 'package:food_delivery/components/my_food_tile.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/components/my_current_local.dart';
import 'package:food_delivery/components/my_drawer.dart';
import 'package:food_delivery/components/my_sliver_app.dart';
import 'package:food_delivery/components/my_tab_bar.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/page/food_page.dart';
import 'package:provider/provider.dart';

import '../components/my_description_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  //tab controller
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: FoodCategory.values.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // sort out and return a list of food items that belong to a specific category
  List<Food> _filterMenuByCategory(FoodCategory category, List<Food> fullMenu) {
    return fullMenu.where((food) => food.category == category).toList();
  }

  // return list of foods in given category
  List<Widget> getFoodInThisCategory(List<Food> fullMenu) {
    return FoodCategory.values.map((Category) {
      List<Food> categoryMenu = _filterMenuByCategory(Category, fullMenu);
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 items per row
          crossAxisSpacing: 5.0, // Less space between columns
          mainAxisSpacing: 2.0, // Less space between rows
          childAspectRatio: 0.9, // Adjust card proportions
        ),
        itemCount: categoryMenu.length,
        itemBuilder: (context, index) {
          final food = categoryMenu[index];
          return MyFoodTile(
            food: food,
            ontap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FoodPage(food: food)),
            ),
          );
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySliverAppBar(
            title: MyTabBar(tabController: _tabController),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  indent: 25,
                  endIndent: 25,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                MyCurrentLocal(),
                const MyDescriptionBox(),
              ],
            ),
          ),
        ],
        body: Consumer<Restaurant>(
          builder: (context, restaurant, child) => TabBarView(
            controller: _tabController,
            children: getFoodInThisCategory(restaurant.menu),
          ),
        ),
      ),
    );
  }
}
