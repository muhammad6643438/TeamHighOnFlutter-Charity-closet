// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:charity_closet/constants.dart';
import 'package:charity_closet/src/components/appointment_card.dart';
import 'package:charity_closet/src/components/custom_button.dart';
import 'package:charity_closet/src/core/utils/app_colors.dart';
import 'package:charity_closet/src/core/utils/app_extensions.dart';
import 'package:charity_closet/src/core/widgets/primary_textfield.dart';
import 'package:charity_closet/src/modules/dashboard/controllers/dashboad_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class ComplaintView extends StatefulHookConsumerWidget {
  const ComplaintView({super.key});

  @override
  ConsumerState<ComplaintView> createState() => _ComplaintViewState();
}

class _ComplaintViewState extends ConsumerState<ComplaintView> {
  String? selectedStatus;

  final TextEditingController date = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController name = TextEditingController();

  @override
  Widget build(context) {
    final controller = ref.watch(dashboardController);
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lodge Complaint'),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Consumer(
              builder: (_, ref, child) {
                return ListView(
                  children: [
                    // 20.ph,
                    // Row(
                    //   children: [
                    //     IconButton(
                    //       padding: const EdgeInsets.only(left: 0),
                    //       icon: const Icon(Icons.arrow_back),
                    //       onPressed: () {
                    //         Navigator.pop(context);
                    //       },
                    //     ),
                    //     Text(
                    //       "Complaints",
                    //       style: TextStyle(
                    //         fontSize: 22.sp,
                    //         fontWeight: FontWeight.w700,
                    //         color: Colors.black,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // const Divider(color: Colors.grey),
                    //  const SizedBox(height: 16),
                    const SizedBox(height: 16),
                    PrimaryTextfield(
                      hintText: 'Name',
                      controller: name,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Name is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    PrimaryTextfield(
                      hintText: 'Title',
                      controller: title,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Title is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    PrimaryTextfield(
                      hintText: 'Description',
                      controller: description,
                      maxLines: 3,
                      minLines: 1,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Description is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    // DropdownButtonFormField<String>(
                    //   dropdownColor: Colors.white,
                    //   decoration: const InputDecoration(
                    //     labelText: 'Select Status',
                    //     border: OutlineInputBorder(),
                    //   ),
                    //   value: selectedStatus,
                    //   items: const [
                    //     DropdownMenuItem(
                    //         value: 'pending', child: Text('Pending')),
                    //     DropdownMenuItem(
                    //         value: 'resolved', child: Text('Resolved')),
                    //   ],
                    //   onChanged: (value) {
                    //     setState(() {
                    //       selectedStatus = value;
                    //     });
                    //   },
                    //   validator: (p0) {
                    //     if (p0!.isEmpty) {
                    //       return 'Status is required';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    // const SizedBox(height: 16),
                    PrimaryTextfield(
                      hintText: 'Date',
                      readOnly: true,
                      isButtonSuffix: true,
                      suffixbutton: IconButton(
                        icon: const Icon(Icons.calendar_month_outlined),
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );

                          if (pickedDate != null) {
                            date.text =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            // auth.parsedDate = controller.text;
                            // debugPrint('Selected Date: ${auth.parsedDate}');
                          }
                        },
                      ),
                      controller: date,
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      isLoading: controller.isLoading,
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            controller.changeLoading(true);
                            await FirebaseFirestore.instance
                                .collection('complaints')
                                .add({
                              'createdAt': date.text,
                              'title': title.text,
                              'description': description.text,
                              'name': name.text,
                              'status': "pending",
                            });
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
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
                        }
                      },
                      title: 'Submit',
                      width: double.infinity,
                    ),
                    10.ph,
                    Text(
                      "My Lodged Complaints",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    10.ph,
                    // const Divider(color: Colors.grey),
                    ListView.separated(
                      itemCount: 1,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, i) {
                        return AppointmentCard(
                          onTap: () {
                            //  AppRouter.push(const AppointmentDetails());
                          },
                          title: 'Delay',
                          desc: 'Pickup pending for last 2 days',
                        );
                      },
                      separatorBuilder: (_, i) => 6.ph,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
