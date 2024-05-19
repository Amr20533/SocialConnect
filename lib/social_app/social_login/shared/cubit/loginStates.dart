import 'package:social_app/models/social_user_model.dart';

abstract class loginState{}
class loginInitialState extends loginState{}
class loginIndexChangeState extends loginState{}
class LoginGetAuthState extends loginState{}
class loginChangeSuffixState extends loginState{}
class socialGetLoginCircularState extends loginState{}
class socialGetLoginState extends loginState{
  final String uId;
  socialGetLoginState(this.uId);
}
class socialGetLoginErrorState extends loginState{
  final String error;
  socialGetLoginErrorState(this.error);
}
class socialChangeAppModeState extends loginState{}
