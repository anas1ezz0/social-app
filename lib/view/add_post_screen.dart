
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_social_app/cubit/app_cubit.dart';
import 'package:new_social_app/cubit/app_status.dart';
import 'package:new_social_app/style/icon_broken.dart';

import '../style/colors.dart';

class AddPostScreen extends StatelessWidget {
   AddPostScreen({super.key});
var textCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStatus>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var usermodel = AppCubit.get(context).userModel;
        return  Scaffold(
          appBar: AppBar(
            title: const Text('Create Post'),
            actions: [
              TextButton(onPressed: ()
              {
                var now = DateTime.now();
if(AppCubit.get(context).postImage == null){
  AppCubit.get(context).createPost(dateTime: now.toString(), text: textCtrl.text);
}else{
  AppCubit.get(context).uploadPost(dateTime: now.toString(), text: textCtrl.text);
}
              }, child: Text('Post',style: TextStyle(color: defaultColor,),))
            ],
          ),
          body:   Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 15),
            child: Column(
              children: [
                if(state is AppCreatePostLoadingState)
                  const LinearProgressIndicator(color: defaultColor,),
                SizedBox(height: 10,),
                  Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          '${usermodel?.image}'
                      ),
                    ),
                    const SizedBox(width: 10,),
                    const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Anos Ezz',style: TextStyle(height: 1.4,fontSize: 17),
                                ),
                              ],
                            ),
                            Text('public',style: TextStyle(height: 1.4,color: Colors.grey),)
                          ],)),



                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textCtrl,
                    cursorColor: Colors.red.shade900,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                    decoration: const InputDecoration(
                        hintText: 'what is on your mind...',
                        enabled: true,
                        border: InputBorder.none


                    ),


                  ),
                ),
                if(AppCubit.get(context).postImage != null)
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      height: 170,
                      width: double.infinity,
                      decoration:  BoxDecoration(
                          borderRadius:  BorderRadius.circular(4.0),
                          image: DecorationImage(
                            image:  FileImage(AppCubit.get(context).postImage!)as ImageProvider,
                            fit: BoxFit.cover,

                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CircleAvatar(
                          backgroundColor: Colors.red[200],
                          radius: 20.0,
                          child: IconButton(onPressed: (){
                            AppCubit.get(context).removePostImage();

                          }, icon: const Icon(Icons.close,color: Colors.white,))),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextButton(
                            onPressed: (){
                              AppCubit.get(context).getPostImage();
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(IconBroken.Image,color: defaultColor,),
                                Text(
                                  ' Add photo',
                                  style: TextStyle(color: defaultColor,),
                                )
                              ],
                            )
                        )
                    ),
                    Expanded(
                        child: TextButton(
                            onPressed: (){}, child: Text('#tags',style: TextStyle(color: defaultColor,),))),
                  ],
                )
              ],
            ),
          ),
        );
      },

    );
  }
}
