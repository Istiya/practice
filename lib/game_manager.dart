import 'dart:math';

import 'package:flutter/material.dart';
import 'package:practice/entities/enemy.dart';
import 'package:practice/entities/player.dart';
import 'package:practice/firestore_db.dart';

import 'move_type.dart';

class GameManager {
  static late Player player;
  static late Enemy enemy;
  static String lastEnemyMove = "";

  static Future<String> init() async {
    enemy = await FireStoreDB.getEnemyData();
    player = await FireStoreDB.getPlayerData();
    return "Data downloaded";
  }

  static bool isEnemyDead() {
    return enemy.health <= 0 ? true : false;
  }

  static bool isPlayerDead() {
    return player.currentHealth <= 0 ? true : false;
  }

  static void createEnemy() {
    enemy = Enemy.fromPlayer(player);
  }

  static void levelUp() {
    int pp = player.exp ~/ 100;
    player.attack += pp;
    player.maxHealth += pp;
    player.exp = player.exp % 100;
  }

  static MoveType getEnemyMove() {
    MoveType moveType = MoveType.values[Random().nextInt(3)];
    switch (moveType) {
      case MoveType.quickAttack:
        lastEnemyMove = "Quick attack";
      case MoveType.strongAttack:
        lastEnemyMove = "Strong attack";
      case MoveType.defence:
        lastEnemyMove = "Defence";
    }
    return moveType;
  }

  static void moveComparison(MoveType playerMoveType) {
    switch (playerMoveType) {
      case MoveType.quickAttack:
        switch (getEnemyMove()) {
          case MoveType.quickAttack:
            player.currentHealth -= enemy.attack;
            enemy.health -= player.attack;
          case MoveType.strongAttack:
            enemy.health -= player.attack;
          case MoveType.defence:
            player.currentHealth -= enemy.attack ~/ 2;
        }
      case MoveType.strongAttack:
        switch (getEnemyMove()) {
          case MoveType.quickAttack:
            player.currentHealth -= enemy.attack;
          case MoveType.strongAttack:
            player.currentHealth -= enemy.attack;
            enemy.health -= player.attack;
          case MoveType.defence:
            enemy.health -= player.attack;
        }
      case MoveType.defence:
        switch (getEnemyMove()) {
          case MoveType.quickAttack:
            enemy.health -= (player.attack ~/ 2);
          case MoveType.strongAttack:
            player.currentHealth -= enemy.attack;
          case MoveType.defence:
            break;
        }
    }
  }

  static void turn(MoveType moveType, BuildContext context) {
    moveComparison(moveType);
    if (isPlayerDead()) {
      player.numberDeaths++;
      player.currentHealth = player.maxHealth;
      _showToast(context, "You died");
    }
    if (isEnemyDead()) {
      player.exp += enemy.exp;
      player.numberDefeatedEnemies++;
      levelUp();
      createEnemy();
      _showToast(context, "Enemy died");
    }
    if (player.numberDeaths != 0) {
      player.rating = (player.numberDefeatedEnemies) *
          (player.numberDefeatedEnemies / player.numberDeaths);
    } else {
      player.rating = (player.numberDefeatedEnemies) *
          (player.numberDefeatedEnemies / 1);
    }
    FireStoreDB.setPlayerData(player);
    FireStoreDB.setEnemyData(enemy);
  }

  static void _showToast(BuildContext context, String toastText) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(toastText),
      ),
    );
  }
}
