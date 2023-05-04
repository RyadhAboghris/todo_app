import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/modules/archived_taskes/archived_tasks_screen.dart';
import 'package:todo_app/modules/done_tasks/done_tasks_screen.dart';
import 'package:todo_app/modules/new_tasks/new_tasks_screen.dart';
import 'package:todo_app/shared/Cubit/Cubit.dart';

import '../shared/Cubit/States.dart';
import '../shared/components/components.dart';
import '../shared/components/constants.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit()..createDatabase(),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, AppStates state) {
            if (state is AppInsertDataBaseState) {
              Navigator.pop(context);
            }
          },
          builder: (BuildContext context, AppStates state) {
            AppCubit cubit = AppCubit.get(context);

            return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                title: Text(cubit.titles[cubit.currentIndex]),
              ),
              body: cubit.screens[cubit.currentIndex],
              floatingActionButton: FloatingActionButton(
                onPressed: () {

                  if (cubit.isBottomSheetShown) {
                    if (formKey.currentState.validate()) {
                      cubit.insertToDatabase(
                        title: titleController.text,
                        date: dateController.text,
                        time: timeController.text,
                      );

                      // ).then((value) {
                      //   getDataFormDataBase(database).then((value) {
                      //     Navigator.pop(context);
                      //
                      //       isBottomSheetShown = false;
                      //       fabIcon = Icons.edit;
                      //       tasks = value;
                      //       print(tasks);
                      //
                      //
                      //   });
                      // });
                    }
                  } else {
                    scaffoldKey.currentState
                        .showBottomSheet(
                          (context) => SingleChildScrollView(
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.all(20),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    defaultformfield(
                                      conttroller: titleController,
                                      type: TextInputType.text,
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return 'title must not be empty';
                                        }
                                        return null;
                                      },
                                      lable: 'Task Title',
                                      prefx: Icons.title,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    defaultformfield(
                                      conttroller: timeController,
                                      type: TextInputType.none,
                                      onTap: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        ).then((value) {
                                          timeController.text =
                                              value.format(context).toString();

                                          print(value.toString());
                                        });
                                      },
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return 'time must not be empty';
                                        }
                                        return null;
                                      },
                                      lable: 'Task Time',
                                      prefx: Icons.watch_later_outlined,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    defaultformfield(
                                      conttroller: dateController,
                                      type: TextInputType.none,
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate:
                                              DateTime.parse('3000-05-03'),
                                        ).then((value) {
                                          dateController.text =
                                              DateFormat.yMMMd().format(value);
                                          print(
                                              DateFormat.yMMMd().format(value));
                                        });
                                      },
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return 'date must not be empty';
                                        }
                                        return null;
                                      },
                                      lable: 'Task date',
                                      prefx: Icons.calendar_today,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          elevation: 20,
                        )
                        .closed
                        .then((value) {
                      cubit.isBottomSheetShown = false;
                      // setState(() {
                      //   fabIcon = Icons.edit;
                      // });
                    });
                    cubit.isBottomSheetShown = true;
                    // setState(() {
                    //   fabIcon = Icons.add;
                    // });
                  }
                },
                child: Icon(
                  cubit.fabIcon,
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.task), label: 'Tasks'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.check_circle_outline), label: 'Done'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive_outlined), label: 'Archive'),
                ],
              ),
            );
          },
        ),
    );
  }
}
