import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:todo/layout/cubit/cubit.dart';

Widget taskItem(List<Map> t ,int index, context)
{
  if (t[index]['status']=='new')
  {
    return SwipeTo(
      onRightSwipe: ()
      {
        AppCubit.get(context).deleteFromDB(t[index]['id']);
      },
      onLeftSwipe: ()
      {
        AppCubit.get(context).deleteFromDB(t[index]['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children:
          [
            CircleAvatar(
              radius: 40,
              child: Text(
                '${t[index]['time']}',
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Text(
                    '${t[index]['task']}',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    '${t[index]['date']}',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: ()
                {
                  AppCubit.get(context).updateDB(
                      status: 'done',
                      id: t[index]['id'] );
                },
                icon: const Icon(
                  Icons.check_box_outlined,
                  color: Colors.green,
                )
            ),
            IconButton(
                onPressed: ()
                {
                  AppCubit.get(context).updateDB(
                      status: 'archived',
                      id: t[index]['id']);
                },
                icon: const Icon(
                  Icons.archive_outlined,
                  color: Colors.black54,
                )
            ),
          ],
        ),
      ),
    );
  }else if (t[index]['status']=='done')
  {
    return SwipeTo(
      onRightSwipe: ()
      {
        AppCubit.get(context).deleteFromDB(t[index]['id']);
      },
      onLeftSwipe: ()
      {
        AppCubit.get(context).deleteFromDB(t[index]['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children:
          [
            CircleAvatar(
              radius: 40,
              child: Text(
                '${t[index]['time']}',
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Text(
                    '${t[index]['task']}',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    '${t[index]['date']}',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: ()
                {
                  AppCubit.get(context).updateDB(
                      status: 'archived',
                      id: t[index]['id']);
                },
                icon: const Icon(
                  Icons.archive_outlined,
                  color: Colors.black54,
                )
            ),
          ],
        ),
      ),
    );
  }else
  {
   return SwipeTo(
     onRightSwipe: ()
     {
       AppCubit.get(context).deleteFromDB(t[index]['id']);
     },
     onLeftSwipe: ()
     {
       AppCubit.get(context).deleteFromDB(t[index]['id']);
     },
     child: Padding(
       padding: const EdgeInsets.all(15.0),
       child: Row(
         children:
         [
           CircleAvatar(
             radius: 40,
             child: Text(
               '${t[index]['time']}',
             ),
           ),
           const SizedBox(
             width: 15,
           ),
           Expanded(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children:
               [
                 Text(
                   '${t[index]['task']}',
                   style: const TextStyle(
                       fontSize: 20,
                       fontWeight: FontWeight.bold
                   ),
                 ),
                 const SizedBox(
                   height: 15,
                 ),
                 Text(
                   '${t[index]['date']}',
                   style: const TextStyle(
                     color: Colors.grey,
                   ),
                 ),
               ],
             ),
           ),
           IconButton(
               onPressed: ()
               {
                 AppCubit.get(context).updateDB(
                     status: 'done',
                     id: t[index]['id'] );
               },
               icon: const Icon(
                 Icons.check_box_outlined,
                 color: Colors.green,
               )
           ),
         ],
       ),
     ),
   );
  }
}