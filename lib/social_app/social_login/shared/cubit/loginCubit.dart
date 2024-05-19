import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constants.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/shared/remote/local/cache_helper.dart';
import 'package:social_app/social_app/social_login/shared/cubit/loginStates.dart';

class LoginCubit extends Cubit<loginState>{
  LoginCubit():super(loginInitialState());
  static LoginCubit get(context)=>BlocProvider.of(context);
  int index = 0;
  bool password=false;
  bool isDark=false;

  List<Widget> items =
  [
   const Icon(Icons.business,size:30),
   const Icon(Icons.sports,size:30),
   const Icon(Icons.science,size:30),
  ];
  // SocialUserModel? model;
  // List<Widget> screens=[
  //   businessPage(),
  //   sportsPage(),
  //   sciencePage(),
  //   // settingsPage(),
  // ];
  // void changeAppMode({bool? fromShared}){
  //   if(fromShared != null){
  //     isDark=fromShared;
  //     emit(newsChangeAppModeState());
  //   }else{
  //     isDark=!isDark;
  //     cacheHelper.putBool(key:'isDark',value:isDark).then((value){
  //       print('$value is Set');
  //       emit(newsChangeAppModeState());
  //     });
  //   }}
  void getAuthorized(bool? shared){
    if(shared != null){
      notAuthorized = shared;
      emit(LoginGetAuthState());
    }else {
      notAuthorized = !notAuthorized;
      CacheHelper.setBool(key: 'auth',value: notAuthorized).then((value){
        emit(LoginGetAuthState());
      });
      }
    }
  void changeIndex(int index){
    this.index==index;
    emit(loginIndexChangeState());
  }
  var suffix=Icons.visibility_off_outlined;
  void changeSuffix(){
    password=!password;
    suffix=password?Icons.visibility_off_outlined:Icons.visibility_outlined;
    emit(loginChangeSuffixState());
  }
  void userLogin({required String email,required String password}){
    emit(socialGetLoginCircularState());
   FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value)
    {
      // model = SocialUserModel.toJson(value.user);
      print(value.user?.email);
      print(value.user?.uid);
      // getAuthorized(true);
      emit(socialGetLoginState(value.user!.uid));
    }
    ).catchError((error){ // FirebaseAuthException error
      print('Login Error state called! \n $error');
      emit(socialGetLoginErrorState(error.toString()));
    }
    );
  }

  void changeAppMode(){
    isDark=!isDark;
    emit(socialChangeAppModeState());
  }


}