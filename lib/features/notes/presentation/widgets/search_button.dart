import 'package:flutter/material.dart';

import '../../../../core/constant/strings.dart';
import '../../../../utils/app_screen_size.dart';
import '../bloc/cubit/notes_cubit.dart';

class SearchButtonBar extends StatefulWidget {
  const SearchButtonBar({super.key});

  @override
  State<SearchButtonBar> createState() => _SearchButtonBarState();
}

class _SearchButtonBarState extends State<SearchButtonBar> {
  bool showSearchBar = false;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cubic = NotesCubit.get(context);
    return Row(
      children: [
        GestureDetector(
            onTap: () {
              setState(() {
                showSearchBar = !showSearchBar;
              });
            },
            child: const Icon(Icons.search)),
        if (showSearchBar)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: AppSizeScreen.width * 0.7,
              height: AppSizeScreen.height * 0.05,
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: AppStrings.search,
                  suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          controller.clear();
                        });
                        cubic.searchInNotes(text: '');
                      },
                      child: const Icon(Icons.close)),
                ),
                onChanged: (value) => cubic.searchInNotes(text: value),
              ),
            ),
          )
      ],
    );
  }
}
