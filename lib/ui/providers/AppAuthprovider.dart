import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pro/dataBase/AppUser.dart';
import 'package:pro/dataBase/UserDao.dart';

import '../../dataBase/Event.dart';

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

  bool isFavorite(Event event) {
    return _databaseUser?.favorites?.contains(event.id) ?? false;
  }

  void updateFavorites(List<String> favorites) async {
    _databaseUser?.favorites = favorites;
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

  static final GoogleSignIn _google = GoogleSignIn.instance;

  static bool _isInitialize = false;

  static Future<void> _intiGoogleSignIn() async {
    //initialize google signin --> identify app in google
    if (!_isInitialize) {
      await _google.initialize(
        serverClientId:
        '416790824993-6l0hchenq6q13lqqms4ejfpei21mj7df.apps.googleusercontent.com',
      );
      _isInitialize = true;
    }
  }

  Future<AuthResponse> signInWithGoogle() async {
    try {
      await _intiGoogleSignIn();


      GoogleSignInAccount account = await _google.authenticate();
      final idToken = account.authentication.idToken;
      final authClient = account.authorizationClient;
      final auth = await authClient.authorizationForScopes(['email', 'profile']);
      final accessToken = auth?.accessToken;

      // sign in to firebase
      final credential = GoogleAuthProvider.credential(
        idToken: idToken,
        accessToken: accessToken,
      );

      final userCredential = await _fbAuthService.signInWithCredential(credential);
      final fbUser = userCredential.user;

      if (fbUser == null) {
        return AuthResponse(success: false, failure: AuthFailure.general);
      }


      AppUser? existingUser = await UserDao.getUserById(fbUser.uid);

      if (existingUser == null) {

        AppUser newUser = AppUser(
          id: fbUser.uid,
          name: fbUser.displayName ?? '',
          email: fbUser.email ?? '',
          phone: fbUser.phoneNumber ?? '',

        );

        await UserDao.addUser(newUser);
        _databaseUser = newUser;
      } else {
        _databaseUser = existingUser;
      }


      _fbAuthUser = fbUser;
      notifyListeners();

      return AuthResponse(success: true, credential: userCredential, user: _databaseUser);

    } catch (e) {
      debugPrint("Error in Google Sign-In: $e");
      return AuthResponse(success: false, failure: AuthFailure.general);
    }
  }

  Future<AuthResponse> register(
      String email, String password, String name, String phone) async {
    try {

      final credential = await _fbAuthService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

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
