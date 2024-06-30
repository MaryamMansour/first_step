import 'package:first_step/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_step/core/helper/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:first_step/core/theming/colors.dart';
import 'package:first_step/features/project/logic/project_cubit.dart';

class HomeTopBar extends StatelessWidget {
  HomeTopBar({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 220.h,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(70),
        ),
      ),
      child: Column(
        children: [
          verticalSpace(35),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 50,
                  height: 50,
                  child: Image.asset("assets/images/logo_light.png"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 250.w,
                  height: 50.h,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      fillColor: AppColors.white,
                      filled: true,
                      contentPadding: EdgeInsets.all(8),
                      hintText: 'Search projects...',
                      hintStyle: AppTextStyles.font20BlackThin.copyWith(fontSize: 12),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppColors.lightGray,
                          width: 1.3,
                        ),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          final query = _searchController.text.trim();
                          if (query.isNotEmpty) {
                            BlocProvider.of<ProjectCubit>(context)
                                .searchProjects(query);
                          }
                        },
                      ),
                    ),
                    onSubmitted: (query) {
                      if (query.isNotEmpty) {
                        BlocProvider.of<ProjectCubit>(context)
                            .searchProjects(query);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          verticalSpace(42),
          FilterButtons(),
          verticalSpace(20),
        ],
      ),
    );
  }
}

class FilterButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          FilterButton(text: 'All'),
          FilterButton(text: 'Graduation projects'),
          FilterButton(text: 'Start Ups'),
          IconButton(
            icon: Icon(Icons.tune, color: AppColors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String text;

  const FilterButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: () {
          print("HII object");
        },
        child: Container(
          height: 3.h,
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
