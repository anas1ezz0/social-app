abstract class AppStatus{}
//app
class AppInitialState extends AppStatus{}
class AppChangNavBarState extends AppStatus{}
class AppLoadingState extends AppStatus{}
class AppSuccessState extends AppStatus{}
class AppErrorState extends AppStatus{
  final String error;

  AppErrorState(this.error);
}

class AppGoToPostState extends  AppStatus{}
//profile picked
class AppProfileImagePickedSuccessState extends AppStatus{}
class AppProfileImagePickedErrorState extends AppStatus{}
//cover picked
class AppCoverImagePickedSuccessState extends AppStatus{}
class AppCoverImagePickedErrorState extends AppStatus{}
//post picked
class AppPostImagePickedSuccessState extends AppStatus{}
class AppPostImagePickedErrorState extends AppStatus{}
//upload profile
class AppUploadProfileImageSuccessState extends AppStatus{}
class AppUploadProfileImageLoadingState extends AppStatus{}
class AppUploadProfileImageErrorState extends AppStatus{}
//upload cover
class AppUploadCoverImageSuccessState extends AppStatus{}
class AppUploadCoverImageLoadingState extends AppStatus{}
class AppUploadCoverImageErrorState extends AppStatus{}
//update user
class AppUserUpdateErrorState extends AppStatus{}
class AppUserUpdateSuccessState extends AppStatus{}
class AppUserUpdateLoadingState extends AppStatus{}
//create post
class AppCreatePostErrorState extends AppStatus{}
class AppCreatePostSuccessState extends AppStatus{}
class AppCreatePostLoadingState extends AppStatus{}
//remove postImage
class AppRemovePostImageState extends AppStatus{}
//get posts
class AppGetPostsErrorState extends AppStatus{
  final String error;

  AppGetPostsErrorState(this.error);
}
class AppGetPostsSuccessState extends AppStatus{}
class AppGetPostsLoadingState extends AppStatus{}
//like post
class AppLikePostsErrorState extends AppStatus{
  final String error;

  AppLikePostsErrorState(this.error);
}
class AppLikePostsSuccessState extends AppStatus{}
//get all users
class AppGetAllUsersErrorState extends AppStatus{
  final String error;

  AppGetAllUsersErrorState(this.error);
}
class AppGetAllUsersSuccessState extends AppStatus{}
class AppGetAllUsersLoadingState extends AppStatus{}
//send message
class AppSendMessageSuccessState extends AppStatus{}
class AppSendMessageErrorState extends AppStatus{}
//get message
class AppGetMessageSuccessState extends AppStatus{}
