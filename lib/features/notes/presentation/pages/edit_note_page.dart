import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/strings.dart';
import '../../../../widgets/text_form_popup.dart';
import '../../../../widgets/toast_widget.dart';
import '../../data/model/notes_model.dart';
import '../../data/model/users_model.dart';
import '../bloc/cubit/edit_note_cubit.dart';
import '../bloc/cubit/notes_cubit.dart';
import '../bloc/cubit/users_cubit.dart';

class EditNotePage extends StatelessWidget {
  const EditNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    final list = ModalRoute.of(context)!.settings.arguments as List;
    final note = list[0] as NotesModel;
    final user = list[1] as UsersModel;
    final edit = EditNoteCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.editNote),
        actions: [
          IconButton(
              onPressed: () async {
                await edit.updateNote(notesModel: note);
                await NotesCubit.get(context).getAllNotes();
                // Go.back(context: context);
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Form(
          key: edit.formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: note.text,
                decoration: const InputDecoration(
                  labelText: AppStrings.note,
                ),
                maxLines: null,
                onSaved: (v) => edit.onChangeNoteText(v!),
                validator: (v) {
                  if (v!.isEmpty) return 'You must not make this field empty.';
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                child: BlocConsumer<EditNoteCubit, EditNoteState>(
                  listener: (context, state) {
                    if (state is EditNoteSuccessState) {
                      ToastWidget.show(
                        message: 'Note has been Edited Successfully',
                        toastType: ToastType.SUCCESS,
                      );
                    } else if (state is EditNoteErrorState) {
                      ToastWidget.show(
                        message: state.message!,
                        toastType: ToastType.ERROR,
                      );
                    }
                  },
                  builder: (context, state) {
                    final cubit = EditNoteCubit.get(context);
                    return TextFormPopup(
                      labelText: 'Assign To User',
                      text: cubit.assignUser?.username ?? user.username,
                      list: UsersCubit.get(context)
                          .users!
                          .map((e) => PopupMenuItem(
                                child: Text(e.username!),
                                onTap: () {
                                  cubit.onChangAssignUser(value: e);
                                },
                              ))
                          .toList(),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
