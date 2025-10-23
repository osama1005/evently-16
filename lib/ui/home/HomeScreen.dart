import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro/ui/providers/AppAuthprovider.dart';
import 'package:provider/provider.dart';
import 'package:pro/routes.dart';


class Homescreen extends StatelessWidget {
   Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppAuthProvider provider = Provider.of<AppAuthProvider>(context,listen: true);
    var user = provider.getUser() ;

    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: (){
              provider.logout();
              Navigator.pushReplacementNamed(context, App_routes.LoginScreen.name);
            },
              child: Icon(Icons.logout,color: Colors.white,))
          
        ],
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Row(
          children: [
            user?.name?.isEmpty == false
            ? Text(user?.name??"",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white

            ),
            ):CircularProgressIndicator()
          ],
        ),
      ),

    );
  }
}
