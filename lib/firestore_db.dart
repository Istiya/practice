import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practice/entities/enemy.dart';
import 'package:practice/entities/player.dart';

class FireStoreDB {
  static late FirebaseFirestore db;

  static void init() {
    db = FirebaseFirestore.instance;
  }

  static Future<void> setPlayerData(Player playerData) async {
    final player = <String, dynamic>{
      "nickname": playerData.nickname,
      "attack": playerData.attack,
      "currentHealth": playerData.currentHealth,
      "maxHealth": playerData.maxHealth,
      "exp": playerData.exp,
      "numberDefeatedEnemies": playerData.numberDefeatedEnemies,
      "rating": playerData.rating,
      "numberDeaths": playerData.numberDeaths,
    };

    await db
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(player);
  }

  static Future<Player> getPlayerData() async {
    Map<String, dynamic> data = await db
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((querySnapshot) => querySnapshot.data()!);

    return Player(
        data["attack"],
        data["currentHealth"],
        data["maxHealth"],
        data["exp"],
        data["numberDefeatedEnemies"],
        data["numberDeaths"],
        data["rating"],
        data["nickname"]);
  }

  static Future<void> setEnemyData(Enemy enemyData) async {
    final enemy = <String, dynamic>{
      "attack": enemyData.attack,
      "health": enemyData.health,
      "exp": enemyData.exp,
      "name": enemyData.name,
      "description": enemyData.description,
    };

    await db
        .collection("enemies")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(enemy);
  }

  static Future<Enemy> getEnemyData() async {
    Map<String, dynamic> data = await db
        .collection("enemies")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((querySnapshot) => querySnapshot.data()!);

    return Enemy(data["attack"], data["health"], data["exp"], data["name"],
        data["description"]);
  }

  static Future<bool> isNicknameResolved(String nickname) async {
    late bool resolved;
    await db
        .collection("users")
        .where("nickname", isEqualTo: nickname)
        .get()
        .then((querySnapshot) {
      resolved = querySnapshot.docs.isNotEmpty;
    });

    return resolved;
  }

  static Stream<QuerySnapshot> getAllUsers() {
    Stream<QuerySnapshot> usersStream =
        db.collection('users').orderBy('rating', descending: true).snapshots();
    return usersStream;
  }
}
