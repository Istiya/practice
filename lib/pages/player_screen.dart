import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice/entry_manager.dart';
import 'package:practice/game_manager.dart';
import 'package:practice/widgets/custom_elevated_button.dart';
import 'package:practice/widgets/rounded_widget.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key, required this.user});

  final User user;

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          RoundedWidget(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Nickname: ",
                    textScaler: TextScaler.linear(1.5),
                  ),
                  Text(GameManager.player.nickname.toString(),
                      textScaler: const TextScaler.linear(1.5))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Rating: ", textScaler: TextScaler.linear(1.5)),
                  Text(GameManager.player.rating.toStringAsFixed(2),
                      textScaler: const TextScaler.linear(1.5))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Attack: ", textScaler: TextScaler.linear(1.5)),
                  Text(GameManager.player.attack.toString(),
                      textScaler: const TextScaler.linear(1.5))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Current health: ",
                      textScaler: TextScaler.linear(1.5)),
                  Text(GameManager.player.currentHealth.toString(),
                      textScaler: const TextScaler.linear(1.5))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Max health: ",
                      textScaler: TextScaler.linear(1.5)),
                  Text(GameManager.player.maxHealth.toString(),
                      textScaler: const TextScaler.linear(1.5))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Experience: ",
                      textScaler: TextScaler.linear(1.5)),
                  Text(GameManager.player.exp.toString(),
                      textScaler: const TextScaler.linear(1.5))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Number of enemies defeated: ",
                      textScaler: TextScaler.linear(1.5)),
                  Text(GameManager.player.numberDefeatedEnemies.toString(),
                      textScaler: const TextScaler.linear(1.5))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Number of deaths: ",
                      textScaler: TextScaler.linear(1.5)),
                  Text(GameManager.player.numberDeaths.toString(),
                      textScaler: const TextScaler.linear(1.5))
                ],
              ),
            ],
          )),
          _currentUser.emailVerified == true
              ? const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Email verified'),
                )
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text('Email not verified'),
                      ),
                      CustomElevatedButton(
                          text: 'Verify',
                          onPressed: () async {
                            await _currentUser.sendEmailVerification();
                          }),
                    ],
                  ),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () async {
                    User? user = await EntryManager.refreshUser(_currentUser);

                    if (user != null) {
                      setState(() {
                        _currentUser = user;
                      });
                    }
                  },
                  icon: const Icon(Icons.refresh)),
              IconButton(
                  onPressed: () {
                    EntryManager.signOut();
                    Navigator.pushNamed(context, '/');
                  },
                  icon: const Icon(Icons.exit_to_app)),
            ],
          ),
        ]),
      ),
    );
  }
}
