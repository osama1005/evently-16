import 'package:pro/routes.dart';
import 'package:pro/ui/common/AppFormFiled.dart';
import 'package:pro/ui/common/AppNameText.dart';
import 'package:pro/ui/common/validators.dart';
import 'package:pro/ui/desgin/design.dart';
import 'package:pro/ui/login/Logingoogle.dart';
import 'package:pro/ui/providers/AppAuthprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../common/Language_switch.dart';

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
    var l10n = AppLocalizations.of(context)!;
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
                  SizedBox(height: 24,),

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't Have Account ? ",
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            App_routes.RegisterScreen.name,
                          );
                        },
                        child: Text("create account"),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            width: double.infinity,
                            color: App_colors.light_primary,
                          ),
                        ),
                        Text(
                          l10n.or,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: App_colors.light_primary),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            width: double.infinity,
                            color: App_colors.light_primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Logingoogle(),
                  SizedBox(height: 24,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [LanguageSwitch()],
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
    AppAuthProvider provider = Provider.of<AppAuthProvider>(
      context,
      listen: false,
    );
    AuthResponse response = await provider.login(
      emailController.text,
      passwordController.text,
    );
    if (response.success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("login in successfully")));
      Navigator.pushReplacementNamed(context, App_routes.Homescreen.name);
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
