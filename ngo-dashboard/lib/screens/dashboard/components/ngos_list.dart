import 'package:flutter/material.dart';

import '../../../constants.dart';

class NgoList extends StatefulWidget {
  const NgoList({
    Key? key,
  }) : super(key: key);

  @override
  State<NgoList> createState() => _NgoListState();
}

class _NgoListState extends State<NgoList> {
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
              // minWidth: 600,
              columns: [
                DataColumn(label: Text("Id")),
                DataColumn(label: Text("Name")),
                DataColumn(label: Text("Address")),
              ],
              rows: List.generate(
                5,
                (i) {
                  return DataRow(
                    cells: [
                      DataCell(Text("${i + 1}.")),
                      DataCell(Text("Al-Khidmat")),
                      DataCell(Text("Main University Road")),
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
