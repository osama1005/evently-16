import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro/extension/context_extension.dart';
import 'package:pro/ui/desgin/design.dart';
import 'package:pro/ui/home/event_card.dart';
class HomeTabs extends StatelessWidget {
  const HomeTabs({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding:  EdgeInsets.all(16),
      child: Column(
        children: [
        Expanded(child: ListView.separated(
          itemCount: 10,
          separatorBuilder: (context, index)=>SizedBox(height: 16,),
          itemBuilder: (context, index)=>EventCard(),

        )
      )
        ],
      ),
    );
  }
}
