import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/Cubit/Cubit.dart';

import '../../shared/Cubit/States.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {

        },
        builder: (BuildContext context, AppStates state) {
          var tasks = AppCubit.get(context).newTasks;
          return  buildListTasks( tasks);
        });
  }
}
