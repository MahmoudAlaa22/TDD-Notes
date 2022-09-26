import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/add_user_usecase.dart';
import '../../../../notes/presentation/widgets/filter_button.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../utils/app_utils.dart';
import '../../../data/model/add_user_model.dart';

part 'add_user_state.dart';

class AddUserCubit extends Cubit<AddUserState> {
  final AddUserUsecase addUserUsecase;
  AddUserCubit({required this.addUserUsecase}) : super(AddUserInitial());
  static AddUserCubit get(BuildContext context) => BlocProvider.of(context);
  String? userImage;
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;
  String? name;
  String? email;
  String? password;
  String? intrestId;

  Future<void> addUser() async {
    final formState = formKey.currentState;
    if (formState!.validate()) {
      formState.save();
      try {
        emit(AddUserLoadingState());
        final failureOrDone = await addUserUsecase.addUser(
            addUserModel: AddUserModel(
                username: name,
                email: email,
                password: password,
                imageAsBase64: userImage,
                intrestId: intrestId ?? '0'));
        emit(_mapFailuerOrDoneMessage(either: failureOrDone));
      } catch (e) {
        final failure = AppUtils.buildFailure(e);
        emit(AddUserErrorState(message: AppUtils.buildErrorMsg(failure)));
      }
    }
  }

  Future<void> takeImageFromGallery() async {
    try {
      emit(AddUserLoadingImageState());
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null) {
        final file = File(result.files.single.path!);
        userImage = file.path;

        emit(AddUserLoadedImageState());
      }
    } catch (e) {
      emit(AddUserErrorImageState(e.toString()));
    }
  }

  void visiblePassord() {
    emit(AddUserInitial());
    obscureText = !obscureText;
    emit(AddUserPasswordVisibilityState(obscureText));
  }

  void updateName(String v) => copyWith(name: v);
  void updateEmail(String v) => copyWith(email: v);
  void updatePassword(String v) => copyWith(password: v);
  void updateIntrestId(String v) => copyWith(intrestId: v);

  void copyWith({
    String? name,
    String? email,
    String? password,
    String? intrestId,
  }) {
    this.name = name ?? this.name;
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.intrestId = intrestId ?? this.intrestId;
    emit(state);
  }

  AddUserState _mapFailuerOrDoneMessage({
    required Either<Failure, Unit> either,
  }) {
    return either.fold(
      (failure) => AddUserErrorState(message: AppUtils.buildErrorMsg(failure)),
      (addUser) => AddUserSuccessState(),
    );
  }
}
