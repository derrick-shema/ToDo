import 'package:flutter/material.dart';

import '../services/my_controller.dart';
import 'create_account_page.dart';
import 'home_page.dart';
import 'sign_in_account_page.dart';

class OpeningPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyController.isSignedIn() ? HomePage() :_openingPage(context);
  }

  Widget _openingPage(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TODO Create ElevatedButton for Create Account
            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateAccountPage()));
            }, child: Text('Create Account')),
            // TODO Create TextButton for Sign in
            TextButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignInAccountPage()));
            }, child: Text('Sign In'))

            ],
        ),
      ),
    );
  }
}
