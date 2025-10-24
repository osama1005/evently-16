import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro/extension/context_extension.dart';
import 'package:pro/ui/desgin/design.dart';
class EventCard extends StatelessWidget {
  const EventCard({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return   Container(
        padding: EdgeInsets.all(8),
        width: double.infinity,
        height: size.height *.25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: context.appColors.primary,width: 1),
          image: DecorationImage(image:AssetImage(App_icons.sport),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text("21",style: context.fonts.bodyMedium?.copyWith(
                    fontFamily:GoogleFonts.inter().fontFamily ,
                    fontWeight: FontWeight.bold,
                    color: context.appColors.primary,
                  ),

                  ),
                  Text("Nov",style: context.fonts.bodyMedium?.copyWith(
                    fontFamily:GoogleFonts.inter().fontFamily ,
                    fontWeight: FontWeight.bold,
                    color: context.appColors.primary,
                  ),
                  ),

                ],
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(" this is the sport",style: context.fonts.bodyMedium?.copyWith(
                      fontFamily:GoogleFonts.inter().fontFamily ,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
                  InkWell(
                      onTap: (){},
                      child: Icon(Icons.favorite))

                ],
              ),
            )

          ],

        )
    );
  }
}
