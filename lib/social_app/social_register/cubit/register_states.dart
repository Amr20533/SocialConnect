abstract class registerState{}
class registerInitialState extends registerState{}
class registerChangeSuffixState extends registerState{}
class registerGetLoadingCircularState extends registerState{}
class registerGetSuccessState extends registerState{}
class registerGetErrorState extends registerState{
  final String error;
  registerGetErrorState(this.error);
}
class registerChangeAppModeState extends registerState{}

class RegisterCreateUserSuccessState extends registerState{}
class RegisterCreateUserErrorState extends registerState{
  final String error;
  RegisterCreateUserErrorState(this.error);
}