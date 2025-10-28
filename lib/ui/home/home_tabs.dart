import 'package:flutter/material.dart';
import 'package:pro/dataBase/Event_Dao.dart';
import 'package:pro/extension/context_extension.dart';
import 'package:pro/routes.dart';
import 'package:pro/ui/common/EventDetails/EventDetails.dart';
import 'package:pro/ui/desgin/design.dart';

import 'package:pro/ui/home/event_card.dart';
import 'package:pro/ui/providers/AppAuthprovider.dart';
import 'package:provider/provider.dart';
class HomeTabs extends StatelessWidget {
  const HomeTabs({super.key});

  @override
  Widget build(BuildContext context) {
    AppAuthProvider provider = Provider.of<AppAuthProvider>(
      context,
      listen: false,
    );
    return Padding(
      padding:  EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: EventDao.getRealTimeUpdateEvents(
                null,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("something went wrong"));
                }
                var events = snapshot.data;

                if (events == null || events.isEmpty == true) {
                  return Center(
                    child: Center(
                      child: Text(
                        "No events found",
                        style: context.fonts.titleLarge?.copyWith(
                          color: App_colors.light_primary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      var event = events[index];
                      var isFavorite = provider.isFavorite(event);
                      events[index].isFavorite = isFavorite;
                      return GestureDetector(onTap: () {
                        Navigator.pushNamed(context, App_routes.EventDetails.name,arguments: event);
                      },child: EventCard(events[index]));
                    },
                    itemCount: events.length,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
