part of 'users_cubit.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersInitial extends UsersState {}

class UsersLoadingState extends UsersState {}

class UsersErrorState extends UsersState {
  final String message;

  const UsersErrorState({required this.message});
}

class UsersSuccessState extends UsersState {
  final List<UsersModel> users;

  const UsersSuccessState({required this.users});
}
