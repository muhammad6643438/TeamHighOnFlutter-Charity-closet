import 'package:admin/constants.dart';
import 'package:admin/core/app_prompts.dart';
import 'package:admin/core/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

final userProvider = ChangeNotifierProvider<UserProvider>(
  (ref) => UserProvider(),
);

class UserProvider extends ChangeNotifier {
  late BuildContext context;
  List<UserModel> users = [];
  List<String> buffers = [];

  void init(BuildContext context) {
    this.context = context;
    fetchUsers();
  }

  void addLoader(String key) {
    buffers.add(key);
    notifyListeners();
  }

  void removeLoader(String key) {
    buffers.remove(key);
    notifyListeners();
  }

  Future<void> fetchUsers() async {
    addLoader('fetchUsers');
    try {
      final querySnapshot = await FirebaseService().getSnapshotData('users');
      users = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['uid'] = doc.id;
        return UserModel.fromJson(data);
      }).toList();
      notifyListeners();
    } catch (e) {
      print("Error fetching users: $e");
    } finally {
      removeLoader('fetchUsers');
    }
  }

  Future<void> updateUserRole(String uid, String currentRole) async {
    // Toggle between 'admin' and 'user'
    String newRole = currentRole == 'admin' ? 'user' : 'admin';
    try {
      await FirebaseService().updateData('users', uid, {
        'role': newRole,
      });
      await fetchUsers();
      Navigator.of(context).pop();
      Prompts.showSnackBar(context,
          "User role updated to ${newRole.toUpperCase()} successfully");
    } catch (e) {
      Prompts.showSnackBar(context, "Error updating user role: $e");
      print("Error updating user role: $e");
    }
  }

  void showUserDetailsDialog(UserModel user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bgColor,
          title: Text("User Details"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (user.profileImage != null && user.profileImage!.isNotEmpty)
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(user.profileImage!),
                    ),
                  ),
                SizedBox(height: 20),
                DetailRow(title: "Name", value: user.fullName ?? "N/A"),
                DetailRow(title: "Email", value: user.email ?? "N/A"),
                DetailRow(title: "Phone", value: user.phoneNo ?? "N/A"),
                DetailRow(title: "UID", value: user.uid ?? "N/A"),
                DetailRow(title: "Role", value: user.role ?? "user"),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () =>
                      updateUserRole(user.uid!, user.role ?? 'user'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        user.role == 'admin' ? Colors.orange : Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child:
                      Text(user.role == 'admin' ? 'Make User' : 'Make Admin'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}

class DetailRow extends StatelessWidget {
  final String title;
  final String value;

  const DetailRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
