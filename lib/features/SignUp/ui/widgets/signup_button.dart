import 'package:first_step/core/theming/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/text_button.dart';
import '../../logic/cubit/sign_up_cubit.dart';


class SignupButton extends StatelessWidget {
  const SignupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return
      AppTextButton(
        buttonText: "SignUp",

        onPressed: () {
          validateThenDoSignup(context);
        },
      );
  }
}

void validateThenDoSignup(BuildContext context) {
  if (context.read<SignupCubit>().formKey.currentState!.validate()) {
    context.read<SignupCubit>().emitSignupStates();
  }
}
