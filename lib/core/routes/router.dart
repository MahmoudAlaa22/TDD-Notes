import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/add_user/presentation/bloc/cubit/add_user_cubit.dart';
import '../../features/add_user/presentation/bloc/cubit/intrests_cubit.dart';
import '../../features/add_user/presentation/pages/add_user_page.dart';
import '../../features/notes/presentation/bloc/cubit/edit_note_cubit.dart';
import '../../features/notes/presentation/pages/edit_note_page.dart';
import '../../features/notes/presentation/pages/notes_page.dart';
import '../../features/setting/presentation/pages/setting_page.dart';
import 'routes.dart';
import 'package:flutter/cupertino.dart';
import '../../injection_container.dart' as di;

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.notesPageRoute:
      return CupertinoPageRoute(
        builder: (_) => const NotesPage(),
        settings: settings,
      );
    case AppRoutes.editNotePageRoute:
      return CupertinoPageRoute(
        builder: (_) => BlocProvider<EditNoteCubit>(
          create: (context) => di.sl<EditNoteCubit>(),
          child: const EditNotePage(),
        ),
        settings: settings,
      );
    case AppRoutes.addUserPage:
      return CupertinoPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => di.sl<AddUserCubit>()),
            BlocProvider(
                create: (_) => di.sl<IntrestsCubit>()..getAllIntrests()),
          ],
          child: const AddUserPage(),
        ),
        settings: settings,
      );
    case AppRoutes.settingPage:
      return CupertinoPageRoute(
        builder: (_) => const SettingPage(),
        settings: settings,
      );
    default:
      return CupertinoPageRoute(
          builder: (_) => const Center(child: CircularProgressIndicator()));
  }
}
