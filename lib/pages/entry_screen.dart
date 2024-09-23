import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice/entry_manager.dart';
import 'package:practice/widgets/entry_textfield.dart';

import '../widgets/custom_elevated_button.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    FirebaseAuth.instance.signOut();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              EntryTextField(
                hintText: "Email",
                controller: _emailController,
              ),
              EntryTextField(
                hintText: "Password",
                obscureText: true,
                controller: _passwordController,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomElevatedButton(
                        onPressed: () async {
                          User? user = await EntryManager.signInUsingEmailPassword(
                              emailAddress: _emailController.text,
                              password: _passwordController.text,
                              context: this.context);
                          if(user != null){
                            Navigator.pushNamed(context, '/game_screen');
                          }
                        },
                        text: 'Sign in',
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, '/create_account_screen');
                        },
                        text: "Register",
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
