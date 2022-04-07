

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/components.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class doneTasks_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit ,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        return
          ListView.separated(
              itemBuilder: (context,index )=>buildTaskItem(AppCubit.get(context).donetasks[index],context),
              separatorBuilder: (context,index )=>Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: 20
                ),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                ),
              ),
              itemCount: AppCubit.get(context).donetasks.length);
      },
    );
  }


}