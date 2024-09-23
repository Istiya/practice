import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:practice/firestore_db.dart';

class EntryManager {
  static Future<User?> registerUsingEmailPassword({
    required String nickname,
    required String emailAddress,
    required String password,
    required String passwordAgain,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (password != passwordAgain) {
      _showToast(context, 'Password mismatch.');
    } else {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress,
          password: password,
        );

        user = credential.user;
        await user?.reload();
        user = auth.currentUser;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          _showToast(context, 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          _showToast(context, 'The account already exists for that email.');
        } else if (e.code == 'invalid-email') {
          _showToast(context, 'Invalid email.');
        }
      }
    }

    return user;
  }

  static Future<User?> signInUsingEmailPassword(
      {required String emailAddress,
      required String password,
      required BuildContext context}) async {
    User? user;

    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      user = credential.user;
    } on FirebaseAuthException catch (e) {
      _showToast(context, 'Wrong email or password.');
    }

    return user;
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<User?> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await user.reload();
    User? refreshedUser = auth.currentUser;

    return refreshedUser;
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
