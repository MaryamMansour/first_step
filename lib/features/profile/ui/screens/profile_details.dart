import 'package:first_step/core/helper/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/profile_cubit.dart';
import '../../logic/profile_state.dart';
import '../widgets/profile_details_form.dart';

class ProfileDetailsScreen extends StatelessWidget {
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit profile"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ProfileDetailsConsumer(),
    );
  }
}

class ProfileDetailsConsumer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) =>
        current is profileError ||
        current is profileSuccess ||
        current is profileLoading,
      builder: (context, state) {
        return state.maybeWhen(
          profileLoading: () => Center(child: CircularProgressIndicator()),
          profileSuccess: (profileResponse) => ProfileDetailsForm(profileResponse: profileResponse),
          profileError: (errorHandler) => Center(child: Text("Error: $errorHandler")),
          orElse: () {
          return const SizedBox.shrink();

        },
        );
      },
    );
  }
}
