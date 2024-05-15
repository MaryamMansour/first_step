import 'package:flutter/material.dart';

import '../../../../core/helper/spacing.dart';
import '../../../../core/widgets/text_form_field.dart';

class EmailAndPassword extends StatefulWidget {
  const EmailAndPassword({super.key});

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextFormField(
          labelText: "Email",
          hintText: "FirstStep@example.com",
        ),
        verticalSpace(35),
        AppTextFormField(
          labelText: "Password",
          hintText: "●●●●●●●●●",
          isObscureText: isObscureText,
          suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isObscureText = !isObscureText;
                });
              },
              child: Icon(
                isObscureText ? Icons.visibility_off : Icons.visibility,
                size: 20,
              )),
        ),
      ],
    );
  }
}
