part of 'setting_cubit.dart';

abstract class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object> get props => [];
}

class SettingInitial extends SettingState {}
class SettingChangeSwitchState extends SettingState {}
class SettingLoadingState extends SettingState {}
class SettingSuccessState extends SettingState {}
class SettingErrorState extends SettingState {
  final String? message;

  const SettingErrorState({required this.message});
}

