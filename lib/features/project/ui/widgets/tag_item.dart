// tag_item.dart
import 'package:flutter/material.dart';
import '../../../../core/theming/colors.dart';

class TagItem extends StatelessWidget {
  final String text;

  const TagItem({required this.text, Key? key}) : super(key: key);

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
        style: const TextStyle(color: Colors.black, fontSize: 8, fontWeight: FontWeight.w600),
      ),
    );
  }
}
