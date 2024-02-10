import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_social_app/cubit/app_cubit.dart';
import 'package:new_social_app/cubit/app_status.dart';
import 'package:new_social_app/model/post_model.dart';

import '../style/colors.dart';
import '../style/icon_broken.dart';


class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<AppCubit,AppStatus>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: AppCubit.get(context).posts.length > 0 && AppCubit.get(context).userModel != null,
          builder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        const Image(
                            image: NetworkImage(
                                'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg'),
                            fit: BoxFit.cover,
                            height: 200.0,
                            width: double.infinity
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'communicate with friends',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(

                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>buildPostItem(AppCubit.get(context).posts[index],context,index) ,
                    separatorBuilder: (context, index) => const SizedBox(height: 8,),
                    itemCount: AppCubit.get(context).posts.length,
                  ),
                  SizedBox(height: 8,)

                ]
            ),
          ),
          fallback: (context) => const Center(child:  CircularProgressIndicator(color: defaultColor,)),

        );
      },

    );
  }
  Widget buildPostItem(PostUserModel model ,context ,index)=>  Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      margin: const EdgeInsets.all(
        8.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                              '${model.name}',style: TextStyle(height: 1.4),
                            ),
                            SizedBox(width: 10,),
                            Icon(Icons.check_circle,size: 17,color: defaultColor,)
                          ],
                        ),
                        Text(
                          '${model.dateTime}',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              height: 1.4,
                              color: Colors.grey
                          ),
                        )
                      ],)),
                const SizedBox(width: 10,),
                 IconButton(onPressed: (){}, icon: const Icon(Icons.more_horiz))

              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                height: 1,
                color: Colors.grey,
                width: double.infinity,
              ),
            ),
             Text(
                '${model.text}',
              style: const TextStyle(height: 1.3,fontWeight: FontWeight.w100),),
            // Padding(
            //   padding: const EdgeInsetsDirectional.only(bottom: 10,top: 5),
            //   child: SizedBox(
            //     width: double.infinity,
            //     child: Wrap(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(end: 6.0),
            //           child: SizedBox(
            //             height: 22,
            //             child: MaterialButton(
            //               padding: EdgeInsets.zero,
            //               minWidth: 1.0,
            //               onPressed: (){},child: const Text(
            //               '#Software',
            //               style: TextStyle(color: defaultColor,fontWeight: FontWeight.w800),),),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(end: 6.0),
            //           child: SizedBox(
            //             height: 22,
            //             child: MaterialButton(
            //               padding: EdgeInsets.zero,
            //               minWidth: 1.0,
            //               onPressed: (){},child: const Text('#Software',style: TextStyle(color: defaultColor,fontWeight: FontWeight.w800),),),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(end: 6.0),
            //           child: SizedBox(
            //             height: 22,
            //             child: MaterialButton(
            //               padding: EdgeInsets.zero,
            //               minWidth: 1.0,
            //               onPressed: (){},child: const Text('#Software',style: TextStyle(color: defaultColor,fontWeight: FontWeight.w800),),),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(end: 6.0),
            //           child: SizedBox(
            //             height: 22,
            //             child: MaterialButton(
            //               padding: EdgeInsets.zero,
            //               minWidth: 1.0,
            //               onPressed: (){},child: const Text('#Software',style: TextStyle(color: defaultColor,fontWeight: FontWeight.w800),),),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(end: 6.0),
            //           child: SizedBox(
            //             height: 22,
            //             child: MaterialButton(
            //               padding: EdgeInsets.zero,
            //               minWidth: 1.0,
            //               onPressed: (){},child: const Text('#Software',style: TextStyle(color: defaultColor,fontWeight: FontWeight.w800),),),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(end: 6.0),
            //           child: SizedBox(
            //             height: 22,
            //             child: MaterialButton(
            //               padding: EdgeInsets.zero,
            //               minWidth: 1.0,
            //               onPressed: (){},child: const Text('#Software',style: TextStyle(color: defaultColor,fontWeight: FontWeight.w800),),),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(end: 6.0),
            //           child: SizedBox(
            //             height: 22,
            //             child: MaterialButton(
            //               padding: EdgeInsets.zero,
            //               minWidth: 1.0,
            //               onPressed: (){},child: const Text('#Software',style: TextStyle(color: defaultColor,fontWeight: FontWeight.w800),),),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            if(model.postImage != '')
            Container(
              height: 160.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image:   DecorationImage(
                    image: NetworkImage(
                        '${model.postImage}'
                    ),
                    fit: BoxFit.cover,

                  )
              ),
            ),
            const SizedBox(height: 13,),
            Row(
              children: [
                const Icon(IconBroken.Heart,color: Colors.red,size: 16,),
                Text('${AppCubit.get(context).likes[index]}',
                  style: Theme.of(context).textTheme.bodySmall,),
                const Spacer(),
                const Icon(IconBroken.Chat,color: Colors.amber,size: 16,),
                Text("0 Comments",style: Theme.of(context).textTheme.bodySmall,),
              ],),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 1,
                color: Colors.grey,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(

                    child: Row(
                      children: [
                         CircleAvatar(
                          radius: 15.0,
                          backgroundImage: NetworkImage(
                              '${AppCubit.get(context).userModel?.image}'
                          ),
                        ),
                        const SizedBox(width: 10,),

                        Text(
                          'writ your comment ...',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              height: 1.4,
                              color: Colors.grey
                          ),
                        )
                      ],
                    ),
                    onTap: (){},
                  ),
                ),
                InkWell(
                  child: Row(
                    children: [
                      const Icon(
                        IconBroken.Heart,
                        size: 16.0,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'Like',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  onTap: () {
                    AppCubit.get(context).likePost(AppCubit.get(context).postsId[index]);
                  },
                ),
              ],
            )
          ],
        ),
      )
  );
}
