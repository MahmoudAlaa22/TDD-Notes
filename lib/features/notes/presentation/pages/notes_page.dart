import 'package:flutter/material.dart';
import '../../../../core/routes/routes.dart';
import '../../../../utils/navigator.dart';
import '../../../../utils/app_screen_size.dart';

import '../../../../core/constant/strings.dart';
import '../widgets/notes_list_widget.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizeScreen.getSize(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
      }),
      appBar: AppBar(
        title: const Text(AppStrings.notes),
        actions: [
          IconButton(onPressed: (){
            Go.toName(context: context, routeName: AppRoutes.addUserPage);
          }, icon: const Icon(Icons.person_add)),
          IconButton(onPressed: (){
            Go.toName(context: context, routeName: AppRoutes.settingPage);
          }, icon: const Icon(Icons.settings)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.menu)),
        ],
      ),
      body: const NotesListWidget(),
    );
  }
}
