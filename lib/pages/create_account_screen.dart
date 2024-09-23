import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice/entities/enemy.dart';
import 'package:practice/entities/player.dart';
import 'package:practice/entry_manager.dart';
import 'package:practice/firestore_db.dart';
import 'package:practice/widgets/custom_elevated_button.dart';

import '../widgets/entry_textfield.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  late final TextEditingController _nicknameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _passwordAgainController;

  @override
  void initState() {
    _nicknameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordAgainController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordAgainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            EntryTextField(
              hintText: 'Nickname',
              controller: _nicknameController,
            ),
            EntryTextField(
              hintText: "Email",
              controller: _emailController,
            ),
            EntryTextField(
              hintText: "Password",
              obscureText: true,
              controller: _passwordController,
            ),
            EntryTextField(
              hintText: "Password again",
              obscureText: true,
              controller: _passwordAgainController,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CustomElevatedButton(
                      onPressed: () async {
                        bool isResolved = await FireStoreDB.isNicknameResolved(
                            _nicknameController.text);
                        if (isResolved) {
                          _showToast(context, "Nickname is already taken");
                        } else {
                          User? user = await EntryManager.registerUsingEmailPassword(
                            nickname: _nicknameController.text,
                            emailAddress: _emailController.text,
                            password: _passwordController.text,
                            passwordAgain: _passwordAgainController.text,
                            context: this.context,
                          );
                          if (user != null) {
                            Navigator.pushNamed(context, '/game_screen');
                            FireStoreDB.setPlayerData(Player.getNewPlayer(_nicknameController.text));
                            FireStoreDB.setEnemyData(Enemy.getNewEnemy());
                          }
                        }
                      },
                      text: 'Sign up',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _showToast(BuildContext context, String toastText) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(toastText),
    ),
  );
}
