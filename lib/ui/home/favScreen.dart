

import 'package:flutter/material.dart';
import 'package:pro/dataBase/Event_Dao.dart';
import 'package:pro/dataBase/category.dart';
import 'package:pro/extension/context_extension.dart';
import 'package:pro/ui/home/event_card.dart';
import 'package:pro/ui/providers/AppAuthprovider.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
   @override


  @override
  Widget build(BuildContext context) {
    AppAuthProvider provider = Provider.of<AppAuthProvider>(
      context,
      listen: false,
    );
    return Column(
      children: [

        Expanded(
          child: FutureBuilder(
            future: EventDao.getFavoriteEvents(
               null,
              provider.getUser()?.favorites ?? [],
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("something went wrong"));
              }
              var events = snapshot.data;
              if ( events?.isEmpty == true||events == null ) {
                return Center(
                  child: Center(
                    child: Text(
                      "No events found",
                      style: context.fonts.titleLarge?.copyWith(
                        color: context.appColors.primary,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(12),
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    var event = events[index];
                    var isFavorite = provider.isFavorite(event);
                    events[index].isFavorite = isFavorite;
                    return EventCard(events[index]);
                  },
                  itemCount: events.length ?? 0,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}