// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:charity_closet/constants.dart';
import 'package:charity_closet/src/components/appointment_card.dart';
import 'package:charity_closet/src/components/custom_button.dart';
import 'package:charity_closet/src/components/info_card.dart';
import 'package:charity_closet/src/core/utils/app_assets.dart';
import 'package:charity_closet/src/core/utils/app_colors.dart';
import 'package:charity_closet/src/core/utils/app_extensions.dart';
import 'package:charity_closet/src/core/widgets/primary_textfield.dart';
import 'package:charity_closet/src/modules/authentication/controllers/auth_controller.dart';
import 'package:charity_closet/src/modules/dashboard/controllers/dashboad_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DonationBottomSheet extends ConsumerStatefulWidget {
  const DonationBottomSheet({super.key});

  @override
  ConsumerState<DonationBottomSheet> createState() =>
      _DonationBottomSheetState();
}

class _DonationBottomSheetState extends ConsumerState<DonationBottomSheet> {
  String? clothingOption;
  String? selectedNGO;
  String? deliveryMethod;
  bool hideName = false;
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(dashboardController);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Donate/ Dispose Clothes'),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Center(
              //   child: Container(
              //     width: 40,
              //     height: 4,
              //     margin: const EdgeInsets.only(bottom: 16),
              //     decoration: BoxDecoration(
              //       color: Colors.grey[300],
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //   ),
              // ),
              // Text(
              //   'Donate or Dispose Clothes',
              //   style: Theme.of(context).textTheme.titleLarge,
              // ),
              // const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Hide my name'),
                  Switch(
                    activeColor: primaryColor,
                    value: hideName,
                    onChanged: (value) {
                      setState(() {
                        hideName = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                decoration: const InputDecoration(
                  labelText: 'Select Action',
                  border: OutlineInputBorder(),
                ),
                value: clothingOption,
                items: const [
                  DropdownMenuItem(value: 'Donate', child: Text('Donate')),
                  DropdownMenuItem(value: 'Dispose', child: Text('Dispose')),
                ],
                onChanged: (value) {
                  setState(() {
                    clothingOption = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                decoration: const InputDecoration(
                  labelText: 'Select NGO',
                  border: OutlineInputBorder(),
                ),
                value: selectedNGO,
                items: controller.ngoNames.map((name) {
                  return DropdownMenuItem(
                    value: name,
                    child: Text(name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedNGO = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                decoration: const InputDecoration(
                  labelText: 'Delivery Method',
                  border: OutlineInputBorder(),
                ),
                value: deliveryMethod,
                items: const [
                  DropdownMenuItem(value: 'Pickup', child: Text('Pickup')),
                  DropdownMenuItem(value: 'Drop-off', child: Text('Drop-off')),
                ],
                onChanged: (value) {
                  setState(() {
                    deliveryMethod = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              PrimaryTextfield(
                hintText: 'Address',
                controller: addressController,
              ),
              const SizedBox(height: 16),
              PrimaryTextfield(
                hintText: 'Description',
                controller: descriptionController,
                maxLines: 3,
                minLines: 1,
              ),
              const SizedBox(height: 16),
              CustomButton(
                isLoading: controller.isLoading,
                onPressed: () async {
                  final user = FirebaseAuth.instance.currentUser;
                  final userEmail = user?.email ?? 'anonymous';

                  try {
                    controller.changeLoading(true);
                    await FirebaseFirestore.instance
                        .collection('donations')
                        .add({
                      'clothingOption': clothingOption,
                      'selectedNGO': selectedNGO,
                      'deliveryMethod': deliveryMethod,
                      'description': descriptionController.text,
                      'hideName': hideName,
                      'address': addressController.text,
                      'userEmail': userEmail,
                      'timestamp': FieldValue.serverTimestamp(),
                      'status': 'pending',
                    });

                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('submit successfully!'),
                      duration: Duration(
                        seconds: 3,
                      ),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: AppColors.inactiveGray,
                    ));

                    print('Data saved successfully');
                  } catch (e) {
                    print('Error saving data: $e');
                  } finally {
                    controller.changeLoading(false);
                  }

                  print('Clothing Option: $clothingOption');
                  print('Selected NGO: $selectedNGO');
                  print('Delivery Method: $deliveryMethod');
                  print('Description: ${descriptionController.text}');
                  print('Hide Name: $hideName');
                  print('Address: ${addressController.text}');
                  print('User Email: $userEmail');
                },
                title: 'Submit',
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
