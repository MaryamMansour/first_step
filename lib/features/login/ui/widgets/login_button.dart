import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/text_button.dart';
import '../../logic/cubit/login_cubit.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return
    AppTextButton(
      buttonText: "Login",
      onPressed: () {
        print("HII");
        validateAndLogin(context);
      },
    );
  }




  void validateAndLogin(BuildContext context) {

    print("YARAB");
    if (context.read<LoginCubit>().formKey.currentState!.validate()) {
      context.read<LoginCubit>().emitLoginStates();
    }

  }
}
