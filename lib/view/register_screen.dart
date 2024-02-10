import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../compo/compo.dart';
import '../Register_bloc/register_cubit.dart';
import '../Register_bloc/register_status.dart';
import 'home_layout.dart';


class RegisterScreen extends StatelessWidget {
   RegisterScreen({super.key});
  var formKey =  GlobalKey<FormState>();
   var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocProvider(
          create: (context) => SocialRegisterCubit(),
          child: BlocConsumer<SocialRegisterCubit,SocialRegisterState>(
            listener: (context, state) {
if(state is SocialCreatUserSuccsessState)
{
 navigateAndFinsh(context, HomePage());
}
            },
            builder: (context, state) {
              return Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Register' ,
                            style: TextStyle
                              (
                                fontSize: 30 ,
                                fontWeight: FontWeight.bold),),
                          const SizedBox(height: 15,),
                          const Text('Register to show our offers' ,),
                          const SizedBox(height: 15,),
                          defaultFormField(
                              controller: nameController,
                              type: TextInputType.name,
                              validate: (String value){
                                if(value.isEmpty){
                                  return 'Name must not be empty';
                                }
                              },
                              label: 'Name',
                              prefix: Icons.person),
                          const  SizedBox(height: 25,),
                          defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (String value){
                                if(value.isEmpty){
                                  return 'Email must not be empty';
                                }
                              },
                              label: 'Email',
                              prefix: Icons.email),
                          const  SizedBox(height: 15,),
                          defaultFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              validate: (String value){
                                if(value.isEmpty){
                                  return 'password must not be empty';
                                }
                              },
                              label: 'password',
                              prefix: Icons.lock_outline,
                              suffix: SocialRegisterCubit.get(context).suffix,
                              isPassword: SocialRegisterCubit.get(context).isPassword,
                              suffixPressed: (){
                                SocialRegisterCubit.get(context).changePasswordVisibility();
                              }
                          ),
                          const  SizedBox(height: 15,),
                          defaultFormField(
                              controller: phoneController,
                              type: TextInputType.phone,
                              validate: (String value){
                                if(value.isEmpty){
                                  return 'phone must not be empty';
                                }
                              },
                              label: 'phone',
                              prefix: Icons.phone),
                          const  SizedBox(height: 22,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ConditionalBuilder(
                              condition: state is! SocialRegisterLoadingState,
                              builder: (context) => defaultButton(function: (){
                                if(formKey.currentState!.validate()){
                                  SocialRegisterCubit.get(context).userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                  );
                                }

                              }, text: 'Register',isUpperCase: true),
                              fallback: (context) =>const Center(child: CircularProgressIndicator(color: Colors.teal,)),
                            ),
                          ),
                        ],),
                    ),
                  ),
                ),
              );
            },

          ),
        )
    );
  }
}
