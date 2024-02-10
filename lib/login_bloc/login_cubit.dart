import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_status.dart';

class SocialLoginCubit extends Cubit<SocialLoginState> {
  SocialLoginCubit() :super(SocialLoginInitialState());
static SocialLoginCubit get(context) =>BlocProvider.of(context);
  IconData  suffix = Icons.visibility_outlined ;
  bool isPassword = true;

  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix =isPassword? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialChangeVisibilityState());
  }

  void userLogin ({
    required email ,
    required password ,
})
  {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {

     emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error){
      print(error.toString());
      emit(SocialLoginErrorState(error.toString()));
    });
  }

}