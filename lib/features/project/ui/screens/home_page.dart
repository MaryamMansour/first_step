
import 'package:first_step/features/project/ui/widgets/project_list_view.dart';
import 'package:flutter/material.dart';

import '../widgets/home_top_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        child:
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeTopBar(),
            ProjectsListView(),
          ],
        ),
      ),
    );
  }
}
