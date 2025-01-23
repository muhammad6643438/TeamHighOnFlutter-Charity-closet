// ignore_for_file: non_constant_identifier_names

import 'package:admin/controllers/user_onboarding_controller.dart';
import 'package:admin/core/app_router.dart';
import 'package:admin/core/app_validators.dart';
import 'package:admin/models/controller_model.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/custom_button.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants.dart';
import 'dashboard/components/header.dart';

class RegisterUserScreen extends ConsumerWidget {
  @override
  Widget build(_, ref) {
    RegisterUserController reg = ref.watch(registerUserViewModel);
    reg.init(_);
    final Size size = MediaQuery.of(_).size;
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RegisterForm(
                width: AppSize.isMobile(_) ? size.width : size.width / 3,
                vehiclesNo: reg.vehiclesNo,
                onAdd: () => reg.add,
                onRemove: () => reg.remove,
                count: reg.count,
                onCreateUserAccount: () => reg.createUserAccount,
                name: reg.name,
                cnic: reg.cnic,
                phone: reg.phone,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  final TextEditingController? name, cnic, phone;
  final List<Controllers> vehiclesNo;
  final VoidCallback onAdd, onRemove, onCreateUserAccount;
  final int count;
  final double? width;

  const RegisterForm({
    Key? key,
    this.width,
    required this.onAdd,
    required this.onRemove,
    required this.count,
    this.name,
    this.cnic,
    this.phone,
    required this.onCreateUserAccount,
    required this.vehiclesNo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width ?? double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Register User", style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: defaultPadding),
          SearchField(
            title: 'Name',
            validator: AppValidator.validateName,
            controller: name,
          ),
          SizedBox(height: defaultPadding),
          SearchField(
            title: 'CNIC',
            validator: AppValidator.validateCNIC,
            controller: cnic,
          ),
          SizedBox(height: defaultPadding),
          SearchField(
            title: 'Phone',
            validator: AppValidator.validatePhone,
            controller: phone,
            isLast: true,
          ),
          SizedBox(height: defaultPadding),
          Text(
            "Number of vehicles",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(height: defaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(CupertinoIcons.minus_circle_fill),
                onPressed: onRemove,
              ),
              SizedBox(width: defaultPadding),
              Text(
                "$count",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(width: defaultPadding),
              IconButton(
                icon: Icon(CupertinoIcons.add_circled_solid),
                onPressed: onAdd,
              ),
            ],
          ),
          SizedBox(height: defaultPadding),
          ListView.builder(
            shrinkWrap: true,
            itemCount: vehiclesNo.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) => SearchField(
              title: 'Vehicle ${index + 1}',
              controller: vehiclesNo[index].vehicleNo,
              // validator: AppValidator.validateVehicle,
            ),
          ),
          SizedBox(height: defaultPadding),
          CustomButton(
            title: 'Login',
            onPressed: onCreateUserAccount,
          ),
        ],
      ),
    );
  }
}
