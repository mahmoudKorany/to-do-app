import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/layout/cubit/app_states.dart';
import 'package:todo/layout/cubit/cubit.dart';
class AppHome extends StatelessWidget {
  const AppHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    var formKey = GlobalKey<FormState>();
    var taskController = TextEditingController();
    var timeController = TextEditingController();
    var dateController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDB(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context , state) => Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title :  Text(
              AppCubit.get(context).title[AppCubit.get(context).x],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed:()
            async{
              if(AppCubit.get(context).isBottomSheetShown)
              {
               if(formKey.currentState!.validate())
               {
                 await AppCubit.get(context).insertTODatabase(
                     task: taskController.text,
                     time: timeController.text,
                     date: dateController.text).then((value)
                 {
                   AppCubit.get(context).changeFabIcon1();
                   Navigator.pop(context);
                 });
               }

              }else
              {
                AppCubit.get(context).changeFabIcon2();
                scaffoldKey.currentState!.showBottomSheet((context) =>
                    Form(
                      key: formKey,
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadiusDirectional.only(
                              topEnd: Radius.circular(30),
                              topStart: Radius.circular(30),
                            )
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children:
                          [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: TextFormField(
                                validator: (value)
                                {
                                  if (value!.isEmpty)
                                  {
                                    return 'task title must not be empty';
                                  }
                                  return null;
                                },
                                controller: taskController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.table_rows_rounded,
                                  ),
                                  border: OutlineInputBorder(),
                                  label: Text(
                                    'task title',
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: TextFormField(
                                onTap: ()
                                {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value)
                                  {
                                    timeController.text = value!.format(context);
                                  });
                                },
                                validator: (value)
                                {
                                  if (value!.isEmpty)
                                  {
                                    return 'time title must not be empty';
                                  }
                                  return null;
                                },
                                controller: timeController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.watch_later_outlined,
                                  ),
                                  border: OutlineInputBorder(),
                                  label: Text(
                                    'time title',
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: TextFormField(
                                onTap: ()
                                {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate:DateTime.parse('2023-19-30'),
                                  ).then((value)
                                  {
                                    dateController.text = DateFormat.yMMMd().format(value!);
                                  });
                                },
                                validator: (value)
                                {
                                  if (value!.isEmpty)
                                  {
                                    return 'date title must not be empty';
                                  }
                                  return null;
                                },
                                controller: dateController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.date_range_outlined,
                                  ),
                                  border: OutlineInputBorder(),
                                  label: Text(
                                    'date title',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ).closed.then((value)
                {
                  AppCubit.get(context).changeFabIcon1();
                });
              }
            },
            child: Icon(
              AppCubit.get(context).fabIcon,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: AppCubit.get(context).x,
            onTap: (value)
            {
              AppCubit.get(context).changeBottomNavBar(value);
            },
            items:
            const [
              BottomNavigationBarItem(
                icon:  Icon(Icons.menu),
                label: 'new tasks',
              ),
              BottomNavigationBarItem(
                icon:  Icon(Icons.check_circle_outline),
                label: 'done tasks',
              ),
              BottomNavigationBarItem(
                icon:  Icon(Icons.archive_outlined),
                label: 'archived tasks',
              ),
            ],
          ),
          body: AppCubit.get(context).screens[AppCubit.get(context).x],
        ),
      ),
    );
  }
}
