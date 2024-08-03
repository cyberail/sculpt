import 'package:flutter/material.dart';
import 'package:sculpt/presentation/ui_kit/app_bar/default_appbar.dart';
import 'package:sculpt/presentation/ui_kit/buttons/large_btn.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';
import 'package:sculpt/presentation/ui_kit/fileds/default_text_field.dart';
import 'package:sculpt/utils/validators.dart';

class CreateRoutineScreen extends StatefulWidget {
  CreateRoutineScreen({super.key});

  @override
  State<CreateRoutineScreen> createState() => _CreateRoutineScreenState();
}

class _CreateRoutineScreenState extends State<CreateRoutineScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIKitColors.primaryColor,
      appBar: defaultAppBar(context, "Create routine"),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTextField(
                label: "Routine name",
                hintText: "My Monday routine",
                validator: (value) => Validators.emptyTextValidation(context, value),
              ),
              SizedBox(height: 20),
              LargeBtn(
                label: "Create",
                icon: Icons.add,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
