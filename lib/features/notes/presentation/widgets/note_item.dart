import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../utils/navigator.dart';
import '../../data/model/notes_model.dart';
import '../bloc/cubit/users_cubit.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({
    super.key,
    required this.notesModel,
  });
  final NotesModel? notesModel;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        notesModel!.text ?? '',
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
      trailing: IconButton(
        onPressed: () {
          final assignUser = UsersCubit.get(context)
              .getUserAssigned(id: notesModel!.userId ?? '');
          Go.toName(
              context: context,
              routeName: AppRoutes.editNotePageRoute,
              arguments: [
                notesModel,
                assignUser,
              ]);
        },
        icon: const Icon(
          Icons.edit,
        ),
        color: AppColors.gray,
      ),
    );
  }
}
