part of 'notes_cubit.dart';

abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

class NotesInitial extends NotesState {}
class NotesLoadingState extends NotesState {}
class NotesErrorState extends NotesState {
  final String message;

  const NotesErrorState({required this.message});
}
class NotesSuccessState extends NotesState {
  final List <NotesModel> notes;

  const NotesSuccessState({required this.notes});
}

class NotesUpdateShowSearchBarState extends NotesState{}
