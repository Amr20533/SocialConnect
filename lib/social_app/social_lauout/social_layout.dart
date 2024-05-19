import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constants.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/shared/style/icon_broken.dart';
import 'package:social_app/social_app/social_lauout/cubit/social_cubit.dart';
import 'package:social_app/social_app/social_lauout/cubit/social_states.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){
          if(state is SocialUploadPostState) {
            navigateTo(context, NewPostScreen());
          }
        },
        builder: (context,state){
          SocialCubit cubit = SocialCubit.get(context);
          return Scaffold(
            appBar: AppBar(title: Text(cubit.titles[cubit.currentIndex]),actions: [IconButton(onPressed: (){}, icon:const Icon(IconBroken.Notification),),IconButton(onPressed: (){}, icon:const Icon(IconBroken.Search),)],),
            body: SocialCubit.get(context).screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items:cubit.items ,
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeNavBar(index);
              },
            ),
          );
        },
    );
  }
}
