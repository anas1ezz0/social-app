import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:new_social_app/model/chat_model.dart';
import '../const/const.dart';
import '../model/post_model.dart';
import '../model/social_user_model.dart';
import '../view/add_post_screen.dart';
import '../view/chats_screen.dart';
import '../view/feeds_screen.dart';
import '../view/settings_screen.dart';
import '../view/users_screen.dart';
import 'app_status.dart';

class AppCubit extends Cubit<AppStatus>
{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;

  void getUserData()
  {
    emit(AppLoadingState());

    FirebaseFirestore.instance
        .collection('user')
        .doc(uId)
        .get()
        .then((value)
    {
      //print(value.data());
      userModel = SocialUserModel.fromJson(value.data()!);
      emit(AppSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(AppErrorState(error.toString()));

    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    AddPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if(index == 1){
    getUsers();
    }
    if (index == 2)
      emit(AppGoToPostState());
    else {
      currentIndex = index;
      emit(AppChangNavBarState());
    }
  }

  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(AppProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(AppProfileImagePickedErrorState());
    }
  }

  File? coverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(AppCoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(AppCoverImagePickedErrorState());
    }
  }

  File? postImage;
  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(AppPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(AppPostImagePickedErrorState());
    }
  }

  void removePostImage(){
    postImage = null;
    emit(AppRemovePostImageState());
  }
  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(AppUploadProfileImageLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((error) {
        emit(AppUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(AppUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(AppUploadCoverImageLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error) {
        emit(AppUploadCoverImageErrorState());
      });
    }).catchError((error) {
        emit(AppUploadCoverImageErrorState());
    });
  }



  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel!.email,
      cover: cover ?? userModel!.cover,
      image: image ?? userModel!.image,
      uId: userModel!.uId,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('user')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(AppUserUpdateErrorState());
    });
  }

  void uploadPost({
 
    required String dateTime,
    required String text,
  }) {
    emit((AppCreatePostLoadingState()));

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('post/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadProfileImageSuccessState());
        print(value);
createPost(dateTime: dateTime, text: text,postImage: value);
      }).catchError((error) {
        emit((AppCreatePostErrorState()));
      });
    }).catchError((error) {
      emit((AppCreatePostErrorState()));
    });
  }

  void createPost({
    required String dateTime,
    required String text,
     String? postImage,
  }) {
    emit((AppCreatePostLoadingState()));
    PostUserModel model = PostUserModel(
      name: userModel!.name,
      image:userModel!.image,
      uId: userModel!.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage??'',

    );

    FirebaseFirestore.instance
        .collection('post')
        .add(model.toMap())
        .then((value) {
emit(AppCreatePostSuccessState());
    }).catchError((error) {
      emit(AppCreatePostErrorState());
    });
  }

  List<PostUserModel> posts = [] ;
  List<String> postsId = [] ;
  List<int> likes = [] ;
  void getPost()
  {
    FirebaseFirestore.instance.collection('post').get().then((value) {
          for (var element in value.docs) {
            element.reference
                .collection('likes')
                .get()
                .then((value) {
                  likes.add(value.docs.length);
              postsId.add(element.id);
              posts.add(PostUserModel.fromJson(element.data()));

            }).catchError((error){

            });
          }
          emit(AppGetPostsSuccessState());
    }
    )
        .catchError((error){
          emit(AppGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId){
    FirebaseFirestore
        .instance
        .collection('post')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true ,
    }).then((value) {
      emit(AppLikePostsSuccessState());
    }).catchError((error){
      emit(AppLikePostsErrorState(error.toString()));
    });
  }

  List<SocialUserModel> users = [] ;

  void getUsers()
  {
    if(users.length == 0) {
      FirebaseFirestore.instance.collection('user').get().then((value) {
      for (var element in value.docs) {
        if(element.data()['uId'] != userModel!.uId){
          users.add(SocialUserModel.fromJson(element.data()));
        }
      }
      emit(AppGetAllUsersSuccessState());
    }
    )
        .catchError((error){
      emit(AppGetAllUsersErrorState(error.toString()));
    });
    }
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
})
  {
ChatModel  model = ChatModel(
  text: text,
  dateTime: dateTime,
  receiverId:receiverId ,
  senderId:userModel!.uId
);
FirebaseFirestore.instance
.collection('user')
.doc(userModel!.uId)
.collection('chats')
.doc(receiverId)
.collection('messages')
.add(model.toMap())
.then((value) {
  emit(AppSendMessageSuccessState());
}).catchError((error){
  emit(AppSendMessageErrorState());
});
FirebaseFirestore.instance
    .collection('user')
    .doc(receiverId)
    .collection('chats')
    .doc(userModel!.uId)
    .collection('messages')
    .add(model.toMap())
    .then((value) {
  emit(AppSendMessageSuccessState());
}).catchError((error){
  emit(AppSendMessageErrorState());
});
  }
  List<ChatModel> messages = [];
  void getMessages({
    required String receiverId,
  })
  {

    FirebaseFirestore.instance
        .collection('user')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
      messages = [];
      event.docs.forEach((element) {
        messages.add(ChatModel.fromJson(element.data()));
      });
      emit(AppGetMessageSuccessState());
    });
  }
}
