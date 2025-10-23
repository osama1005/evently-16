import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pro/dataBase/AppUser.dart';
import 'package:pro/dataBase/UserDao.dart';

class AppAuthProvider extends ChangeNotifier {
  // save user in memory
  var _fbAuthUser = FirebaseAuth.instance.currentUser ;
  AppUser? _databaseUser ;

  AppUser? getUser(){
    return _databaseUser ;
  }
  AppAuthProvider() {
    retrieveUserFromDataBase();
  }
  void retrieveUserFromDataBase()async{
    if (_fbAuthUser != null) {
      _databaseUser = await UserDao.getUserById(_fbAuthUser!.uid);
      notifyListeners();
    }


  }
  void logout(){
    _fbAuthService.signOut();
    _fbAuthUser = null ;
    _databaseUser = null ;
    notifyListeners();
  }

  final FirebaseAuth _fbAuthService = FirebaseAuth.instance;

  bool isLoggded(){
    var user = FirebaseAuth.instance.currentUser ;
    if(user == null) {
      return false;
    }
    return true ;

  }

  ///  دالة التسجيل (Register)
  Future<AuthResponse> register(
      String email, String password, String name, String phone) async {
    try {
      // إنشاء حساب جديد
      final credential = await _fbAuthService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // إنشاء مستخدم في Firestore
      AppUser user = AppUser(
        id: credential.user?.uid,
        email: email,
        name: name,
        phone: phone,
      );

      await UserDao.addUser(user);
      _databaseUser = user ;
      _fbAuthUser = credential.user ;

      return AuthResponse(
        success: true,
        credential: credential,
        user: user,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == AuthFailure.emailAlreadyUsed.code) {
        return AuthResponse(
          success: false,
          failure: AuthFailure.emailAlreadyUsed,
        );
      }
      if (e.code == AuthFailure.weakPassword.code) {
        return AuthResponse(
          success: false,
          failure: AuthFailure.weakPassword,
        );
      }
      return AuthResponse(
        success: false,
        failure: AuthFailure.general,
      );
    } catch (e) {
      print("Register Error: $e");
      return AuthResponse(
        success: false,
        failure: AuthFailure.general,
      );
    }
  }

  ///  دالة تسجيل الدخول (Login)
  Future<AuthResponse> login(String email, String password) async {
    try {
      final credential = await _fbAuthService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // نحاول نجيب بيانات المستخدم من Firestore
      AppUser? userFromDb =
      await UserDao.getUserById(credential.user?.uid);

      return AuthResponse(
        success: true,
        credential: credential,
        user: userFromDb,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == AuthFailure.invalidCredential.code) {
        return AuthResponse(
          success: false,
          failure: AuthFailure.invalidCredential,
        );
      }
      return AuthResponse(
        success: false,
        failure: AuthFailure.general,
      );
    } catch (e) {
      print("Login Error: $e");
      return AuthResponse(
        success: false,
        failure: AuthFailure.general,
      );
    }
  }
}

///  كلاس نتيجة العمليات (نجاح أو فشل)
class AuthResponse {
  bool success;
  AuthFailure? failure;
  UserCredential? credential;
  AppUser? user;

  AuthResponse({
    required this.success,
    this.failure,
    this.credential,
    this.user,
  });
}

///  تعريف الأخطاء المعروفة من Firebase
enum AuthFailure {
  weakPassword('weak-password'),
  emailAlreadyUsed('email-already-in-use'),
  invalidCredential('invalid-credential'),
  general('something went wrong');

  final String code;
  const AuthFailure(this.code);
}
