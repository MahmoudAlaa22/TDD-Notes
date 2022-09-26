part of 'add_user_cubit.dart';

abstract class AddUserState extends Equatable {
  const AddUserState();

  @override
  List<Object> get props => [];
}

class AddUserInitial extends AddUserState {}
class AddUserLoadingState extends AddUserState {}
class AddUserErrorState extends AddUserState {
  final String?message;

  const AddUserErrorState({required this.message});
}
class AddUserSuccessState extends AddUserState {}
class AddUserLoadingImageState extends AddUserState {}
class AddUserLoadedImageState extends AddUserState {}
class AddUserErrorImageState extends AddUserState {
  final String message;

  const AddUserErrorImageState(this.message);
}

class AddUserPasswordVisibilityState extends AddUserState {
  final bool obscureText;

const  AddUserPasswordVisibilityState(this.obscureText);
}
