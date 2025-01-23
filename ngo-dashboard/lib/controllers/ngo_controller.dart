import 'dart:convert';

import 'package:admin/constants.dart';
import 'package:admin/core/app_logger.dart';
import 'package:admin/core/app_prompts.dart';
import 'package:admin/core/services/firebase_service.dart';
import 'package:admin/models/ngos_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ngoProvider = ChangeNotifierProvider<NgoProvider>(
  (ref) => NgoProvider(),
);

class NgoProvider extends ChangeNotifier {
  late BuildContext context;

  void init(BuildContext context) {
    this.context = context;
    fetchNgos();
  }

  TextEditingController ngoName = TextEditingController();
  TextEditingController ngoDesc = TextEditingController();

  bool get isPasswordVisible => _isPasswordVisible;

  bool _isPasswordVisible = true;

  void togglePassword() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void addNgo() {
    appPrint("Email: ${ngoName.text}");
    appPrint("Password: ${ngoDesc.text}");

    if (ngoName.text.isNotEmpty && ngoDesc.text.isNotEmpty) {
      _confirmAddNgo();
    } else {
      Prompts.showSnackBar(context, "Name or Desc is empty");
    }
  }

  List<String> buffers = [];

  addLoader(String id) {
    buffers.add(id);
    notifyListeners();
  }

  removeLoader(String id) {
    buffers.remove(id);
    notifyListeners();
  }

  Future<void> _confirmAddNgo() async {
    addLoader('addNgo');
    try {
      FirebaseService firebaseService = FirebaseService();
      await firebaseService.addData('ngos', {
        'name': ngoName.text,
        'desc': ngoDesc.text,
      });
      ngoName.clear();
      ngoDesc.clear();
      removeLoader('addNgo');
      Prompts.showSnackBar(context, "NGO added successfully");
    } catch (e) {
      removeLoader('addNgo');
      Prompts.showSnackBar(context, "Error: $e");
      appPrint(e);
    } finally {
      removeLoader('addNgo');
    }
  }

  List<NgosModel> ngos = [];

  Future<void> fetchNgos() async {
    addLoader('fetchNgos');
    try {
      final data = await FirebaseService().getData('ngos');
      List<Map<String, dynamic>> ngos = [];
      ngos = data.toList();
      this.ngos = ngos.map((e) => NgosModel.fromJson(e)).toList();
      print(ngos);
      removeLoader('fetchNgos');
      notifyListeners();
    } catch (e) {
      removeLoader('fetchNgos');
      appPrint("Error fetching NGOs: $e");
    } finally {
      removeLoader('fetchNgos');
    }
  }

  updateNgo(id, name, desc) async {
    await FirebaseService().updateData('ngos', id, {
      'name': name,
      'desc': desc,
    });
  }

  deleteNgo(id) async {
    await FirebaseService().deleteData('ngos', id);
  }

  askUpdateNgo(name, desc, id) {
    final ngoName = TextEditingController(
      text: name,
    );
    final ngoDesc = TextEditingController(
      text: desc,
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bgColor,
          title: Text("Update NGO"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: ngoName,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: ngoDesc,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Update'),
              onPressed: () async {
                await updateNgo(id, ngoName.text, ngoDesc.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  askDeleteNgo(id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bgColor,
          title: Text("Delete NGO"),
          content: Text("Are you sure you want to delete this NGO?"),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () async {
                await deleteNgo(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
