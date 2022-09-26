import 'package:flutter/material.dart';

import '../core/theme/colors.dart';

class TextFormPopup extends StatelessWidget {
  const TextFormPopup({super.key, this.text, this.list, this.labelText});
  final String? text;
  final String? labelText;
  final List<PopupMenuEntry>? list;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        TextFormField(
          controller: TextEditingController(text: text),
          decoration: InputDecoration(
            labelText: labelText,
            enabled: false,
          ),
        ),
        PopupMenuButton(
            icon: const Icon(
              Icons.arrow_drop_down_sharp,
              size: 40,
              color: AppColors.gray,
            ),
            padding: EdgeInsets.zero,
            itemBuilder: (_) {
              if (list != null) {
                return list!;
              } else {
                return [
                  const PopupMenuItem(child: CircularProgressIndicator())
                ];
              }
            })
      ],
    );
  }
}
