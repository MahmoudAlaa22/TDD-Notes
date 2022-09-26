import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../widgets/toast_widget.dart';
import '../bloc/cubit/notes_cubit.dart';
import 'filter_button.dart';
import 'note_item.dart';
import 'search_button.dart';

class NotesListWidget extends StatelessWidget {
  const NotesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesCubit, NotesState>(
      listener: (context, state) {
        if (state is NotesErrorState) {
          ToastWidget.show(message: state.message, toastType: ToastType.ERROR);
        }
      },
      builder: (context, state) {
        final cubic = NotesCubit.get(context);
        if (state is NotesSuccessState) {
          final notes = state.notes;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: const [
                    FilterButton(),
                    SearchButtonBar(),
                  ],
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await NotesCubit.get(context).getAllNotes();
                    },
                    child: ListView.separated(
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        final note = notes[index];
                        return NoteItem(
                          notesModel: note,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
