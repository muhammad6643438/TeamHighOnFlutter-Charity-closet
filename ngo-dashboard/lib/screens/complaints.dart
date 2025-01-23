import 'package:admin/controllers/complaint_controller.dart';
import 'package:admin/screens/dashboard/components/custom_button.dart';
import 'package:admin/screens/dashboard/components/my_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';

import '../constants.dart';
import 'dashboard/components/header.dart';

class Complaints extends ConsumerWidget {
  @override
  Widget build(context, ref) {
    final node = ref.watch(complaintProvider);
    node.init(context);
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(title: 'Complaints'),
            // MyFiles(),
            SizedBox(height: defaultPadding * 2),
            Container(
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Complaints List",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: defaultPadding),
                  SizedBox(
                    width: double.infinity,
                    child: DataTable(
                      columnSpacing: defaultPadding,
                      columns: [
                        DataColumn(label: Text("ID")),
                        DataColumn(label: Text("Date")),
                        DataColumn(label: Text("Title")),
                        DataColumn(label: Text("Description")),
                        DataColumn(label: Text("Name")),
                        DataColumn(label: Text("Status")),
                        DataColumn(label: Text("Action")),
                      ],
                      rows: node.complaints.map((complaint) {
                        return DataRow(
                          cells: [
                            DataCell(Text(
                                complaint.id?.toLowerCase().substring(0, 4) ??
                                    "")),
                            DataCell(
                              Text("12-02-25"),
                            ),
                            DataCell(Text(complaint.title ?? "")),
                            DataCell(Text(complaint.description ?? "")),
                            DataCell(Text(complaint.userName ?? "")),
                            DataCell(
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: complaint.status == 'Resolved'
                                      ? Colors.green.withOpacity(0.2)
                                      : Colors.orange.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  complaint.status ?? "Pending",
                                  style: TextStyle(
                                    color: complaint.status == 'Resolved'
                                        ? Colors.green
                                        : Colors.orange,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      node.showUpdateStatusDialog(
                                        complaint.id!,
                                        complaint.status ?? "Pending",
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
