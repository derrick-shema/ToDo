import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/auth.dart';
import '../services/my_controller.dart';
import '../utils/string_validator.dart';
import 'home_page.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _pwController = TextEditingController();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Account')),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_errorMessage, style: const TextStyle(color: Colors.red),),
            // TODO insert email TextFormField
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email address'
              ),
             validator: (input) {
                return validateEmailAddress(input);
              },
              keyboardType: TextInputType.emailAddress,

            ),
            // TODO insert password TextFormField
            TextFormField(
              controller: _pwController,
              decoration: const InputDecoration(
                  labelText: 'Password'
              ),
              validator: (input) {
                return validatePassword(input);
              },
              obscureText: true,

            ),
            // TODO insert ElevatedButton to validate email & pw
            ElevatedButton(onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final errorCode = await Auth.createAccountWithEmailAndPassword(
                  email: _emailController.text,
                  password: _pwController.text,
                  );
                if (errorCode ==null ) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
                } else {
                  setState(() {
                    _errorMessage = errorCode;
                  });
                }
                //ScaffoldMessenger.of(context).showSnackBar(
                 // const SnackBar(content: Text('Processing data'))
               // );
              }
            }, child: Text('Submit'))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }
}
