import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pro/ui/desgin/design.dart';

class Event {
  String? id;
  String? creatorUserId;
  int? categoryId;
  String? image;
  String? title;
  String? description;
  DateTime? timeOfDay;
  DateTime? dateTime;
  bool isFavorite = false;
  LatLng? location;

  Event({
    this.id,
    this.title,
    this.categoryId,
    this.creatorUserId,
    this.timeOfDay,
    this.dateTime,
    this.image,
    this.description,
    this.location,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "categoryId": categoryId,
      "creatorUserId": creatorUserId,
      "image": image,
      "description": description,
      "timeOfDay": timeOfDay?.microsecondsSinceEpoch,
      "dateTime": dateTime?.microsecondsSinceEpoch,
      "lat": location?.latitude,
      "lng": location?.longitude,
    };
  }

  factory Event.fromMap(Map<String, dynamic>? map) {
    return Event(
      id: map?["id"],
      title: map?["title"],
      categoryId: map?["categoryId"],
      creatorUserId: map?["creatorUserId"],
      image: map?["image"],
      description: map?["description"],
      timeOfDay: DateTime.fromMicrosecondsSinceEpoch(map?["timeOfDay"]),
      dateTime: DateTime.fromMicrosecondsSinceEpoch(map?["dateTime"]),
      location: (map?["lat"] != null && map?["lng"] != null)
          ? LatLng((map?["lat"]).toDouble(), (map?["lng"]).toDouble())
          : null,
    );
  }

  String getCategoryImage() {
    switch (categoryId) {
      case 1:
        return App_icons.Sport;
      case 2:
        return App_icons.Birthday;
      case 3:
        return App_icons.Eating;
      case 4:

        return App_icons.Meeting;
    }
    return '';
  }
}


extension dateMonth on DateTime{

  String getShortMonthName(){

    const List<String> months = [
      "Jan","Feb","Mar","Apr","May","Jun",
      "Jul","Aug","Sep","Oct","Nov","Dec"
    ];
    return months[this.month-1];
  }

}