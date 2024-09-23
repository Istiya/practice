import 'package:flutter/material.dart';
import 'package:practice/game_manager.dart';
import 'package:practice/move_type.dart';
import 'package:practice/widgets/rounded_widget.dart';

import 'characteristic_widget.dart';
import 'custom_elevated_button.dart';

class PlayerWidget extends StatefulWidget {
  const PlayerWidget({super.key});

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RoundedWidget(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
              child: RoundedWidget(child: Text(GameManager.player.nickname)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RoundedWidget(
                  child: CharacteristicWidget(
                      icon: Icons.local_fire_department,
                      value: GameManager.player.attack),
                ),
                RoundedWidget(
                  child: CharacteristicWidget(
                      icon: Icons.shield,
                      value: GameManager.player.currentHealth),
                ),
              ],
            ),
          ],
        )),
      ],
    );
  }
}
