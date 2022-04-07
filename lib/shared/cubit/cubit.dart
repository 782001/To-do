
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/archived/archived.dart';
import 'package:todo_app/cubit/states.dart';
import 'package:todo_app/done/done.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/tasks/tasks.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());
static AppCubit get(context)=>BlocProvider.of(context);
  var currentIndex = 0;
  List<Widget>screen = [
    tasks_screen(),
    doneTasks_screen(),
    ArchivedTasks_screen(),
  ];
void changeIdex(int index){
  currentIndex=index;
emit(ChangeBottomNavBarState());
 }



  late Database database;
  List<Map> newtasks=[];
  List<Map> donetasks=[];
  List<Map> archivedtasks=[];


void CreatDataBase() async {
  database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        database.execute(
            'CREATE TABLE tasks(id INTEGER PRIMARY KEY ,title TEXT,time TEXT,date TEXT,status TEXT)')
            .then((value) {
          print('table created');
          emit(CreateDataBaseState());
        }).catchError((error) {
          print('error when creating table ${error.toString()}');
        });
      },
      onOpen: (database) {
        GetDataFromDataBase(database);
        print('database opened');
      }
  );
}

Future insertIntoDatabase({
  required String title,
  required String time,
  required String date,

}) async {
  await database.transaction((txn) async {
    await txn.rawInsert(
        'INSERT INTO tasks(title,time,date,status)VALUES("$title","$time","$date","NEW")')
        .then((value) {
      print('$value insert successfullllllllllllllllly');
     emit(insertDataBaseState());
      GetDataFromDataBase(database);
    })
        .catchError((error) {
      print('error when inserting ${error.toString()}');
    });
    return null;
  });
}

 void  GetDataFromDataBase(database)
{

  newtasks=[];
  donetasks=[];
  archivedtasks=[];
     database.rawQuery('SELECT * FROM tasks').then((value) {
       value.forEach((element) {
    if(element['status']=='NEW')
    newtasks.add(element);
    else if(element['status']=='done')
    donetasks.add(element);
    else archivedtasks.add(element);
                               });
       emit(GetDataBaseState());
      });
}
void UbdateDataFromDataBase({
  required String status,
  required int id
  }){
 database.rawUpdate(
      'UPDATE tasks SET status= ? WHERE id = ?',
      ['$status', id]

    ).then((value){print('ubdated');
        emit(UbdateDataBaseState());
        GetDataFromDataBase(database);
 });
}
  void DeleteDataFromDataBase({
    required int id
  }){
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]

    ).then((value){
      print('deleted');
    emit(DeleteDataBaseState());
    GetDataFromDataBase(database);
    });
  }
  bool isBottomSheetshown = false;
  IconData fabIcon = Icons.edit;


  void showBottomSheet({
  required bool isShow ,
  required IconData icon,

        }){
    isBottomSheetshown= isShow;
    fabIcon=icon;
emit(ChangeBottomSheetState()) ;
  }

}