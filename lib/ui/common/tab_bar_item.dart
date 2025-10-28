import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pro/extension/context_extension.dart';
class TabBarItem extends StatelessWidget {
 final String title ;
 final IconData icon ;
 final int index ;
 final int currentIndex ;
 bool reversedColors = false ;

    TabBarItem({super.key, required this.title, required this.icon,
     required this.index, required this.currentIndex,this.reversedColors=false});

  @override
  Widget build(BuildContext context) {
    var backgroundColors = reversedColors ? Colors.white : context.appColors.primary ;
    var contentColors = reversedColors ? context.appColors.primary:Colors.white ;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      decoration: BoxDecoration(
        color: currentIndex == index ? contentColors : backgroundColors ,
        border: Border.all(color: contentColors, width: 1),
        borderRadius: BorderRadius.circular(46),
      ),
      child: Row(
        children: [
          Icon(icon ,color:currentIndex == index
              ?  backgroundColors
              : contentColors,
            size:16 ,
          ),
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontFamily: GoogleFonts.inter().fontFamily,
              color:currentIndex == index
                  ?  backgroundColors
                  : contentColors,
            ),
          ),
        ],
      ),
    );
  }
}
