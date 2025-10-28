import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pro/dataBase/AppUser.dart';
import 'package:pro/dataBase/Event.dart';

class EventDao{
  static var _db = FirebaseFirestore.instance ;

  static CollectionReference<Event>_getEventsCollection(){
    return _db.collection("events").withConverter<Event>(
      // convert from map to AppUser object
        fromFirestore:(snapshot,options){
          return Event.fromMap(snapshot.data());
        } ,
        // convert from AppUser object to map

        toFirestore:(event,options){
          return event.toMap();
        }
    );
  }

  static Future<void> addEvent(Event event)async{
  var doc = _getEventsCollection()
       .doc();
    event.id = doc.id ;
  await doc.set(event);

  }
  static Future<void> deleteEvent(String eventId) async {
    var ref = _getEventsCollection();
    var doc = ref.doc(eventId);
    await doc.delete();
  }

  static Future<void> editEvent(Event event) async {
    var ref = _getEventsCollection();
    var doc = ref.doc(event.id);
    await doc.update(event.toMap());
  }
  static Future<List<Event>> getEvents(int? categoryId) async {
    Query<Event> query = _getEventsCollection();
    if (categoryId != null) {
      query = query.where("categoryId", isEqualTo: categoryId);
    }
    query = query
        .orderBy("dateTime", descending: false)
        .orderBy("timeOfDay", descending: false);

    var collectionRef = await query.get();
    return collectionRef.docs.map((snapShot) => snapShot.data()).toList();
  }

  static Future<List<Event>> getFavoriteEvents(
      int? categoryId,
      List<String> eventIds,
      ) async {
    if (eventIds.isEmpty) {
      return [];
    }
    Query<Event> query = _getEventsCollection().where(
      FieldPath.documentId,
      whereIn: eventIds,
    );
    if (categoryId != null) {
      query = query.where("categoryId", isEqualTo: categoryId);
    }
    query = query
        .orderBy("dateTime", descending: false)
        .orderBy("timeOfDay", descending: false);

    var collectionRef = await query.get();
    return collectionRef.docs.map((snapShot) => snapShot.data()).toList();
  }


  static Stream<List<Event>> getRealTimeUpdateEvents(int? categoryId) async* {
    Query<Event> query = _getEventsCollection();

    if (categoryId != null) {
      query = query.where("categoryId", isEqualTo: categoryId);
    }

    query = query
        .orderBy("dateTime", descending: false)
        .orderBy("timeOfDay", descending: false);

    var collectionRef = query.snapshots();

    yield* collectionRef.map(
          (snapShot) => snapShot.docs.map((snapShot) => snapShot.data()).toList(),
    );
  }



}