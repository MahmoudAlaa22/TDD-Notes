import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/strings.dart';
import '../../../../core/enum/text_form_typ_enum.dart';
import '../../../../utils/app_screen_size.dart';
import '../../../../widgets/text_form_field_widget.dart';
import '../../../../widgets/text_form_popup.dart';
import '../../../../widgets/toast_widget.dart';
import '../bloc/cubit/add_user_cubit.dart';
import '../bloc/cubit/intrests_cubit.dart';

class AddUserFormWidget extends StatelessWidget {
  const AddUserFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = AddUserCubit.get(context);
    return Form(
      key: cubit.formKey,
      child: Column(children: [
        TextFormFieldWidget(
            label: AppStrings.userName,
            onChanged: (v) => cubit.updateName(v!),
            enumInputType: TextFormTypEnum.NAME),
        TextFormFieldWidget(
            label: AppStrings.email,
            onChanged: (v) => cubit.updateEmail(v!),
            enumInputType: TextFormTypEnum.EMAIL),
        BlocBuilder<AddUserCubit, AddUserState>(
          builder: (context, state) {
            log('state is $state');
            final obscureText = AddUserCubit.get(context).obscureText;
            return TextFormFieldWidget(
              label: AppStrings.password,
              obscureText: obscureText,
              suffixIcon: GestureDetector(
                onTap: () => cubit.visiblePassord(),
                child: Icon(
                  obscureText ? Icons.visibility_off_sharp : Icons.visibility,
                  size: 20,
                ),
              ),
              onChanged: (v) => cubit.updatePassword(v!),
              enumInputType: TextFormTypEnum.PASSWORD,
            );
          },
        ),
        BlocConsumer<IntrestsCubit, IntrestsState>(
          listener: (context, state) {
            if(state is IntrestsErreState){
              ToastWidget.show(message: state.message!, toastType: ToastType.ERROR);
            }
            
          },
          builder: (context, state) {
            final intrestCubit = IntrestsCubit.get(context);
            return  
            TextFormPopup(
              labelText: 'Interest',
              text: intrestCubit.intrest?.intrestText?? intrestCubit.intrests?.first.intrestText,
              list: intrestCubit.intrests==null?[]:intrestCubit.intrests!
                  .map((e) => PopupMenuItem(
                        child: Text(e.intrestText!),
                        onTap: () {
                          intrestCubit.onChangeIntrests(e);
                          cubit.updateIntrestId(e.id!);
                        },
                      ))
                  .toList(),
            );
          },
        ),
        const SizedBox(height: 20,),
        ElevatedButton(
          onPressed: ()async{
          await cubit.addUser();
        }, child: SizedBox(
          width: AppSizeScreen.width,
          child: const Center(child:  Text('SAVE'))))
      ]),
    );
  }
}
