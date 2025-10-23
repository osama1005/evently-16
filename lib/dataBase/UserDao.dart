import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pro/dataBase/AppUser.dart';

class UserDao{
  static var _db = FirebaseFirestore.instance ;

  static CollectionReference<AppUser>_getUserCollection(){
    return _db.collection("user").withConverter(
      // convert from map to AppUser object
        fromFirestore:(snapshot,options){
          return AppUser.fromMap(snapshot.data());
        } ,
        // convert from AppUser object to map

        toFirestore:(user,options){
          return user.toMap();
        }
        );
  }

  static Future<void> addUser(AppUser user)async{
   var docReferen = _getUserCollection()
        .doc(user.id);
      await docReferen.set(user);
  }
  static Future<AppUser?> getUserById(String? uid)async{
    var doc = await _getUserCollection()
        .doc(uid)
        .get();
    return doc.data();

  }
}