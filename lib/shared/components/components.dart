import 'package:flutter/material.dart';
import 'package:todo_app/shared/Cubit/Cubit.dart';

Widget defaultformfield({
  @required TextInputType type,
  @required TextEditingController conttroller,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required IconData prefx,
  @required Function validate,
  @required String lable,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      enabled: isClickable,
      controller: conttroller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: lable,
        icon: Icon(prefx),
        suffix: IconButton(
          icon: Icon(suffix),
          onPressed: suffixPressed as Function(),
        ),
      ),
    );

Widget buildTaskItem(Map model, context) => Dismissible(
      background: Container(
        color: Colors.red,
        child: Center(child: Text('delete', style: TextStyle(fontSize: 20))),
      ),
      key: Key(model['id'].toString()),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text('${model['time']}'),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateData('done', model['id']);
              },
              icon: Icon(
                Icons.check_box,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateData('archive', model['id']);
              },
              icon: Icon(
                Icons.archive,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(model['id']);
      },
    );

Widget buildNounTasksWidget() => Center(
      child: Text(
        "you don't have tasks",
        style: TextStyle(fontSize: 25),
      ),
    );

Widget buildListTasks(List tasks) {
  return tasks.length == 0
      ? buildNounTasksWidget()
      : ListView.separated(
          itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
          separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsetsDirectional.only(start: 20),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                ),
              ),
          itemCount: tasks.length);
}
