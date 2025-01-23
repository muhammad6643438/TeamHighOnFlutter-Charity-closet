// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:charity_closet/src/modules/authentication/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  // User? userglobal;
  Future<void> sendPasswordResetEmail(
      String email, BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  // Sign Up with Email and Password
  Future<UserModel?> signUpWithEmail({
    required String fullname,
    required String email,
    required String phoneNo,
    required String password,
    required String profileImage,
    required String fcmToken,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        // Save user data to Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'fullname': fullname,
          'email': email,
          'phoneNo': phoneNo,
          'profileImage': profileImage,
          'uid': user.uid,
          'role': 'user',
          'token': fcmToken,
        });

        // Save user data to Secure Storage
        var userData = UserModel(
          email: email,
          fullname: fullname,
          phoneNo: phoneNo,
          profileImage: profileImage,
          role: 'user',
          token: fcmToken,
          uid: user.uid,
        );
        print("user: $userData");
        await _secureStorage.write(
          key: 'user',
          value: jsonEncode(userData.toJson()),
        );
        return userData;
      }
    } catch (e) {
      print(Exception('Error during sign-up: $e'));
      rethrow;
    }
    return null;
  }

  // Login with Email and Password
  Future<UserModel?> loginWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        // Fetch user data from Firestore
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        UserModel? userModel;
        // Save user data to Secure Storage
        if (userDoc.exists) {
          Map<String, dynamic>? userData =
              userDoc.data() as Map<String, dynamic>?;
          if (userData != null) {
            userModel = UserModel(
              email: userData['email'],
              fullname: userData['fullname'],
              phoneNo: userData['phoneNo'],
              profileImage: userData['profileImage'],
              role: userData['role'],
              token: userData['token'],
              uid: userData['uid'],
            );
            print("user: $userModel");
            await _secureStorage.write(
              key: 'user',
              value: jsonEncode(userModel.toJson()),
            );
          }
        }
        return userModel;
      }
    } catch (e) {
      print(Exception('Error during login: $e'));
      rethrow;
    }
    return null;
  }

  // Sign In with Google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleAccount = await googleSignIn.signIn();

      if (googleAccount != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleAccount.authentication;

        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        User? user = userCredential.user;

        if (user != null) {
          // Save user data to Firestore if new user
          DocumentSnapshot userDoc =
              await _firestore.collection('users').doc(user.uid).get();
          if (!userDoc.exists) {
            await _firestore.collection('users').doc(user.uid).set({
              'fullname': user.displayName ?? '',
              'email': user.email ?? '',
              'phoneNo': '',
              'profileImage': user.photoURL ?? '',
              'uid': user.uid,
            });
          }

          // Save user data to Secure Storage
          await _secureStorage.write(key: 'uid', value: user.uid);
          await _secureStorage.write(
              key: 'fullname', value: user.displayName ?? '');
          await _secureStorage.write(key: 'email', value: user.email ?? '');
          await _secureStorage.write(key: 'phoneNo', value: '');
          await _secureStorage.write(
              key: 'profileImage', value: user.photoURL ?? '');

          return user;
        }
      }
    } catch (e) {
      throw Exception('Error during Google sign-in: $e');
    }
    return null;
  }

  // Add Data to Firestore
  Future<void> addData(String collection, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).add(data);
    } catch (e) {
      throw Exception('Error adding data: $e');
    }
  }

  // Update Data in Firestore
  Future<void> updateData(
      String collection, String docId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).doc(docId).update(data);
    } catch (e) {
      throw Exception('Error updating data: $e');
    }
  }

  // Delete Data from Firestore
  Future<void> deleteData(String collection, String docId) async {
    try {
      await _firestore.collection(collection).doc(docId).delete();
    } catch (e) {
      throw Exception('Error deleting data: $e');
    }
  }

  // Get Data from Firestore
  Future<List<Map<String, dynamic>>> getData(String collection) async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection(collection).get();
      return querySnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
