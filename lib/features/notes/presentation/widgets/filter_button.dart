import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/users_model.dart';
import '../bloc/cubit/notes_cubit.dart';
import '../bloc/cubit/users_cubit.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = NotesCubit.get(context);
    return BlocBuilder<UsersCubit, UsersState>(
      builder: (context, state) {
        return PopupMenuButton(
            icon: const Icon(Icons.filter_list_sharp),
            padding: EdgeInsets.zero,
            itemBuilder: (_) {
              List<UsersModel>? users;
              if (state is UsersSuccessState) {
                users = state.users;
                final list = users
                    .map((e) => PopupMenuItem(
                          child: Text(e.username!),
                          onTap: () {
                            cubit.filterByUser(id: e.id!);
                          },
                        ))
                    .toList();
                list.add(PopupMenuItem(
                  child: const Text('All Users'),
                  onTap: () {
                    cubit.getAllNotes();
                  },
                ));

                return list.reversed.toList();
              } else {
                return [
                  const PopupMenuItem(child: CircularProgressIndicator())
                ];
              }
            });
      },
    );
  }
}
