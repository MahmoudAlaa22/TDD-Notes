part of 'edit_note_cubit.dart';

abstract class EditNoteState extends Equatable {
  const EditNoteState();

  @override
  List<Object> get props => [];
}

class EditNoteInitial extends EditNoteState {}
class EditNoteLoadingState extends EditNoteState {}
class EditNoteSuccessState extends EditNoteState {}
class EditNoteErrorState extends EditNoteState {
  final String?message;

  const EditNoteErrorState({required this.message});
}
class EditNoteOnChangeAssign extends EditNoteState {}
class EditNoteChangeNote extends EditNoteState {}
