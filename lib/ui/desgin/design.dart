import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class App_colors {
 static const Color light_primary = Color(0xff5669FF);
 static const Color back_colors = Color(0xffF2FEFF);
 static const Color dark_back_colors = Color(0xff101127);
 static const Color gray = Color(0xFF7B7B7B);



}

class App_icons {

 static const String app_logo = "assets/icons/app_logo.png";
 static const String onBoarding1 = "assets/icons/onBoarding1.png";
 static const String ar = "assets/icons/ar.png";
 static const String en = "assets/icons/en.png";
 static const String icon_dark = "assets/icons/icon_dark.png";
 static const String icon_light = "assets/icons/icon_light.png";
}

class App_them {
 static var lightThem = ThemeData(
   appBarTheme: AppBarTheme(
       backgroundColor: App_colors.back_colors,
       surfaceTintColor: Colors.transparent,
       titleTextStyle: TextStyle(
         color: App_colors.light_primary,
         fontSize: 20,
         fontWeight: FontWeight.bold,
       ),
       centerTitle: true,
       iconTheme: IconThemeData(color: App_colors.light_primary,)
   ),
   colorScheme: ColorScheme.light(
       primary: App_colors.light_primary
   ),
   textTheme: TextTheme(
       bodyLarge: GoogleFonts.jockeyOne(
         color: Colors.white,
         fontSize: 20,
         fontWeight: FontWeight.bold,
       ),
       titleMedium: GoogleFonts.inter(
         fontSize: 20,
         fontWeight: FontWeight.w700,
         color:App_colors.light_primary,

       ),
       titleLarge: GoogleFonts.inter(
         fontSize: 24,
         fontWeight: FontWeight.bold,
         color: Colors.white,
       ),
       titleSmall: GoogleFonts.inter(
         fontSize: 14,
         fontWeight: FontWeight.bold,
         color: Colors.white,
       ),
       bodySmall: GoogleFonts.inter(
         fontSize: 14,
         fontWeight: FontWeight.bold,
         color: Colors.white,
       ),
       bodyMedium: GoogleFonts.inter(
         color: Colors.black,
         fontSize: 16,
         fontWeight: FontWeight.w500,
       )

   ),
   elevatedButtonTheme: ElevatedButtonThemeData(
       style: ElevatedButton.styleFrom(
           backgroundColor: App_colors.light_primary,
           padding: EdgeInsets.symmetric(vertical: 12),
           textStyle: GoogleFonts.inter(
               color: Colors.white,
               fontSize: 20,
               fontWeight: FontWeight.w500
           ),
           foregroundColor: Colors.white,
           shape:RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(12)
           )
       )

   ),
   bottomNavigationBarTheme: BottomNavigationBarThemeData(
       backgroundColor: App_colors.light_primary,
       selectedIconTheme: IconThemeData(
         color: Colors.white,
         size: 36,
       ),
       unselectedIconTheme: IconThemeData(
         color: Colors.black,
         size: 24,
       ),
       selectedLabelStyle: TextStyle(
         color: Colors.white,
       ),
       unselectedLabelStyle: TextStyle(
         color: Colors.black,
       )
   ),
   bottomAppBarTheme: BottomAppBarTheme(color: App_colors.light_primary),
   scaffoldBackgroundColor: App_colors.back_colors ,

     inputDecorationTheme: InputDecorationTheme(
       floatingLabelBehavior: FloatingLabelBehavior.auto,
       enabledBorder: OutlineInputBorder(
         borderRadius: BorderRadius.circular(16),
         borderSide: BorderSide(
             color: App_colors.light_primary,
             width:1


       ),
     ),
     border: OutlineInputBorder(
         borderRadius: BorderRadius.circular(16),
         borderSide: BorderSide(
             color: App_colors.gray,
             width:1

         ),
     ),
     labelStyle: GoogleFonts.inter(color:App_colors.gray,
     fontSize: 16,
       fontWeight: FontWeight.w500,
     ),
     hintStyle: GoogleFonts.inter(color:App_colors.gray,
       fontSize: 16,
       fontWeight: FontWeight.w500),
     contentPadding: EdgeInsets.all(16),

   )
 );
 static var darkTheme = ThemeData(
   appBarTheme: AppBarTheme(
       backgroundColor: App_colors.dark_back_colors,
       surfaceTintColor: Colors.transparent,
       titleTextStyle: TextStyle(
         color: App_colors.light_primary,
         fontSize: 20,
         fontWeight: FontWeight.bold,
       ),
       centerTitle: true,
       iconTheme: IconThemeData(color: App_colors.light_primary,)
   ),
   colorScheme: ColorScheme.light(
       primary: App_colors.light_primary
   ),
   textTheme: TextTheme(
       bodyLarge: GoogleFonts.jockeyOne(
         color: Colors.white,
         fontSize: 20,
         fontWeight: FontWeight.bold,
       ),
       titleMedium: GoogleFonts.inter(
         fontSize: 20,
         fontWeight: FontWeight.w700,
         color:App_colors.light_primary,

       ),
       titleLarge: GoogleFonts.inter(
         fontSize: 24,
         fontWeight: FontWeight.bold,
         color: Colors.white,
       ),
       titleSmall: GoogleFonts.inter(
         fontSize: 14,
         fontWeight: FontWeight.bold,
         color: Colors.white,
       ),
       bodySmall: GoogleFonts.inter(
         fontSize: 14,
         fontWeight: FontWeight.bold,
         color: Colors.white,
       ),
       bodyMedium: GoogleFonts.inter(
         color: Colors.white,
         fontSize: 16,
         fontWeight: FontWeight.w500,
       )

   ),
   elevatedButtonTheme: ElevatedButtonThemeData(
       style: ElevatedButton.styleFrom(
           backgroundColor: App_colors.light_primary,
           padding: EdgeInsets.symmetric(vertical: 12),
           textStyle: GoogleFonts.inter(
               color: Colors.white,
               fontSize: 20,
               fontWeight: FontWeight.w500
           ),
           shape:RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(12)
           )
       )

   ),
   bottomNavigationBarTheme: BottomNavigationBarThemeData(
       backgroundColor: App_colors.light_primary,
       selectedIconTheme: IconThemeData(
         color: Colors.white,
         size: 36,
       ),
       unselectedIconTheme: IconThemeData(
         color: Colors.black,
         size: 24,
       ),
       selectedLabelStyle: TextStyle(
         color: Colors.white,
       ),
       unselectedLabelStyle: TextStyle(
         color: Colors.black,
       )
   ),
   bottomAppBarTheme: BottomAppBarTheme(color: App_colors.light_primary),
   scaffoldBackgroundColor: App_colors.dark_back_colors ,
 );

}
