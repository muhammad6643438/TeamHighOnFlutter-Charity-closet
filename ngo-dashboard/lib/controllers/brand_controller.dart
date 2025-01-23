import 'package:admin/constants.dart';
import 'package:admin/core/app_logger.dart';
import 'package:admin/core/app_prompts.dart';
import 'package:admin/core/services/firebase_service.dart';
import 'package:admin/models/brands_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final brandProvider = ChangeNotifierProvider<BrandProvider>(
  (ref) => BrandProvider(),
);

class BrandProvider extends ChangeNotifier {
  late BuildContext context;

  void init(BuildContext context) {
    this.context = context;
    fetchBrands();
  }

  TextEditingController brandName = TextEditingController();
  TextEditingController brandDesc = TextEditingController();

  bool get isPasswordVisible => _isPasswordVisible;

  bool _isPasswordVisible = true;

  void togglePassword() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void addBrand() {
    appPrint("Name: ${brandName.text}");
    appPrint("Description: ${brandDesc.text}");

    if (brandName.text.isNotEmpty && brandDesc.text.isNotEmpty) {
      _confirmAddBrand();
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

  Future<void> _confirmAddBrand() async {
    addLoader('addBrand');
    try {
      FirebaseService firebaseService = FirebaseService();
      await firebaseService.addData('brands', {
        'name': brandName.text,
        'desc': brandDesc.text,
      });
      brandName.clear();
      brandDesc.clear();
      removeLoader('addBrand');
      Prompts.showSnackBar(context, "Brand added successfully");
    } catch (e) {
      removeLoader('addBrand');
      Prompts.showSnackBar(context, "Error: $e");
      appPrint(e);
    } finally {
      removeLoader('addBrand');
    }
  }

  List<BrandsModel> brands = [];

  Future<void> fetchBrands() async {
    addLoader('fetchBrands');
    try {
      final data = await FirebaseService().getData('brands');
      List<Map<String, dynamic>> brands = [];
      brands = data.toList();
      this.brands = brands.map((e) => BrandsModel.fromJson(e)).toList();
      print(brands);
      removeLoader('fetchBrands');
      notifyListeners();
    } catch (e) {
      removeLoader('fetchBrands');
      appPrint("Error fetching Brands: $e");
    } finally {
      removeLoader('fetchBrands');
    }
  }

  updateBrand(id, name, desc) async {
    await FirebaseService().updateData('brands', id, {
      'name': name,
      'desc': desc,
    });
  }

  deleteBrand(id) async {
    await FirebaseService().deleteData('brands', id);
  }

  askUpdateBrand(name, desc, id) {
    final brandName = TextEditingController(
      text: name,
    );
    final brandDesc = TextEditingController(
      text: desc,
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bgColor,
          title: Text("Update Brand"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: brandName,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: brandDesc,
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
                Navigator.of(context).pop();
                await updateBrand(id, brandName.text, brandDesc.text);
              },
            ),
          ],
        );
      },
    );
  }

  askDeleteBrand(id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bgColor,
          title: Text("Delete Brand"),
          content: Text("Are you sure you want to delete this Brand?"),
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
                Navigator.of(context).pop();
                await deleteBrand(id);
              },
            ),
          ],
        );
      },
    );
  }
}
