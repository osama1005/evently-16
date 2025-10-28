import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro/dataBase/category.dart';
import 'package:pro/extension/context_extension.dart';
import 'package:pro/ui/common/profile/profileScreen.dart';
import 'package:pro/ui/desgin/design.dart';
import 'package:pro/ui/home/favScreen.dart';
import 'package:pro/ui/home/home_tabs.dart';
import 'package:pro/ui/home/mapScreen.dart';
import 'package:pro/ui/providers/AppAuthprovider.dart';
import 'package:provider/provider.dart';
import 'package:pro/ui/common/Events_taps.dart';
import 'package:pro/routes.dart';

class Homescreen extends StatefulWidget {
  Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int currentTabIndex = 0;
  int currentBottmNav = 0;
  List<Widget> tabs = [
    HomeTabs(),
    Maps(),
    Favorites(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    AppAuthProvider provider = Provider.of<AppAuthProvider>(
      context,
      listen: true,
    );
    Size size = MediaQuery.of(context).size;
    var user = provider.getUser();
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: currentBottmNav == 0
            ? AppBar(
          actions: [
            IconButton(
              onPressed: () {
                provider.logout();
                Navigator.pushReplacementNamed(
                  context,
                  App_routes.LoginScreen.name,
                );
              },
              icon: Icon(Icons.logout, color: Colors.white),
            ),
          ],
          backgroundColor: context.appColors.primary,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (user?.name?.isEmpty == false) ...[
                Text(
                  "Welcome Back ✨",
                  style: context.fonts.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: GoogleFonts.inter().fontFamily,
                  ),
                ),
                Text(
                  user?.name ?? "",
                  style: context.fonts.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(App_icons.Vector),
                    SizedBox(width: 8),
                    Text(
                      "cairo",
                      style: context.fonts.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: GoogleFonts.inter().fontFamily,
                      ),
                    ),
                  ],
                ),
              ],
              CircularProgressIndicator(),
            ],
          ),
          toolbarHeight: 120,
        )
            : null,

        body: Column(
          children: [
            if (currentBottmNav == 0)
              Container(
                decoration: BoxDecoration(
                  color: context.appColors.primary,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: EventsTaps(
                  Category.getCategories(incluedAll: true),
                  currentTabIndex,
                      (index, category) {
                    setState(() {
                      currentTabIndex = index;
                    });
                  },
                ),
              ),
            Expanded(child: tabs[currentBottmNav]),
          ],
        ),
        bottomNavigationBar: Theme(
          data: ThemeData(useMaterial3: false),
          child: BottomAppBar(
            color: context.appColors.primary,
            shape: CircularNotchedRectangle(),
            notchMargin: 5,
            child: BottomNavigationBar(
              backgroundColor: context.appColors.primary,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              elevation: 0,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
              currentIndex: currentBottmNav,
              onTap: (index) {
                setState(() {
                  currentBottmNav = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(App_icons.home),
                  label: "",
                  activeIcon: SvgPicture.asset(App_icons.home_fill),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(App_icons.map),
                  label: "",
                  activeIcon: SvgPicture.asset(App_icons.map_fill),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(App_icons.love),
                  label: "",
                  activeIcon: SvgPicture.asset(App_icons.love_fill),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(App_icons.profile),
                  label: "",
                  activeIcon: SvgPicture.asset(App_icons.profile_fill),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(360),
            side: BorderSide(color: Colors.white, width: 4),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(App_routes.AddEventScreen.name);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
