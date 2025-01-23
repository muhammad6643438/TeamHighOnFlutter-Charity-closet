import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/user_controller.dart';
import '../constants.dart';
import 'dashboard/components/header.dart';
import 'dashboard/components/my_fields.dart';

class Users extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final node = ref.watch(userProvider);
    node.init(context);
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(title: 'Users'),
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
                    "Users List",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: defaultPadding),
                  Container(
                    width: double.infinity,
                    child: DataTable(
                      columnSpacing: 0,
                      horizontalMargin: 0,
                      columns: [
                        // DataColumn(label: Text("Profile")),
                        DataColumn(label: Text("Name")),
                        DataColumn(label: Text("Email")),
                        DataColumn(label: Text("Phone")),
                        DataColumn(label: Text("Role")),
                        DataColumn(label: Text("Action")),
                      ],
                      rows: node.users.map((user) {
                        return DataRow(
                          cells: [
                            // DataCell(
                            //   CircleAvatar(
                            //     radius: 20,
                            //     backgroundImage: user.profileImage != null
                            //         ? NetworkImage(user.profileImage!)
                            //         : null,
                            //     child: user.profileImage == null
                            //         ? Icon(Icons.person)
                            //         : null,
                            //   ),
                            // ),
                            DataCell(Text(user.fullName ?? "N/A")),
                            DataCell(Text(user.email ?? "N/A")),
                            DataCell(Text(user.phoneNo ?? "N/A")),
                            DataCell(
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: user.role == 'admin'
                                      ? Colors.purple.withOpacity(0.2)
                                      : Colors.blue.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  user.role ?? "user",
                                  style: TextStyle(
                                    color: user.role == 'admin'
                                        ? Colors.purple
                                        : Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              IconButton(
                                icon: Icon(Icons.visibility),
                                onPressed: () =>
                                    node.showUserDetailsDialog(user),
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
