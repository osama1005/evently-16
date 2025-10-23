
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pro/routes.dart';
import 'package:pro/ui/common/AppFormFiled.dart';
import 'package:pro/ui/common/AppNameText.dart';
import 'package:pro/ui/common/validators.dart';
import 'package:pro/ui/desgin/design.dart';
import 'package:pro/ui/providers/AppAuthprovider.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController retypePasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 24,
              horizontal: 16),
          child: SingleChildScrollView(
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
                        controller: nameController,
                        label: "Name",
                        icon: Icons.person,
                        keyboardTybe: TextInputType.name,
                        validator: (text) {
                          if(text?.trim().isEmpty == true){
                            return "Please enter Name";
                          }
                        },
                      ),
                      Appformfiled(
                          controller: emailController,
                          label: "E-mail",
                          icon: Icons.mail,
                          keyboardTybe: TextInputType.emailAddress,
                          validator: (text) {
                            if(text?.trim().isEmpty == true){
                              return "Please enter email";
                            }
                            if(!isValidEmail(text!)){
                              return "Please enter valid email";
                            }
                          }
                      ),
                      Appformfiled(
                          controller: phoneController,
                          label: "phone",
                          icon: Icons.phone,
                          keyboardTybe: TextInputType.phone,
                          validator: (text) {
                            if(text?.trim().isEmpty == true){
                              return "Please enter phone";
                            }
                            if(!isValidPhone(text!)){
                              return "Please enter valid phone";
                            }
                          }
                      ),
                      Appformfiled(
                        controller: passwordController,
                        label: "Password",
                        icon: Icons.lock,
                        isPassword: true,
                        keyboardTybe: TextInputType.text,
                        validator: (text) {
                          if(text?.trim().isEmpty == true){
                            return "please enter password";
                          }
                          if((text?.length??0) < 6){
                            return "Password must be at least 6 characters";
                          }
                        },
                      ),
                      Appformfiled(
                        controller: retypePasswordController,
                        label: "Re-type Password",
                        icon: Icons.lock,
                        isPassword: true,
                        keyboardTybe: TextInputType.text,
                        validator: (text) {
                          if(text?.trim().isEmpty == true){
                            return "please enter password";
                          }
                          if(passwordController.text != text){
                            return "Password does not match";
                          }

                        },
                      ),
                      ElevatedButton(onPressed: isLoading ? null: (){
                        createAccount();
                      },
                          child: isLoading? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(width: 12,),
                              Text("Creating account")
                            ],
                          ):
                          Text("Create Account")),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already Have Account ? ",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.black
                            ),),
                          TextButton(onPressed: (){
                            Navigator.pushReplacementNamed(context, App_routes.LoginScreen.name);
                          },
                              child: Text("Login")
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

  void createAccount()async {
    if(validateForm() == false){
      return;
    }
    setState(() {
      isLoading = true;
    });
    AppAuthProvider provider = Provider.of<AppAuthProvider>(context, listen: false);
    AuthResponse response = await provider.register(emailController.text,
        passwordController.text,
        nameController.text, phoneController.text);
    if(response.success){
      // successfully created account
      // show dialog of success
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User Registered successfully"),));
      Navigator.pushReplacementNamed(context, App_routes.Homescreen.name);
    }else {
      // has error
      handleAuthError(response);
    }
    setState(() {
      isLoading = false;
    });
  }

  bool validateForm(){
    return formKey.currentState?.validate() ?? false;
  }

  void handleAuthError(AuthResponse response) {
    String errorMessage;

    switch(response.failure){
      case AuthFailure.weakPassword:
        errorMessage = "Weak password";
        break;
      case AuthFailure.emailAlreadyUsed:
        errorMessage = "Email already used";
        break;
      default:
        errorMessage = "something went wrong";
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage),));

  }
}