import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pro/dataBase/category.dart';
import 'package:pro/ui/common/tab_bar_item.dart';

typedef OnTapSelected = void Function(int index,Category category);

class EventsTaps extends StatelessWidget {
  List<Category> categoryies ;

  int currentTabIndex ;
  OnTapSelected onTapSelected;
  bool reversed = false ;

  EventsTaps(this.categoryies,this.currentTabIndex,this.onTapSelected,{this.reversed= false});


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categoryies.length,
      child: TabBar(
        tabAlignment: TabAlignment.start,
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
        indicatorColor: Colors.transparent,
        onTap: (index) {
        onTapSelected (index,categoryies[index]) ;
        },
        isScrollable: true,
        dividerColor: Colors.transparent,
        tabs:
        categoryies.map((Category){
          return  TabBarItem(
            reversedColors: reversed,
            title: Category.title,
            icon: Category.icon,
            index : categoryies.indexOf(Category),
            currentIndex: currentTabIndex,);

        },).toList()
      ),
    );
  }
}
