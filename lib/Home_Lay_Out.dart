
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/archived/archived.dart';
import 'package:todo_app/cubit/cubit.dart';
import 'package:todo_app/cubit/states.dart';
import 'package:todo_app/done/done.dart';
import 'package:todo_app/shared/components.dart';
import 'package:todo_app/shared/conestans.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/tasks/tasks.dart';

class homeLAyOut extends StatelessWidget {
  @override




  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var ScafoldKey = GlobalKey<ScaffoldState>();
  var FormKey = GlobalKey<FormState>();





  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context)=>AppCubit()..CreatDataBase(),
        child: BlocConsumer<AppCubit ,AppStates>(
          listener: (context,state){
            if (state is insertDataBaseState){
              Navigator.pop(context);
            }
          },
          builder: (context,state){
            return Scaffold(
              key: ScafoldKey,
              appBar: AppBar(
                title: Text('todo app'),
              ),
              body: AppCubit.get(context).screen[AppCubit.get(context).currentIndex],
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (AppCubit.get(context).isBottomSheetshown) {
                    if (FormKey.currentState!.validate()) {
                   AppCubit.get(context).insertIntoDatabase(
                       title: titleController.text,
                       time: timeController.text,
                       date: dateController.text
                   );

                    }
                    }
                   else {
                    ScafoldKey.currentState!.showBottomSheet((context) =>
                        Padding(
                          padding: const EdgeInsets.all(12.0),

                          child: Container(

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[300],
                            ),
                            child: Form(
                              key: FormKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: ' Task Title',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0)
                                      ),
                                      prefixIcon: Icon(Icons.title),

                                    ),
                                    keyboardType: TextInputType.text,
                                    controller: titleController,
                                    onTap: () {
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'title must not be empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: ' Task Time',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0)
                                      ),
                                      prefixIcon: Icon(Icons.watch_later_outlined),

                                    ),
                                    keyboardType: TextInputType.datetime,
                                    controller: timeController,
                                    onTap: () {
                                      showTimePicker(context: context,
                                          initialTime: TimeOfDay.now()).then((value) {
                                        timeController.text =
                                            value!.format(context).toString();
                                      });
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'time must not be empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: ' Task Date',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0)
                                      ),
                                      prefixIcon: Icon(Icons.date_range),

                                    ),
                                    keyboardType: TextInputType.text,
                                    controller: dateController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'date must not be empty';
                                      }
                                      return null;
                                    },
                                    onTap: () {
                                      showDatePicker(context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse('3022-08-07'),
                                      ).then((value) {
                                        dateController.text =
                                            DateFormat.MMMd().format(value!);
                                      });
                                    },

                                  ),
                                ],
                              ),
                            ),
                          ),
                        )).closed.then((value) {
                     AppCubit.get(context).showBottomSheet(
                         isShow: false,
                         icon: Icons.edit
                     );
                    });
                    AppCubit.get(context).showBottomSheet(
                        isShow: true,
                        icon: Icons.add);
                  }},

                child: Icon(
                  AppCubit.get(context).fabIcon,
                ),
              ),

              bottomNavigationBar:
              BottomNavigationBar(
                onTap: (index) {
                  AppCubit.get(context).changeIdex(index);
                },
                currentIndex: AppCubit.get(context).currentIndex,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                      icon: (
                          Icon(
                            Icons.badge_sharp,
                          )
                      ),
                      label: 'tasks'
                  ),
                  BottomNavigationBarItem(label: 'done',

                    icon: (Icon(
                      Icons.done,
                    )
                    ),
                  ),
                  BottomNavigationBarItem(label: 'archived',
                    icon: (
                        Icon(
                          Icons.archive,
                        )
                    ),

                  ),
                ],
              ),
            );



          },
        )
    );
  }




}

