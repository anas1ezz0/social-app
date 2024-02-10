
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../compo/compo.dart';
import '../cubit/app_cubit.dart';
import '../cubit/app_status.dart';
import '../style/icon_broken.dart';
import 'add_post_screen.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStatus>(
      listener: (context, state) {
        if(state is AppGoToPostState){
          navigateTo(context,  AddPostScreen());
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(onPressed: (){}, icon: const Icon(IconBroken.Notification)),
              IconButton(onPressed: (){}, icon: const Icon(IconBroken.Search)),
            ],
          ),
body: cubit.screens[cubit.currentIndex],
bottomNavigationBar: BottomNavigationBar(
  onTap: (index){
    cubit.changeBottomNav(index);
  },
    currentIndex: cubit.currentIndex,
    items:  const [
      BottomNavigationBarItem(
       icon: Icon(IconBroken.Home),label: 'Home',
       ),
      BottomNavigationBarItem(
       icon: Icon(IconBroken.Chat),label: 'Chat',
       ),
      BottomNavigationBarItem(
        icon: Icon(IconBroken.Paper_Upload),label: 'Add post',
      ),
      BottomNavigationBarItem(
       icon: Icon(IconBroken.user),label: 'User',
       ),
      BottomNavigationBarItem(
       icon: Icon(IconBroken.Setting),label: 'Setting',
       ),
    ] )

        );
      },

    );
  }
}
