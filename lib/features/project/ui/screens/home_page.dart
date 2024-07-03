import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../data/repo/project_repo.dart';
import '../../logic/project_cubit.dart';
import '../widgets/home_top_bar.dart';
import '../widgets/pojects_bloc_builder.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProjectCubit(GetIt.instance<ProjectRepo>())..getAllProjects(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeTopBar(),
            Expanded(child: ProjectsBlocBuilder()),
          ],
        ),
      ),
    );
  }
}