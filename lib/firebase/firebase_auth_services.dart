import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password, String firstName, String lastName) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await credential.user?.updateDisplayName(firstName + " " + lastName);
      return credential.user;
    } catch (e) {
      print("An error has occured" + e.toString());
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      } else if (e.code == 'invalid-email') {
        print('Invalid login credentials. Check your email and password.');
      } else {
        print('Error during authentication: ${e.message}');
      }
    } on PlatformException catch (e) {
      print('PlatformException: ${e.code}, ${e.message}');
      print('Unexpected error occurred. Please try again later.');
    } catch (e) {
      print('Unexpected error: $e');
    }

    return user;
  }

  // Future<User?> signInWithEmailAndPassword(
  //     String email, String password) async {
  //   User? user;
  //   try {
  //     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     User? user = userCredential.user;
  //     return user;
  //   } on FirebaseAuthException catch (e) {
  //     print(e.code);
  //     if (e.code == 'user-not-found') {
  //       print("No user found for this email");
  //       return null;
  //     }
  //   }
  //   return user;
  // }
}
