import 'package:flutter/material.dart';
import 'package:todo_app/shared/cubit/cubit.dart';

Widget buildTaskItem(Map model,context)=> Dismissible(
  key: Key(model['id'].toString()),
  onDismissed: (direction){
AppCubit.get(context).DeleteDataFromDataBase(id: model['id']);
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        CircleAvatar(

          radius: 40,

          backgroundColor: Colors.indigo,

          child: Text('${model ['time']} ',

            style: TextStyle(

                color: Colors.white,

            ),

          ),

        ),

        SizedBox(

          width: 10,

        ),

        Expanded(

          child: Column(

            mainAxisSize: MainAxisSize.min,

            children: [

              Text('${model['title']}',

                style: TextStyle(

                    fontSize: 20,

                    fontWeight: FontWeight.bold,

                    color: Colors.black

                ),

                maxLines: 1,

                overflow: TextOverflow.ellipsis,

              ),

              Text('${model ['date']}',

                style: TextStyle(





                    color: Colors.grey

                ),

              ),

            ],

          ),

        ),

        SizedBox(

          width: 10,

        ),

        IconButton(onPressed: (){

          AppCubit.get(context).UbdateDataFromDataBase(status: 'done', id: model['id']);

        },

            icon: Icon(

              Icons.check_box,

              color:Colors.red ,



            )

        ),

        IconButton(onPressed: ()

        {

          AppCubit.get(context).UbdateDataFromDataBase(status: 'archived', id: model['id']);



        },

            icon: Icon(

              Icons.archive,

              color:Colors.blueGrey ,



            )

        )

      ],

    ),

  ),
);