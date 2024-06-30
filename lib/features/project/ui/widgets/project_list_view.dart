import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:first_step/core/helper/spacing.dart';
import 'package:first_step/core/theming/colors.dart';
import 'package:first_step/core/theming/styles.dart';

class ProjectsListView extends StatelessWidget {
  const ProjectsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 16.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          'https://english.ahram.org.eg/Media/News/2021/3/23/2021-637520930425083147-508.jpg',
                          height: 120.h,
                          width: 190.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                      verticalSpace(10),
                      Wrap(
                        spacing: 2.0,
                        runSpacing: 3.0,
                        children: List<Widget>.generate(3, (int index) {
                          return TagItem(text: "Finance");
                        }),
                      ),
                    ],
                  ),
                ),
                horizontalSpace(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Thndr',
                        style: AppTextStyles.font20BlackThin.copyWith(
                            fontWeight: FontWeight.w400),
                        overflow: TextOverflow.ellipsis,
                      ),
                      verticalSpace(15),
                      Text(
                        "Description: Your road to financial freedom starts here.",
                        style: AppTextStyles.font16PrimaryLight,
                        overflow: TextOverflow.visible,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class TagItem extends StatelessWidget {
  final String text;

  const TagItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.yellow,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.black,fontSize: 8,fontWeight: FontWeight.w600),
      ),
    );
  }
}
