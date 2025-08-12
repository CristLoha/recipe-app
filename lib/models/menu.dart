import 'package:recipe_app/utils/app_assets.dart';

enum Category { Food, Drink }

class Menu {
  final String imageUser;
  final String userName;
  final String imageMenu;
  final String nameMenu;
  final Category category;
  final int duration;

  Menu({
    required this.imageUser,
    required this.userName,
    required this.imageMenu,
    required this.nameMenu,
    required this.category,
    required this.duration,
  });
}

final menuLeft = [
  Menu(
    userName: "Calumn Lewis",
    imageUser: AppImages.person1,
    imageMenu: AppImages.menu1,
    nameMenu: "Pancake",
    category: Category.Food,
    duration: 60,
  ),
  Menu(
    userName: "Elif Sonas",
    imageUser: AppImages.person2,
    imageMenu: AppImages.menu2,
    nameMenu: "Salad",
    category: Category.Food,
    duration: 60,
  ),
  Menu(
    userName: "Elena Selhby",
    imageUser: AppImages.person3,
    imageMenu: AppImages.menu3,
    nameMenu: "Pancake",
    category: Category.Food,
    duration: 60,
  ),
];
