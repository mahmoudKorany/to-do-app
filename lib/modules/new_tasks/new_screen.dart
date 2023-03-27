import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/layout/cubit/app_states.dart';
import 'package:todo/layout/cubit/cubit.dart';
import '../../shared/shared_component/shared_component.dart';
class NewScreen extends StatelessWidget {
  const NewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state) {},
        builder: (context,state)
        {
          if (AppCubit.get(context).newTasks.isEmpty)
        {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const
              [
                Icon(
                  Icons.menu,
                  size: 100,
                  color: Colors.grey
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
        } else
        {
          return BlocConsumer<AppCubit,AppStates>(
            listener: (context,stata){},
            builder: (context,state)=>ListView.separated(
              itemBuilder: (context,index) => taskItem(AppCubit.get(context).newTasks,index,context),
              separatorBuilder:(context,index) => Padding(
                padding: const EdgeInsetsDirectional.only(start: 15.0),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                ),
              ),
              itemCount: AppCubit.get(context).newTasks.length,
            ),
          );
        }
        }
      );
  }
}
