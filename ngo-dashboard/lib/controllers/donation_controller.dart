import 'package:admin/constants.dart';
import 'package:admin/controllers/user_controller.dart';
import 'package:admin/core/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../models/donation_model.dart';

final donationProvider = ChangeNotifierProvider<DonationProvider>(
  (ref) => DonationProvider(),
);

class DonationProvider extends ChangeNotifier {
  late BuildContext context;
  List<DonationModel> donations = [];
  List<String> buffers = [];

  void init(BuildContext context) {
    this.context = context;
    fetchDonations();
  }

  void addLoader(String key) {
    buffers.add(key);
    notifyListeners();
  }

  void removeLoader(String key) {
    buffers.remove(key);
    notifyListeners();
  }

  Future<void> fetchDonations() async {
    addLoader('fetchDonations');
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseService().getSnapshotData('donations');
      donations = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return DonationModel.fromJson(data);
      }).toList();

      // Sort donations by timestamp (newest first)
      donations.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));

      notifyListeners();
    } catch (e) {
      print("Error fetching donations: $e");
    } finally {
      removeLoader('fetchDonations');
    }
  }

  void showDonationDetailsDialog(DonationModel donation) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bgColor,
          title: Text("Donation Details"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                DetailRow(
                    title: "Clothing Type",
                    value: donation.clothingOption ?? "N/A"),
                DetailRow(title: "NGO", value: donation.selectedNGO ?? "N/A"),
                DetailRow(
                    title: "Delivery Method",
                    value: donation.deliveryMethod ?? "N/A"),
                DetailRow(
                    title: "Description", value: donation.description ?? "N/A"),
                DetailRow(
                    title: "Anonymous",
                    value: donation.hideName == true ? "Yes" : "No"),
                DetailRow(title: "Address", value: donation.address ?? "N/A"),
                DetailRow(
                    title: "Donor Email", value: donation.userEmail ?? "N/A"),
                DetailRow(
                    title: "Date",
                    value: donation.timestamp != null
                        ? DateFormat('dd/MM/yyyy HH:mm')
                            .format(donation.timestamp!.toDate())
                        : "N/A"),
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
