import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_social_app/cubit/app_cubit.dart';
import 'package:new_social_app/cubit/app_status.dart';
import 'package:new_social_app/model/chat_model.dart';
import 'package:new_social_app/style/colors.dart';
import 'package:new_social_app/style/icon_broken.dart';

import '../model/social_user_model.dart';

class ChatScreenDetails extends StatelessWidget {

  SocialUserModel userModel;
  ChatScreenDetails({required this.userModel});
  var messageCtrl = TextEditingController();
  var clear = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AppCubit.get(context).getMessages(receiverId: userModel.uId!);

            return  BlocConsumer<AppCubit,AppStatus>(
              listener: (context, state) {},
              builder: (context, state) {
                return  Scaffold(
                  appBar: AppBar(
                    titleSpacing: 0.0,
                    title: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              '${userModel.image}'
                          ),
                        ),
                        const SizedBox(width: 15.0,),
                        Text('${userModel.name}')
                      ],
                    ),
                  ),
                  body: ConditionalBuilder(
                    condition: AppCubit.get(context).messages.length>0,
                    builder: (context) => Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var message = AppCubit.get(context).messages[index];
                                      if(AppCubit.get(context).userModel!.uId == message.senderId){
                                        return buildMydMessage(message);
                                      }else{
                                        return buildMessage(message);
                                      }
                                },
                                separatorBuilder: (context, index) => SizedBox(height: 15,),
                                itemCount: AppCubit.get(context).messages.length
                            ),
                          ),
                     const SizedBox(height: 15,),
                          Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey[300]!,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                      child: TextFormField(
                                        controller: messageCtrl,
                                        decoration: const InputDecoration(
                                            hintText: 'Message',
                                            border: InputBorder.none
                                        ),

                                      ),
                                    )),
                                Container(
                                  color: Colors.grey[200],
                                  child: IconButton(
                                      onPressed: (){
                                        AppCubit.get(context).sendMessage(
                                            receiverId: userModel.uId!,
                                            dateTime: DateTime.now().toString(),
                                            text: messageCtrl.text
                                        );
                                        messageCtrl.clear();
                                      }, icon: Icon(IconBroken.Send,color: defaultColor,)),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ) ,
                     fallback: (context) => const Center(child: CircularProgressIndicator(color: defaultColor,)),

                  ),
                );
              },

            );
      } ,

    );
  }
  Widget buildMessage(ChatModel model)=>  Align(
    alignment: Alignment.centerLeft,
    child: Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
          color: Colors.grey[300]
      ),
      padding: const EdgeInsets.symmetric(vertical: 5 , horizontal: 10),
      child:  Text('${model.text}'),
    ),
  );
  Widget buildMydMessage(ChatModel model)=>  Align(
    alignment: Alignment.centerRight,
    child: Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
          color: Colors.red[200]
      ),
      padding: const EdgeInsets.symmetric(vertical: 5 , horizontal: 10),
      child:  Text('${model.text}'),
    ),
  );
}
