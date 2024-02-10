import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_social_app/compo/compo.dart';
import 'package:new_social_app/cubit/app_cubit.dart';
import 'package:new_social_app/cubit/app_status.dart';
import 'package:new_social_app/model/social_user_model.dart';
import 'package:new_social_app/style/colors.dart';
import 'package:new_social_app/view/chat_screen_details.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppStatus>(
      listener: (context, state) {},
      builder: (context, state) {
        return  ConditionalBuilder(
          condition: AppCubit.get(context).users.length > 0,
          builder: (context) =>  ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildChatItem(AppCubit.get(context).users[index],context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: AppCubit.get(context).users.length,
          ) ,
          fallback: (context) => const Center(child: CircularProgressIndicator(color: defaultColor,)),

        );
      },

    ) ;
  }
  Widget buildChatItem(SocialUserModel model,context)=> InkWell(
    onTap: (){
      navigateTo(context, ChatScreenDetails(userModel: model));
    },
    child:  Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(
                '${model.image}'
            ),
          ),
          const SizedBox(width: 10,),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${model.name}',style: const TextStyle(height: 1.4),
                      ),
                      const SizedBox(width: 10,),

                    ],
                  ),

                ],)),



        ],
      ),
    ),
  );
}