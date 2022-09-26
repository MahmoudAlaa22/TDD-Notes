import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../widgets/toast_widget.dart';
import '../../../../core/constant/strings.dart';
import '../../../../core/theme/colors.dart';
import '../bloc/cubit/setting_cubit.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.options),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            ListTile(
              title: const Text(AppStrings.useLocalDatabase),
              subtitle: const Text(
                  'Instead of using HTTP call to work with the app data.'),
              trailing: BlocConsumer<SettingCubit, SettingState>(
                listener: (context, state) {
                  if(state is SettingErrorState){
                    ToastWidget.show(message: state.message!, toastType: ToastType.ERROR);
                  }
                },
                builder: (context, state) {
                  final cubit=SettingCubit.get(context);
                  return Switch(
                      activeColor: AppColors.primary,
                      value: cubit.useDatabaseState,
                      onChanged: (v)=>cubit.changeUserDatabaseState(v));
                },
              ),
            ),
            const Divider(thickness: 2),
          ],
        ),
      ),
    );
  }
}
