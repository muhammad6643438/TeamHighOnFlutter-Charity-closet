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

  // Sign Up with Email and Password
  Future<User?> signUpWithEmail({
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
        await _firestore.collection('users').doc(user.uid).set(
          {
            'fullname': fullname,
            'email': email,
            'phoneNo': phoneNo,
            'profileImage': profileImage,
            'uid': user.uid,
          },
        );

        // Save user data to Secure Storage
        await _secureStorage.write(key: 'uid', value: user.uid);
        await _secureStorage.write(key: 'fullname', value: fullname);
        await _secureStorage.write(key: 'email', value: email);
        await _secureStorage.write(key: 'phoneNo', value: phoneNo);
        await _secureStorage.write(key: 'profileImage', value: profileImage);

        return user;
      }
    } catch (e) {
      throw Exception('Error during sign-up: $e');
    }
    return null;
  }

  // Login with Email and Password
  // Future<User?> loginWithEmail(String email, String password) async {
  //   try {
  //     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );

  //     User? user = userCredential.user;

  //     if (user != null) {
  //       // Fetch user data from Firestore
  //       DocumentSnapshot userDoc =
  //           await _firestore.collection('users').doc(user.uid).get();

  //       // Save user data to Secure Storage
  //       if (userDoc.exists) {
  //         Map<String, dynamic>? userData =
  //             userDoc.data() as Map<String, dynamic>?;
  //         if (userData != null) {
  //           await _secureStorage.write(key: 'uid', value: userData['uid']);
  //           await _secureStorage.write(
  //               key: 'fullname', value: userData['fullname']);
  //           await _secureStorage.write(key: 'email', value: userData['email']);
  //           await _secureStorage.write(
  //               key: 'phoneNo', value: userData['phoneNo']);
  //           await _secureStorage.write(
  //               key: 'profileImage', value: userData['profileImage']);
  //         }
  //       }
  //       return user;
  //     }
  //   } catch (e) {
  //     throw Exception('Error during login: $e');
  //   }
  //   return null;
  // }

// Login with Email and Password
  Future<User?> loginWithEmail(
      String email, String password, BuildContext context) async {
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

        // Check if user role is admin
        if (userDoc.exists) {
          Map<String, dynamic>? userData =
              userDoc.data() as Map<String, dynamic>?;
          if (userData != null && userData['role'] == 'ngo') {
            // Save user data to Secure Storage
            await _secureStorage.write(key: 'uid', value: userData['uid']);
            await _secureStorage.write(
                key: 'fullname', value: userData['fullname']);
            await _secureStorage.write(key: 'email', value: userData['email']);
            await _secureStorage.write(
                key: 'phoneNo', value: userData['phoneNo']);
            await _secureStorage.write(
                key: 'profileImage', value: userData['profileImage']);
            return user;
          } else {
            // Show Snackbar if user is not an admin
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                      'You don\'t have permissions to login! contact admin.')),
            );
            return null; // Prevent login
          }
        }
      }
    } catch (e) {
      throw Exception('Error during login: $e');
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

  Stream<List<Map<String, dynamic>>> streamData(String collection) {
    try {
      return _firestore.collection(collection).snapshots().map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          // Remove the unnecessary cast if the data is already inferred as Map<String, dynamic>
          final data = doc.data();
          return {'id': doc.id, ...data};
        }).toList();
      });
    } catch (e) {
      throw Exception('Error streaming data: $e');
    }
  }

  // Get Data from Firestore
  Future getData(String collection) async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection(collection).get();
      return querySnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>});
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  // Get Data from Firestore
  Future<QuerySnapshot> getSnapshotData(String collection) async {
    try {
      return await _firestore.collection(collection).get();
    } catch (e) {
      print('Error getting data: $e');
      rethrow;
    }
  }

  // Get a single document from Firestore by its ID
  Future<Map<String, dynamic>?> getDocumentData(
      String collection, String docId) async {
    try {
      DocumentSnapshot docSnapshot =
          await _firestore.collection(collection).doc(docId).get();
      if (docSnapshot.exists) {
        return {
          'id': docSnapshot.id,
          ...docSnapshot.data() as Map<String, dynamic>
        };
      }
    } catch (e) {
      throw Exception('Error fetching document data: $e');
    }
    return null; // Return null if the document does not exist
  }
}
