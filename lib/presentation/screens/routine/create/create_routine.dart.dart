import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sculpt/bloc/routine/routine_cubit.dart';
import 'package:sculpt/constants/enums.dart';
import 'package:sculpt/presentation/ui_kit/app_bar/default_appbar.dart';
import 'package:sculpt/presentation/ui_kit/buttons/large_btn.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';
import 'package:sculpt/presentation/ui_kit/fields/default_text_field.dart';
import 'package:sculpt/presentation/ui_kit/snackbar/error_snackbar.dart';
import 'package:sculpt/presentation/ui_kit/tiles/routine_tile.dart';
import 'package:sculpt/utils/validators.dart';

class CreateRoutineScreen extends StatefulWidget {
  const CreateRoutineScreen({super.key});

  @override
  State<CreateRoutineScreen> createState() => _CreateRoutineScreenState();
}

class _CreateRoutineScreenState extends State<CreateRoutineScreen> {
  final _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();

  bool created = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoutineCubit, RoutineState>(
      listener: (context, state) {
        if (state.status == StateStatus.success) {
          setState(() {
            created = true;
            textController.clear();
          });
        }
        if (state.status == StateStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            UiKitSnackBars.error(context, label: "Please provide the name for the routine."),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: UIKitColors.primaryColor,
          appBar: defaultAppBar(context, "Create routine"),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: _buildByState(state),
            ),
          ),
        );
      },
    );
  }

  Widget _buildByState(RoutineState state) {
    final routine = state.routine;
    if (!created || routine == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultTextField(
            controller: textController,
            label: "Routine name",
            hintText: "My Monday routine",
            validator: (value) => Validators.emptyTextValidation(context, value),
          ),
          const SizedBox(height: 20),
          LargeBtn(
            label: "Create",
            icon: Icons.add,
            onTap: () => context.read<RoutineCubit>().create(textController.text),
          ),
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RoutineTile(routine: routine),
        const SizedBox(height: 20),
        LargeBtn(
          label: "Create Another",
          icon: Icons.add,
          onTap: () => setState(() {
            created = false;
          }),
        ),
      ],
    );
  }
}
