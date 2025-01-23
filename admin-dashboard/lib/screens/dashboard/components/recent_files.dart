import 'package:admin/models/RecentFile.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class RecentFiles extends StatefulWidget {
  const RecentFiles({
    Key? key,
  }) : super(key: key);

  @override
  State<RecentFiles> createState() => _RecentFilesState();
}

class _RecentFilesState extends State<RecentFiles> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Donations/Disposals List",
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
              // minWidth: 600,
              columns: [
                DataColumn(label: Text("Id")),
                DataColumn(label: Text("Donator")),
                DataColumn(label: Text("Dontaion Type")),
                DataColumn(label: Text("Description")),
                DataColumn(label: Text("Status")),
              ],
              rows: List.generate(
                demoRecentFiles.length,
                (i) {
                  var fileInfo = demoRecentFiles[i];
                  return DataRow(
                    cells: [
                      DataCell(Text("${i + 1}.")),
                      DataCell(Text(fileInfo.donator ?? "Anonymous")),
                      DataCell(Text(fileInfo.type ?? "Donation")),
                      DataCell(Text(fileInfo.description ?? "2 shirts")),
                      DataCell(
                        DropdownButton<DonationStatus>(
                          value: fileInfo.status,
                          onChanged: (DonationStatus? newValue) {
                            setState(() {
                              fileInfo.status = newValue;
                            });
                          },
                          items: DonationStatus.values
                              .map((DonationStatus status) {
                            return DropdownMenuItem<DonationStatus>(
                              value: status,
                              child: Text(status.toString().split('.').last),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
