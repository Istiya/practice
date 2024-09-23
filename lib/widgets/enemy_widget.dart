import 'package:flutter/material.dart';
import 'package:practice/game_manager.dart';
import 'package:practice/widgets/characteristic_widget.dart';
import 'package:practice/widgets/rounded_widget.dart';

class EnemyWidget extends StatefulWidget {
  const EnemyWidget({super.key});

  @override
  State<StatefulWidget> createState() => _EnemyWidget();
}

class _EnemyWidget extends State<EnemyWidget> {
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
                child: RoundedWidget(child: Text(GameManager.enemy.name)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                child:
                    RoundedWidget(child: Text(GameManager.enemy.description)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RoundedWidget(
                    child: CharacteristicWidget(
                        icon: Icons.local_fire_department,
                        value: GameManager.enemy.attack),
                  ),
                  RoundedWidget(
                    child: CharacteristicWidget(
                        icon: Icons.shield, value: GameManager.enemy.health),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (GameManager.lastEnemyMove != "")
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: RoundedWidget(child: Text(GameManager.lastEnemyMove)),
          ),
      ],
    );
  }
}
