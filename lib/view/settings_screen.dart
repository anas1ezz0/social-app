import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../compo/compo.dart';
import '../cubit/app_cubit.dart';
import '../cubit/app_status.dart';
import '../style/colors.dart';
import 'edit_screen.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppStatus>(
      listener: (context, state) {},
      builder: (context, state) {
        var usermodel = AppCubit.get(context).userModel;
        return  Column(
          children: [
            SizedBox(
              height: 210,
              child:  Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 170,
                      width: double.infinity,
                      decoration:   BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(4.0),topRight: Radius.circular(4.0)),
                          image: DecorationImage(
                            image:  NetworkImage(
                              // 'https://img.freepik.com/free-photo/mountain-landscape_1048-3244.jpg?w=1380&t=st=1699368929~exp=1699369529~hmac=c5f354fe1e7deea93d6c39a95d2f88bb62a8be9412137e4d381b5f02e8b1959d'
                                '${usermodel?.cover}'
                            ),
                            fit: BoxFit.cover,

                          )
                      ),
                    ),
                  ),
                    CircleAvatar(
                    radius: 64,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 60.0,
                      backgroundImage: NetworkImage(
                        // 'https://img.freepik.com/free-photo/mountain-landscape_1048-3244.jpg?w=1380&t=st=1699368929~exp=1699369529~hmac=c5f354fe1e7deea93d6c39a95d2f88bb62a8be9412137e4d381b5f02e8b1959d'
                          '${usermodel?.image}'
                      ),
                    ),
                  ),
                ],
              ),
            ),
             SizedBox(height: 5,),
            Text(
        '${usermodel?.name}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
        '${usermodel?.bio}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 5,),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                        children: [
                          Text('30'),
                          Text('post'),
                        ],)),
                  Expanded(
                      child: Column(
                        children: [
                          Text('20'),
                          Text('video'),
                        ],)),
                  Expanded(
                      child: Column(
                        children: [
                          Text('1K'),
                          Text('Followers'),
                        ],)),
                  Expanded(
                      child: Column(
                        children: [
                          Text('50'),
                          Text('Following'),
                        ],)),
                ],
              ),
            ),
            const SizedBox(height: 8,),
            Row(
              children: [
                Expanded(child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: OutlinedButton(
                    onPressed: (){},
                    child:const Text('Add Photo',style: TextStyle(color: defaultColor),),

                  ),
                )),
                const SizedBox(width: 8,),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: OutlinedButton(onPressed: (){navigateTo(context, EditScreen());}, child:const Icon(Icons.edit,color: defaultColor,)),
                ),
              ],
            )
          ],
        );
      },

    );
  }
}