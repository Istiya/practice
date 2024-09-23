import 'dart:math';

import 'package:practice/entities/player.dart';

class Enemy {
  int attack;
  int health;
  int exp;
  String name;
  String description;

  Enemy(this.attack, this.health, this.exp, this.name, this.description);

  Enemy.fromPlayer(Player player)
      : attack = player.maxHealth - Random().nextInt(player.maxHealth),
        health = player.attack + Random().nextInt(player.attack),
        exp = ((player.maxHealth + player.attack) ~/ 10),
        name = 'Enemy',
        description = 'Very terrible enemy';

  static Enemy getNewEnemy() {
    return Enemy(3, 25, 2, "First enemy", "Very easy enemy");
  }
}
