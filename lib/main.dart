import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constants.dart';
import 'package:social_app/shared/remote/local/cache_helper.dart';
import 'package:social_app/shared/style/themes.dart';
import 'package:social_app/social_app/social_lauout/cubit/social_cubit.dart';
import 'package:social_app/social_app/social_lauout/cubit/social_states.dart';
import 'package:social_app/social_app/social_lauout/social_layout.dart';
import 'package:social_app/social_app/social_login/layout/social_login_screen.dart';
//
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{
//   await Firebase.initializeApp();
//   print('Handling a background message: ${message.messageId}');
//   print(message.data.toString());
// }
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Widget widget;
  await Firebase.initializeApp();
  await CacheHelper.init();
  // var token = await FirebaseMessaging.instance.getToken();
  // uId = CacheHelper.getData(key: 'uId');
  // print(token);
  // // for ground fcm
  // FirebaseMessaging.onMessage.listen((event) {
  //   print(event.data.toString());
  // });
  // // on open notification navigate to app
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //   print(event.data.toString());
  // });
  // // background fcm
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // uId = CacheHelper.removeData(key: 'uId').toString();
// // Ideal time to initialize
//   await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
//...
  if(uId == null || uId!.trim().isEmpty){
    widget = SocialLoginScreen();
  }else{
    widget = const SocialLayout();
  }
 runApp(MyApp(startWidget: widget,));
}
class MyApp extends StatelessWidget {
  final Widget? startWidget;
  const MyApp({this.startWidget,Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  return MultiBlocProvider(providers: [
    BlocProvider(create: (context) => SocialCubit()..getUserData()..getPosts())
  ],
      child: BlocConsumer<SocialCubit,SocialStates>(
        listener:(context,state){},
        builder:(context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Social App',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
      ));

  }

}
///**
/// return  MultiBlocProvider(
//     providers: [
//       BlocProvider(
//       create: (context)=>registerCubit(),),
//
//       BlocProvider(
//       create: (context)=>LoginCubit(),),
//
//     ],
//     child: BlocConsumer<LoginCubit,loginState>(
//     listener: (context,state){},
//     builder:(context,state){
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Social App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         textTheme: Theme
//             .of(context)
//             .textTheme
//             .apply(displayColor: kTextColor),
//       ),
//       home: SocialRegisterScreen(),
//     );
//   }
//
//     ),
//   );
//   }
// }
// */