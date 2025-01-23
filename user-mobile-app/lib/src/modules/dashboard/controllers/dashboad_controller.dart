import 'package:charity_closet/src/core/utils/buffers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dashboardController = ChangeNotifierProvider.autoDispose(
  (ref) => DashboardController(),
);

class DashboardController extends ChangeNotifier with Buffers {
  DashboardController() {
    fetchNGONames();
  }

  bool isLoading = false;

  void changeLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  List<String> ngoNames = [];
  // Fetch NGO names from Firestore
  Future<void> fetchNGONames() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('ngos').get();
      ngoNames =
          querySnapshot.docs.map((doc) => doc['name'] as String).toList();
    } catch (e) {
      print('Error fetching NGO names: $e');
      ngoNames = [];
    }
  }
}
