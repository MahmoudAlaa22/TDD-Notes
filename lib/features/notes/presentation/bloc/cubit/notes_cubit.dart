import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/notes_model.dart';
import '../../../domain/usecases/get_all_notes_usecase.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../utils/app_utils.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final GetAllNotesUsecase getAllNotesUsecase;
  NotesCubit({required this.getAllNotesUsecase}) : super(NotesInitial());
  static NotesCubit get(BuildContext context) => BlocProvider.of(context);

  List<NotesModel>? notes;
  List<NotesModel>? filterList;
  bool showSearchBar = false;

  Future<void> getAllNotes() async {
    try {
      emit(NotesLoadingState());
      final failureOrDone = await getAllNotesUsecase.getAllNotes();
      emit(_mapFailuerOrDoneMessage(either: failureOrDone));
    } catch (e) {
      final failure = AppUtils.buildFailure(e);
      emit(NotesErrorState(message: AppUtils.buildErrorMsg(failure)));
    }
  }

  void filterByUser({required String id}) {
    emit(NotesLoadingState());
    filterList = notes!.where((element) => element.userId == id).toList();
    emit(NotesSuccessState(notes: filterList!));
  }

  void searchInNotes({required String text}) {
    emit(NotesLoadingState());
    List<NotesModel> searchList = [];
    for (var e in notes!) {
      if (e.text!.contains(text)) {
        searchList.add(e);
      }
    }
    filterList = searchList;
    emit(NotesSuccessState(notes: filterList!));
  }

  void updateShowSearchBar() {
    showSearchBar = !showSearchBar;
    emit(NotesUpdateShowSearchBarState());
  }

  NotesState _mapFailuerOrDoneMessage({
    required Either<Failure, List<NotesModel>> either,
  }) {
    return either.fold(
      (failure) => NotesErrorState(message: AppUtils.buildErrorMsg(failure)),
      (notes) {
        this.notes = notes;
        filterList = notes;
        return NotesSuccessState(notes: filterList!);
      },
    );
  }
}
