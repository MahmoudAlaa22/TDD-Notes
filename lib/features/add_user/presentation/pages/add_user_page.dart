import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constant/strings.dart';
import '../../../../core/theme/colors.dart';
import '../bloc/cubit/add_user_cubit.dart';
import '../widgets/add_user_form_widget.dart';
import '../../../../utils/app_screen_size.dart';
import '../../../../widgets/toast_widget.dart';

class AddUserPage extends StatelessWidget {
  const AddUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.addUser),
      ),
      body: SizedBox(
        width: AppSizeScreen.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  BlocConsumer<AddUserCubit, AddUserState>(
                    listener: (context, state) {
                      if (state is AddUserSuccessState) {
                        ToastWidget.show(
                            message: 'A new user has been added',
                            toastType: ToastType.SUCCESS);
                      }
                      else if (state is AddUserErrorState) {
                        ToastWidget.show(
                            message: state.message!,
                            toastType: ToastType.ERROR);
                      }
                    },
                    builder: (context, state) {
                      final cubit = AddUserCubit.get(context);

                      return Container(
                        width: AppSizeScreen.width * 0.3,
                        height: AppSizeScreen.width * 0.3,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                        child: ClipOval(
                          child: cubit.userImage == null
                              ? Row()
                              : Image.file(
                                  File(cubit.userImage!),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () async {
                      await AddUserCubit.get(context).takeImageFromGallery();
                    },
                    child: const Text(
                      AppStrings.selectImage,
                      style: TextStyle(color: AppColors.black),
                    ),
                  ),
                  const AddUserFormWidget(),
                ]),
          ),
        ),
      ),
    );
  }
}
