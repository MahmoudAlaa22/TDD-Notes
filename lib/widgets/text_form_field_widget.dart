// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import '../core/enum/text_form_typ_enum.dart';
import '../core/theme/colors.dart';
import '../utils/validators/validators.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget(
      {Key? key,
      required this.label,
      required this.onChanged,
      this.suffixIcon,
      required this.enumInputType,
      this.obscureText = false})
      : super(key: key);
  final String label;
  final Function(String?) onChanged;
  final TextFormTypEnum enumInputType;
  final bool obscureText;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        decoration: const BoxDecoration(color: AppColors.white, boxShadow: [
          BoxShadow(
              blurRadius: 8,
              offset: Offset(0, 1),
              color: Color.fromRGBO(0, 0, 0, 0.05))
        ]),
        child: TextFormField(
          style: textStyle,
          decoration: InputDecoration(
              label: Text(
                label,
              ),
              prefixIcon: Icon(_prefixIcon()),
              suffixIcon: suffixIcon),
          obscureText: obscureText,
          keyboardType: _keyboardType(),
          onChanged: (v) => onChanged(v),
          validator: (v) {
            return Validators.validMessage(
              context: context,
              enumInputType: enumInputType,
              text: v!,
            );
          },
        ),
      ),
    );
  }

  IconData _prefixIcon() {
    switch (enumInputType) {
      case TextFormTypEnum.NAME:
        return Icons.person_outline_sharp;
      case TextFormTypEnum.EMAIL:
        return Icons.email_outlined;
      case TextFormTypEnum.PASSWORD:
        return Icons.lock_outline_sharp;
    }
  }

  TextInputType _keyboardType() {
    switch (enumInputType) {
      case TextFormTypEnum.NAME:
        return TextInputType.name;
      case TextFormTypEnum.EMAIL:
        return TextInputType.emailAddress;
      case TextFormTypEnum.PASSWORD:
        return TextInputType.visiblePassword;
    }
  }
}
