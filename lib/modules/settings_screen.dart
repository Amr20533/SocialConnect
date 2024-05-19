import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constants.dart';
import 'package:social_app/modules/edit_profile_post/edit_profile_screen.dart';
import 'package:social_app/shared/style/icon_broken.dart';
import 'package:social_app/social_app/social_lauout/cubit/social_cubit.dart';
import 'package:social_app/social_app/social_lauout/cubit/social_states.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var userModel = SocialCubit.get(context).socialUserModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 190,
                child: Stack(alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(alignment: AlignmentDirectional.topCenter,
                      child: Stack(alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(
                            height: 130,width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius:const BorderRadius.only(topLeft: Radius.circular(4.0),topRight: Radius.circular(4.0)),
                                image: DecorationImage(fit: BoxFit.cover,
                                  image:NetworkImage('${userModel?.backgroundImage}'),
                                )
                            ),
                          ),

                        ],
                      ),
                    ),
                    Stack(alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                          radius: 64,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          // backgroundImage: NetworkImage('${userModel?.backgroundImage}'),
                          child:CircleAvatar(
                              radius: 60,
                              // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              // backgroundImage:NetworkImage('${userModel?.image}'),
                              backgroundImage:NetworkImage('${userModel?.image}')
                          ),
                        ),
                        // IconButton(icon:const CircleAvatar(radius: 15,
                        //     child:Icon(IconBroken.Camera)),
                        //   onPressed: () {
                        //     // SocialCubit.get(context).getProfileImage();
                        //   },)
                      ],
                    ),
                  ],
                ),
              ),
              Text('${userModel?.name}',style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),),
              Text('${userModel?.bio}',style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.black38),),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Expanded(child: InkWell(
                      onTap:(){},
                      child: Column(
                        children: [
                          Text('74',style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.black),),
                          Text('Posts',style: Theme.of(context).textTheme.caption),

                        ],
                      ),
                    )),
                    Expanded(child: InkWell(
                      onTap:(){},
                      child: Column(
                        children: [
                          Text('314',style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.black),),
                          Text('photos',style: Theme.of(context).textTheme.caption),

                        ],
                      ),
                    )),
                    Expanded(child: InkWell(
                      onTap:(){},
                      child: Column(
                        children: [
                          Text('10k',style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.black),),
                          Text('Followers',style: Theme.of(context).textTheme.caption),

                        ],
                      ),
                    )),
                    Expanded(child: InkWell(
                      onTap:(){},
                      child: Column(
                        children: [
                          Text('30',style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.black),),
                          Text('Following',style: Theme.of(context).textTheme.caption),

                        ],
                      ),
                    )),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: defaultButton(
                      background: Colors.white,
                      textColor: Colors.blue,
                      text: 'Edit Profile',
                      pressed: (){
                      },
                    ),
                  ),
                  const SizedBox(width: 8.0,),
                  OutlinedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfileScreen()));

                  },
                      child:const Icon(IconBroken.Edit,size: 16.0,))
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
//https://images.unsplash.com/photo-1672776720502-246e6bf9550c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60
//https://images.unsplash.com/photo-1672464173838-4d90d3c77a5f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyMjJ8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60