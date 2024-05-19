import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/social_app/social_register/cubit/register_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class registerCubit extends Cubit<registerState>{
  registerCubit():super(registerInitialState());
  static registerCubit get(context)=>BlocProvider.of(context);
  int index=0;
  bool password=true;
  bool isDark=false;
  List<Widget> items = const [
    Icon(Icons.business,size:30),
    Icon(Icons.sports,size:30),
    Icon(Icons.science,size:30),
  ];

  // List<Widget> screens=[
  //   businessPage(),
  //   sportsPage(),
  //   sciencePage(),
  //   // settingsPage(),
  // ];
  // void changeIndex(int index){
  //   this.index==index;
  //   emit(loginIndexChangeState());
  // }
  var suffix=Icons.visibility_off_outlined;
  void changeSuffix(){
    password=!password;
    suffix=password?Icons.visibility_off_outlined:Icons.visibility_outlined;
    emit(registerChangeSuffixState());
  }
  void userRegister({required String email ,required String password,required String name ,required String phone})async {
    print('------------>> doing test <<-------------- \n');
    emit(registerGetLoadingCircularState());
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value)
    {
      print('Register function called!');
      print(value.user?.email);
      print(value.user?.uid);
      createUser(email: email,
          name: name,
          phone: phone,
          uId: value.user!.uid);
      // emit(registerGetSuccessState());
    }).catchError((error){//FirebaseAuthException error
      print('------------> Register Exception <------------\n $error');
      emit(registerGetErrorState(error.toString()));
    });
  }

  void createUser({required String email ,required String name,required String phone ,required String uId})async {
    print('------------>> create User <<--------------\n');

    SocialUserModel socialModel = SocialUserModel(
        name: name,
        phone: phone,
        email: email,
        bio: 'Write your bio...',
        backgroundImage: 'https://images.unsplash.com/photo-1672711553222-9bc0229384ea?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60',
        isEmailVerified: false,
        image: 'https://villagesonmacarthur.com/wp-content/uploads/2020/12/Blank-Avatar.png',
        uId: uId
    );
    FirebaseFirestore.instance.collection('users').doc(uId).set(socialModel.toMap()).then((value) {
      emit(RegisterCreateUserSuccessState());
    }).catchError((error){
      print('Social Error state --> $error');
      emit(RegisterCreateUserErrorState(error.toString()));
    });
  }

  // void changeAppMode(){
  //   isDark=!isDark;
  //   emit(socialChangeAppModeState());
  // }

  List<dynamic> search = [];

// void getSearch(String value) {
//   emit(NewsGetSearchLoadingState());
//
//   DioHelper.getData(
//     url: 'v2/everything',
//     query:
//     {
//       'q':'$value',
//       'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
//     },
//   ).then((value)
//   {
//     //print(value.data['articles'][0]['title']);
//     search = value.data['articles'];
//     print(search[0]['title']);
//
//     emit(NewsGetSearchSuccessState());
//   }).catchError((error){
//     print(error.toString());
//     emit(NewsGetSearchErrorState(error.toString()));
//   });
// }
}