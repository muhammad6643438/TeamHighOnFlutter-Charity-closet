import 'package:admin/controllers/ngo_controller.dart';
import 'package:admin/screens/dashboard/components/custom_button.dart';
import 'package:admin/screens/dashboard/components/my_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants.dart';
import 'dashboard/components/header.dart';

class Ngo extends ConsumerWidget {
  @override
  Widget build(context, ref) {
    final node = ref.watch(ngoProvider);
    node.init(context);
    final Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(title: 'NGOs'),
            MyFiles(),
            SizedBox(height: defaultPadding * 3),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: OrderTextField(
                    title: 'NGO Name',
                    controller: node.ngoName,
                  ),
                ),
                SizedBox(width: defaultPadding),
                Expanded(
                  flex: 3,
                  child: OrderTextField(
                    title: 'NGO Address',
                    controller: node.ngoDesc,
                  ),
                ),
                SizedBox(width: defaultPadding),
                SizedBox(
                  width: MediaQuery.of(context).size.width < 800
                      ? double.infinity
                      : _size.width < 1200
                          ? 200
                          : 250,
                  child: CustomButton(
                    title: 'Add NGO',
                    loading: node.buffers.contains('addNgo'),
                    onPressed: () => node.addNgo(),
                  ),
                ),
              ],
            ),
            SizedBox(height: defaultPadding * 2),
            Divider(color: Colors.white38),
            SizedBox(height: defaultPadding),
            Container(
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, i) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "NGO's List",
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
                            DataColumn(label: Text("Id")),
                            DataColumn(label: Text("Name")),
                            DataColumn(label: Text("Address")),
                            DataColumn(label: Text("Action")),
                          ],
                          rows: node.ngos.map((ngo) {
                            return DataRow(
                              cells: [
                                DataCell(Text(ngo.id ?? "")),
                                DataCell(Text(ngo.name ?? "Anonymous")),
                                DataCell(Text(ngo.desc ?? "-")),
                                DataCell(
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          node.askUpdateNgo(
                                            ngo.name ?? "",
                                            ngo.desc ?? "",
                                            ngo.id ?? "",
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          node.askDeleteNgo(ngo.id!);
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
