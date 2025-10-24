import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pro/extension/context_extension.dart';
import 'package:pro/ui/common/tab_bar_item.dart';
import 'package:pro/ui/desgin/design.dart';
import 'package:pro/ui/home/home_tabs.dart';
import 'package:pro/ui/providers/AppAuthprovider.dart';
import 'package:provider/provider.dart';
import 'package:pro/routes.dart';

class Homescreen extends StatefulWidget {
  Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int currentTabIndex = 0;
  int currentBottmNav = 0 ;
  List <Widget> tabs = [
    HomeTabs(),
    HomeTabs(),
    HomeTabs(),
    HomeTabs(),

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
      length: 10,
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
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
            bottom: TabBar(
              tabAlignment: TabAlignment.start,
              padding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              indicatorColor: Colors.transparent,
              onTap: (index) {
                setState(() {
                  currentTabIndex = index;
                });
              },
              isScrollable: true,
              dividerColor: Colors.transparent,
              tabs: [
                TabBarItem(
                  title: "All",
                  icon: FontAwesome.compass,
                  index: 0,
                  currentIndex: currentTabIndex,
                ),

                TabBarItem(
                  title: "Sport",
                  icon: FontAwesome.bicycle_solid,
                  index: 1,
                  currentIndex: currentTabIndex,
                ),

                TabBarItem(
                  title: "Birthday",
                  icon: Icons.calendar_today,
                  index: 2,
                  currentIndex: currentTabIndex,
                ),

                TabBarItem(
                  title: "Eating",
                  icon: Icons.restaurant,
                  index: 3,
                  currentIndex: currentTabIndex,
                ),

                TabBarItem(
                  title: "Meeting",
                  icon: FontAwesome.handshake,
                  index: 4,
                  currentIndex: currentTabIndex,
                ),

                TabBarItem(
                  title: "BookClub",
                  icon: FontAwesome.lightbulb,
                  index: 5,
                  currentIndex: currentTabIndex,
                ),

                TabBarItem(
                  title: "Gaming",
                  icon: FontAwesome.playstation_brand,
                  index: 6,
                  currentIndex: currentTabIndex,
                ),

                TabBarItem(
                  title: "Holiday",
                  icon: FontAwesome.sun,
                  index: 7,
                  currentIndex: currentTabIndex,
                ),

                TabBarItem(
                  title: "Exhibition",
                  icon: FontAwesome.building,
                  index: 8,
                  currentIndex: currentTabIndex,
                ),

                TabBarItem(
                  title: "WorkShop",
                  icon: Icons.wordpress_outlined,
                  index: 9,
                  currentIndex: currentTabIndex,
                ),
              ],
            ),
          toolbarHeight: 120,
        ),
        body: tabs[currentBottmNav],
        bottomNavigationBar: Theme(
          data: ThemeData(useMaterial3: false),
          child: BottomAppBar(
            color: context.appColors.primary,
            shape: CircularNotchedRectangle(),
            notchMargin: 5,
            child: BottomNavigationBar(
              backgroundColor: context.appColors.primary ,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              elevation: 0,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
              currentIndex : currentBottmNav,
              onTap: (index){
                setState(() {
                  currentBottmNav = index;
                });
              },

              items: [
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(App_icons.home,),
                    label: "",
                activeIcon:SvgPicture.asset(App_icons.home_fill,),
                ),

                BottomNavigationBarItem(
                    icon: SvgPicture.asset(App_icons.map,),
                    label: "",
                  activeIcon:SvgPicture.asset(App_icons.map_fill,),
                ),

                BottomNavigationBarItem(
                    icon: SvgPicture.asset(App_icons.love,),
                    label: "",
                  activeIcon:SvgPicture.asset(App_icons.love_fill,),
                ),
                BottomNavigationBarItem(

                    icon: SvgPicture.asset(App_icons.profile,),
                    label: "",
                  activeIcon:SvgPicture.asset(App_icons.profile_fill,),
                ),
              ],
                  ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(360),
            side: BorderSide(color: Colors.white,width: 4)
          ),
        onPressed: (){},
          child: Icon(Icons.add),
      ),
      ),
    );
  }
}
