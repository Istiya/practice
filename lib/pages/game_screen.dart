import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice/game_manager.dart';
import 'package:practice/pages/player_screen.dart';
import 'package:practice/pages/rating_screen.dart';
import 'package:practice/widgets/enemy_widget.dart';
import 'package:practice/widgets/player_widget.dart';

import '../move_type.dart';
import '../widgets/custom_elevated_button.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: GameManager.init(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          Widget children;
          if (snapshot.hasData) {
            children = Scaffold(
                bottomNavigationBar: NavigationBar(
                  selectedIndex: _currentPageIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _currentPageIndex = index;
                    });
                  },
                  destinations: const [
                    NavigationDestination(
                        icon: Icon(Icons.local_fire_department),
                        label: 'Fight'),
                    NavigationDestination(
                        icon: Icon(Icons.man), label: 'Player'),
                    NavigationDestination(
                        icon: Icon(Icons.add_chart), label: 'Rating')
                  ],
                ),
                body: <Widget>[
                  Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      EnemyWidget(),
                      Wrap(
                        children: [
                          PlayerWidget(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      GameManager.turn(
                                          MoveType.quickAttack, context);
                                    });
                                  },
                                  text: 'Quick attack'),
                              CustomElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      GameManager.turn(
                                          MoveType.strongAttack, context);
                                    });
                                  },
                                  text: 'Strong attack'),
                            ],
                          ),
                          Center(
                            child: CustomElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    GameManager.turn(MoveType.defence, context);
                                  });
                                },
                                text: 'Defence'),
                          ),
                        ],
                      ),
                    ],
                  )),
                  PlayerScreen(user: FirebaseAuth.instance.currentUser!),
                  RatingPage(),
                ][_currentPageIndex]);
          } else if (snapshot.hasError) {
            children = const Center(
              child: Text("An error has occurred"),
            );
          } else {
            children = const Scaffold(
              body: Center(
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
          return children;
        });
  }
}
