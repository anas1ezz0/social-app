
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_social_app/Register_bloc/register_status.dart';

import '../model/social_user_model.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterState> {
  SocialRegisterCubit() :super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterChangeVisibilityState());
  }

  void userRegister({
    required String  name,
    required String  email,
    required String  password,
    required String  phone,
  })
  {
  emit(SocialRegisterLoadingState());
  FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email
      , password: password
  ).then((value) {
    userCreate(
        name: name,
        uId: value.user!.uid,
        email: email,
        phone: phone,
    );
    print(value.user?.email);
    print(value.user?.uid);
    // emit(SocialRegisterSuccsessState());
  }).catchError((error){
    emit(SocialRegisterErrorState(error.toString()));

  });

}
  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  })
  {
    SocialUserModel model = SocialUserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        image: 'https://img.freepik.com/free-photo/mountain-landscape_1048-3244.jpg?w=1380&t=st=1699368929~exp=1699369529~hmac=c5f354fe1e7deea93d6c39a95d2f88bb62a8be9412137e4d381b5f02e8b1959d',
         cover: 'https://img.freepik.com/free-photo/mountain-landscape_1048-3244.jpg?w=1380&t=st=1699368929~exp=1699369529~hmac=c5f354fe1e7deea93d6c39a95d2f88bb62a8be9412137e4d381b5f02e8b1959d',
         bio: 'write your bio ...',
         isEmailVerified: false,
    );

    FirebaseFirestore.instance.collection('user')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
          emit(SocialCreatUserSuccsessState());
    }).catchError((error){
      emit(SocialCreatUserErrorState(error.toString()));
    });

  }

}