import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../compo/compo.dart';
import '../cubit/app_cubit.dart';
import '../cubit/app_status.dart';
import '../style/colors.dart';
import '../style/icon_broken.dart';


class EditScreen extends StatelessWidget {
   EditScreen({super.key});
var nameCtrl = TextEditingController();
var bioCtrl = TextEditingController();
var phoneCtrl = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStatus>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = AppCubit.get(context).userModel;
        var profileImage = AppCubit.get(context).profileImage;
        var coverImage = AppCubit.get(context).coverImage;

        nameCtrl.text = userModel!.name!;
        phoneCtrl.text = userModel.phone!;
        bioCtrl.text = userModel.bio!;

      return  Scaffold(
            appBar: AppBar(
              title: const Text(
                  'Edit Profile'),
              leading:  IconButton(
                  onPressed: (){Navigator.pop(context);}, icon: const Icon(IconBroken.Arrow___Left_2)),
              actions: [
                TextButton(
                    onPressed: ()
                    {
                  AppCubit.get(context).updateUser(
                      name: nameCtrl.text,
                      bio: bioCtrl.text,
                      phone : phoneCtrl.text
                  );
                  AppCubit.get(context).uploadProfileImage(
                      name:nameCtrl.text, phone:   phoneCtrl.text, bio: bioCtrl.text
                  );
                  AppCubit.get(context).uploadCoverImage(name: nameCtrl.text, phone: phoneCtrl.text, bio: bioCtrl.text);
                }, child: const Text(
                  'UPDATE',style: TextStyle(color: defaultColor),)),
                const SizedBox(
                  width: 5,)
              ],
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (state is AppUserUpdateLoadingState || state is AppUploadProfileImageLoadingState || state is  AppUploadCoverImageLoadingState)
                      const LinearProgressIndicator(),
                    if (state is AppUserUpdateLoadingState || state is AppUploadProfileImageLoadingState || state is  AppUploadCoverImageLoadingState)
                      const SizedBox(
                        height: 10.0,
                      ),
                    SizedBox(
                      height: 210,
                      child:  Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                  height: 170,
                                  width: double.infinity,
                                  decoration:  BoxDecoration(
                                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(4.0),topRight: Radius.circular(4.0)),
                                      image: DecorationImage(
                                        image: coverImage == null ? NetworkImage(
                                            '${userModel.cover}') :  FileImage(coverImage)as ImageProvider,
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
                                        AppCubit.get(context).getCoverImage();
                                      }, icon: const Icon(IconBroken.Camera,color: Colors.white,))),
                                )
                              ],
                            ),
                          ),
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                radius: 64,
                                backgroundColor: Colors.white,
                                child:  CircleAvatar(
                                  radius: 60.0,
                                  backgroundImage: profileImage == null
                                      ? NetworkImage(
                                    '${userModel.image}',
                                  ) : FileImage(profileImage)as ImageProvider,
                                )
                              ),
                              IconButton(onPressed: (){
                                AppCubit.get(context).getProfileImage();
                              }, icon: CircleAvatar(
                                backgroundColor: Colors.red[200],
                                  child: const Icon(IconBroken.Camera,color: Colors.white,))),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: defaultFormField(
                          controller: nameCtrl,
                          type: TextInputType.text,
                          validate: (String value){
                            if (value.isEmpty){
                              return 'name must not be empty';
                            }
                          },
                          label: 'Name',
                          prefix: IconBroken.User1
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: defaultFormField(
                          controller: bioCtrl,
                          type: TextInputType.text,
                          validate: (String value){
                            if (value.isEmpty){
                              return 'bio must not be empty';
                            }
                          },
                          label: 'Bio',
                          prefix: IconBroken.Info_Circle
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: defaultFormField(
                          controller: phoneCtrl,
                          type: TextInputType.phone,
                          validate: (String value){
                            if (value.isEmpty){
                              return 'phone must not be empty';
                            }
                          },
                          label: 'Phone',
                          prefix: IconBroken.Call
                      ),
                    ),
                  ],
                ),
              ),
            ),
        );
      },

    );
  }
}
