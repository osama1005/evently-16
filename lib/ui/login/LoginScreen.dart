import 'package:pro/ui/common/AppFormFiled.dart';
import 'package:pro/ui/common/AppNameText.dart';
import 'package:pro/ui/common/validators.dart';
import 'package:pro/ui/desgin/design.dart';
import 'package:pro/ui/providers/AppAuthprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("login")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          children: [
            Image.asset(App_icons.app_logo),
            AppNameText(),

            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: [
                  Appformfiled(
                    controller: emailController,
                    label: "Email",
                    icon: Icons.email,
                    keyboardTybe: TextInputType.emailAddress,
                    validator: (text) {
                      if (text?.trim().isEmpty == true) {
                        return "please enter your email";
                      }
                      if (!isValidEmail(text!)) {
                        return "please enter valid email";
                      }
                    },
                  ),

                  Appformfiled(
                    controller: passwordController,
                    label: "Password",
                    icon: Icons.lock,
                    keyboardTybe: TextInputType.text,
                    isPassword: true,
                    validator: (text) {
                      if (text?.trim().isEmpty == true) {
                        return "please enter your Password";
                      }
                      if (text!.length < 6) {
                        return "please enter valid Password";
                      }
                    },
                  ),

                  ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            login();
                          },
                    child: isLoading
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(width: 12),
                              Text("Login you in"),
                            ],
                          )
                        : Text("sign in"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void login() async {
    if (validatForm() == false) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    Appauthprovider provider = Provider.of<Appauthprovider>(
      context,
      listen: false,
    );
    AuthResponse response = await provider.login(
      emailController.text,
      passwordController.text
    );
    if (response.success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("login in successfully")));
    } else {
      handleAuthError(response);
    }
    setState(() {
      isLoading = false;
    });
  }

  bool validatForm() {

    return formKey.currentState?.validate() ?? false;
  }

  void handleAuthError(AuthResponse response) {
    String errorMassage;
    switch (response.failure) {
      case AuthFailure.invalidCredential:
        errorMassage = "wrong email or password";
        break;


      default:
        errorMassage = "something went wrong";
        break;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(errorMassage)));
  }
}
