import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pro/extension/context_extension.dart';
class TabBarItem extends StatelessWidget {
 final String title ;
 final IconData icon ;
 final int index ;
 final int currentIndex ;

   const TabBarItem({super.key, required this.title, required this.icon,
     required this.index, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      decoration: BoxDecoration(
        color: currentIndex == index ? Colors.white : Colors.transparent,
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(46),
      ),
      child: Row(
        children: [
          Icon(icon ,color:currentIndex == index ? context.appColors.primary : Colors.white,
          ),
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontFamily: GoogleFonts.inter().fontFamily,
              color:currentIndex == index ? context.appColors.primary : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
