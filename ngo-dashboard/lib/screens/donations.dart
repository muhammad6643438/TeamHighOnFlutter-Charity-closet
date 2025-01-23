import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../controllers/donation_controller.dart';
import '../constants.dart';
import 'dashboard/components/header.dart';
import 'dashboard/components/my_fields.dart';

class Donations extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final node = ref.watch(donationProvider);
    node.init(context);
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(title: 'Donations'),
            // MyFiles(),
            SizedBox(height: defaultPadding * 2),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Donations List",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: defaultPadding),
                  Container(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width -
                              (2 * defaultPadding),
                        ),
                        child: DataTable(
                          columnSpacing: defaultPadding,
                          horizontalMargin: 0,
                          columns: [
                            DataColumn(label: Text("Date")),
                            DataColumn(label: Text("Clothing Type")),
                            DataColumn(label: Text("NGO")),
                            DataColumn(label: Text("Delivery")),
                            DataColumn(label: Text("Donor")),
                          ],
                          rows: node.donations.map((donation) {
                            return DataRow(
                              cells: [
                                DataCell(Text(
                                  donation.timestamp != null
                                      ? DateFormat('dd/MM/yyyy')
                                          .format(donation.timestamp!.toDate())
                                      : "-",
                                )),
                                DataCell(Text(donation.clothingOption ?? "-")),
                                DataCell(Text(donation.selectedNGO ?? "-")),
                                DataCell(Text(donation.deliveryMethod ?? "-")),
                                DataCell(
                                  Text(donation.hideName == true
                                      ? "Anonymous"
                                      : (donation.userEmail ?? "Anonymous")),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
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
