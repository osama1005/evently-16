import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class Category {
  int id;
  String title;
  IconData icon;

  Category({required this.id, required this.title, required this.icon});

  static List<Category> getCategories({bool incluedAll = true}) {
    List<Category> list = [];
    if (incluedAll) {
      list.add(Category(id: 0, title: "All", icon: FontAwesome.compass));

    }

    list.addAll([
      Category(id: 1, title: "Sport", icon: FontAwesome.bicycle_solid),

      Category(title: "Birthday", icon: Icons.calendar_today, id: 2),

      Category(title: "Eating", icon: Icons.restaurant, id: 3),

      Category(title: "Meeting", icon: FontAwesome.handshake, id: 4),
    ]);
    return list;
  }
}
