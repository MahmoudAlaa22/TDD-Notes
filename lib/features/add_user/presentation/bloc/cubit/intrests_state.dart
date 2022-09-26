part of 'intrests_cubit.dart';

abstract class IntrestsState extends Equatable {
  const IntrestsState();

  @override
  List<Object> get props => [];
}

class IntrestsInitial extends IntrestsState {}
class IntrestsOnChange extends IntrestsState {}
class IntrestsLoadingState extends IntrestsState {}
class IntrestsSuccessState extends IntrestsState {
  final List<IntrestModel> intrests;

  const IntrestsSuccessState({required this.intrests});
}
class IntrestsErreState extends IntrestsState {
  final String?message;

const  IntrestsErreState({required  this.message});
}
