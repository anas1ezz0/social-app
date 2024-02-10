
abstract class SocialRegisterState{}

class SocialRegisterInitialState extends SocialRegisterState{}
class SocialRegisterLoadingState extends SocialRegisterState{}
class SocialRegisterSuccsessState extends SocialRegisterState{}
class SocialRegisterErrorState extends SocialRegisterState{
final String error;

  SocialRegisterErrorState(this.error);
}

class SocialCreatUserSuccsessState extends SocialRegisterState{}
class SocialCreatUserErrorState extends SocialRegisterState{
  final String error;

  SocialCreatUserErrorState(this.error);
}
class SocialRegisterChangeVisibilityState extends SocialRegisterState{}