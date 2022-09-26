import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../data/model/users_model.dart';
import '../../../domain/usecases/update_note_usecase.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../utils/app_utils.dart';
import '../../../data/model/notes_model.dart';

part 'edit_note_state.dart';

class EditNoteCubit extends Cubit<EditNoteState> {
  final UpdateNoteUsecase updateNoteUsecase;
  EditNoteCubit({required this.updateNoteUsecase}) : super(EditNoteInitial());
  static EditNoteCubit get(BuildContext context) => BlocProvider.of(context);
  UsersModel? assignUser;
  String? textNote;
  final formKey = GlobalKey<FormState>();

  Future<void> updateNote({required NotesModel notesModel}) async {
    try {
      final formStae = formKey.currentState;
      if (formStae!.validate()) {
        formStae.save();
        DateTime now = DateTime.now();
        String formattedDate =
            DateFormat('yyyy-MM-ddTHH:mm:ss.mmm').format(now);
        emit(EditNoteLoadingState());
        final failureOrDone = await updateNoteUsecase.updateNote(
            notesModel: NotesModel(
          id: notesModel.id,
          placeDateTime: formattedDate,
          text: textNote ?? notesModel.text,
          userId: assignUser?.id ?? notesModel.userId,
        ));
        emit(_mapFailuerOrDoneMessage(either: failureOrDone));
      }
    } catch (e) {
      final failure=  AppUtils.buildFailure(e);
      emit(EditNoteErrorState(message: AppUtils.buildErrorMsg(failure)));
    }
  }

  void onChangeNoteText(String v) {
    textNote = v;
    emit(EditNoteChangeNote());
  }

  void onChangAssignUser({required UsersModel value}) {
    emit(EditNoteInitial());
    assignUser = value;
    emit(EditNoteOnChangeAssign());
  }

  EditNoteState _mapFailuerOrDoneMessage({
    required Either<Failure, Unit> either,
  }) {
    return either.fold(
      (failure) => EditNoteErrorState(message: AppUtils.buildErrorMsg(failure)),
      (users) => EditNoteSuccessState(),
    );
  }
}
