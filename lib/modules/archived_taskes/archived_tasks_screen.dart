import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/Cubit/Cubit.dart';
import '../../shared/Cubit/States.dart';
import '../../shared/components/components.dart';

class ArchivedTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          var tasks = AppCubit.get(context).archivedTasks;
          return buildListTasks(tasks);
        });
  }
}
