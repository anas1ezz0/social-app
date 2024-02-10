import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_social_app/view/register_screen.dart';
import '../CashHelper/cash_helper.dart';
import '../compo/compo.dart';
import '../login_bloc/login_cubit.dart';
import '../login_bloc/login_status.dart';
import 'home_layout.dart';

// ignore: must_be_immutable
class SocialLoginScreen extends StatelessWidget {
  SocialLoginScreen({super.key});

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginState>(
        listener: ((context, state) {
          if (state is SocialLoginErrorState) {
            print('dasdfsdsfsf');
            // showToast(text: state.error, state: ToastStates.error);
          }
          if (state is SocialLoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              navigateAndFinsh(context, const HomePage());
            });
          }
        }),
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Login to show our offers',
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'Email must not be empty';
                                }
                              },
                              label: 'Email',
                              prefix: Icons.email),
                          const SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'password must not be empty';
                                }
                              },
                              label: 'password',
                              prefix: Icons.lock_outline,
                              onSubmit: (value) {
                                if (formKey.currentState!.validate()) {
                                  SocialLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              suffix: SocialLoginCubit.get(context).suffix,
                              isPassword:
                                  SocialLoginCubit.get(context).isPassword,
                              suffixPressed: () {
                                SocialLoginCubit.get(context)
                                    .changePasswordVisibility();
                              }),
                          const SizedBox(
                            height: 22,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ConditionalBuilder(
                              condition: state is! SocialLoginLoadingState,
                              builder: (context) => defaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      SocialLoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                  text: 'Login',
                                  isUpperCase: true),
                              fallback: (context) => const Center(
                                  child: CircularProgressIndicator(
                                color: Colors.red,
                              )),
                            ),
                          ),
                          Row(
                            children: [
                              const Text(' you don\'t have am email?'),
                              TextButton(
                                  onPressed: () {
                                    navigateTo(context, RegisterScreen());
                                  },
                                  child: const Text(
                                    'Register here',
                                    style: TextStyle(color: Colors.red),
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
