
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/setting/presentation/bloc/cubit/setting_cubit.dart';
import 'features/notes/presentation/bloc/cubit/notes_cubit.dart';
import 'features/notes/presentation/bloc/cubit/users_cubit.dart';
import 'core/routes/router.dart';
import 'core/routes/routes.dart';
import 'core/theme/themes.dart';
import 'injection_container.dart' as di;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
      BlocProvider(create: (_)=>di.sl<NotesCubit>()..getAllNotes()),
      BlocProvider(create: (_)=>di.sl<UsersCubit>()..getAllUsers()),
      BlocProvider(create: (_)=>di.sl<SettingCubit>()..getUseDatabaseState()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemes.lightTheme,
        onGenerateRoute: onGenerate,
      ),
    );
  }
}
