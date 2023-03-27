import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/layout/cubit/app_states.dart';
import '../../layout/cubit/cubit.dart';
import '../../shared/shared_component/shared_component.dart';
class ArchivedScreen extends StatelessWidget {
  const ArchivedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state)
        {
        if (AppCubit.get(context).archivedTasks.isEmpty)
        {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const
              [
                Icon(
                  Icons.menu,
                  size: 100,
                  color: Colors.grey,
                ),
                SizedBox(height: 10,),
                Text(
                  'No tasks here yet , please enter new tasks',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          );
        }else
        {
          return ListView.separated(
    itemBuilder: (context,index) => taskItem(AppCubit.get(context).archivedTasks,index,context),
    separatorBuilder:(context,index) => Padding(
    padding: const EdgeInsetsDirectional.only(start: 15.0),
    child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey,
    ),
    ),
    itemCount:AppCubit.get(context).archivedTasks.length,
    );
        }
        }
        );
  }
}
