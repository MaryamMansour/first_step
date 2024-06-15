import 'package:first_step/core/helper/extensions.dart';
import 'package:first_step/features/profile/data/models/reset_password_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/routing/routes.dart';
import '../../logic/profile_cubit.dart';
import '../../logic/profile_state.dart';
import '../widgets/change_password_form.dart';

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ChangePasswordConsumer(),

    );
  }
}






class ChangePasswordConsumer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  BlocListener<ProfileCubit, ProfileState>(
      listenWhen: (previous, current) =>
      current is profileLoading || current is resetSuccess || current is profileError,
      listener: (context, state) {
        state.whenOrNull(
          profileLoading: () {
            showDialog(
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
          resetSuccess: (ResetPasswordResponse) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Password reset successfully!'),
                duration: Duration(seconds: 2),
              ),
            );
            context.pop();
              context.pushNamed(Routes.profileScreen);
          },



          profileError: (error) {
            _showErrorDialog(context,error.apiErrorModel.message??"error");
          },
        );
      },
      child: ChangePasswordForm(),
    );
  }


  void _showErrorDialog(BuildContext context, String error) {
    context.pop();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(error),
        actions: [
          TextButton(
            onPressed: () {
             context.pop();
            },
            child: Text('Got it'),
          ),
        ],
      ),
    );
  }

}