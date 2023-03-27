import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/layout/cubit/app_states.dart';
import 'package:todo/modules/done_tasks/done_screen.dart';
import 'package:todo/modules/new_tasks/new_screen.dart';
import '../../modules/archived _tasks/archived_screen.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  int x = 0;
  List<String> title =
  [
    'new tasks',
    'done tasks',
    'archived tasks',
  ];
  List<Widget> screens =
  [
    const NewScreen(),
    const DoneScreen(),
    const ArchivedScreen(),
  ];
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  Database ? db;
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  void changeBottomNavBar(int index)
  {
    x = index;
    emit(ChangeBottomNavBar());
  }
  void changeFabIcon1()
  {
    fabIcon = Icons.edit;
    isBottomSheetShown = false;
    emit(ChangeFabIcon1());
  }
  void changeFabIcon2()
  {
    fabIcon = Icons.add;
    isBottomSheetShown = true;
    emit(ChangeFabIcon2());
  }
  void createDB()async
  {
    await openDatabase(
        'todo.db',
      version: 1,
      onCreate:(db,version)
      {
        if (kDebugMode) {
          print('Database Created');
        }
        db.execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY , task TEXT , time TEXT , date TEXT , status TEXT)',
        ).then((value)
        {
          emit(CreateBD());
          if (kDebugMode) {
            print('Table created');
          }
        }).catchError((error)
        {
          if (kDebugMode) {
            print('Error when create table  $error');
          }
        });
      },
      onOpen:(db)
     {
       getDB(db);
      if(kDebugMode)
      {
        print('Database opened');
      }
    }).then((value)
    {
     db = value;
    });
  }
  Future insertTODatabase({
    required String task,
    required String time,
    required String date,
  }) async
  {
    await db!.transaction((txn) async
    {
     await txn.rawInsert(
          'INSERT INTO tasks (task,time,date,status) VALUES ("$task","$time","$date","new")',
      ).then((value)
      {
        getDB (db);
       emit(InsertTOBD());
       if (kDebugMode)
       {
         print('$value Inserted successfully');
       }
     }).catchError((error)
     {
       if (kDebugMode) {
         print('Error when Inserting data $error');
       }
     });
    });
  }
  Future<List<Map>?>getDB(db)
  async {
    return await db?.rawQuery(
        'SELECT * FROM tasks'
    ).then((value)
    {
      newTasks = [];
      doneTasks = [];
      archivedTasks = [];
      value.forEach((element)
      {
        if(element['status']=='new')
        {
          newTasks.add(element);
          emit(GetBD());
        }else if(element['status']=='done')
        {
          doneTasks.add(element);
          emit(GetBD());
        }else
        {
          archivedTasks.add(element);
          emit(GetBD());
        }
      });
      if (kDebugMode)
      {
        print('database are gotten');
      }
      return null;
    });
  }

  Future<void> updateDB({
    required String status,
    required int id,
})
  async {
    await db!.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        [status,id]).then((value)
    {
      emit(UpdateBD());
      getDB(db);
    });
  }

  Future<void> deleteFromDB(int id)
  async {
    await db!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value)
    {
      emit(DeleteFromBD());
      getDB(db);
    });
  }
}