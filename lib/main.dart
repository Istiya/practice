import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practice/firestore_db.dart';
import 'package:practice/game_manager.dart';
import 'package:practice/pages/create_account_screen.dart';
import 'package:practice/pages/game_screen.dart';

import 'firebase_options.dart';
import 'pages/entry_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FireStoreDB.init();
  User? user = FirebaseAuth.instance.currentUser;
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.lightBlueAccent,
    ),
    initialRoute: user != null ? 'game_screen' : '/',
    routes: {
      '/': (context) => const EntryScreen(),
      '/game_screen': (context) => const GameScreen(),
      '/create_account_screen': (context) => const CreateAccountScreen(),
    },
  ));
}
