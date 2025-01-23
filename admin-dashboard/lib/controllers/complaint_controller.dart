import 'dart:convert';

import 'package:admin/constants.dart';
import 'package:admin/core/app_prompts.dart';
import 'package:admin/core/services/firebase_service.dart';
import 'package:admin/models/complaint_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final complaintProvider = ChangeNotifierProvider<ComplaintProvider>(
  (ref) => ComplaintProvider(),
);

class ComplaintProvider extends ChangeNotifier {
  late BuildContext context;
  List<ComplaintModel> complaints = [];
  List<String> buffers = [];

  void init(BuildContext context) {
    this.context = context;
    fetchComplaints();
  }

  void addLoader(String key) {
    buffers.add(key);
    notifyListeners();
  }

  void removeLoader(String key) {
    buffers.remove(key);
    notifyListeners();
  }

  Future<void> fetchComplaints() async {
    addLoader('fetchComplaints');
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseService().getSnapshotData('complaints');
      complaints = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return ComplaintModel.fromJson(data);
      }).toList();
      notifyListeners();
    } catch (e) {
      print("Error fetching complaints: $e");
    } finally {
      removeLoader('fetchComplaints');
    }
  }

  Future<void> updateComplaintStatus(String id, String status) async {
    try {
      Navigator.of(context).pop();
      await FirebaseService().updateData('complaints', id, {
        'status': status,
      });
      await fetchComplaints();
      Prompts.showSnackBar(context, "Status updated successfully");
    } catch (e) {
      Prompts.showSnackBar(context, "Error updating status: $e");
    }
  }

  void showUpdateStatusDialog(String id, String currentStatus) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bgColor,
          title: Text("Update Status"),
          content: Text(
              "Are you sure you want to ${currentStatus == 'Pending' ? 'complete' : 'reopen'} this complaint?"),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text(currentStatus == 'Pending'
                  ? 'Mark as Complete'
                  : 'Mark as Pending'),
              onPressed: () => updateComplaintStatus(
                  id, currentStatus == 'Pending' ? 'Resolved' : 'Pending'),
            ),
          ],
        );
      },
    );
  }
}
