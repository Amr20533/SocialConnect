import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constants.dart';
import 'package:social_app/social_app/social_lauout/chat_details.dart';
import 'package:social_app/social_app/social_lauout/cubit/social_cubit.dart';
import 'package:social_app/social_app/social_lauout/cubit/social_states.dart';
import 'package:social_app/widgets/users_card.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return SocialCubit.get(context).users.isNotEmpty?ListView.separated(
            shrinkWrap: true,
            physics:const BouncingScrollPhysics(),
            itemBuilder: (context,index)=>UsersCard(
              user: SocialCubit.get(context).users[index],
            ),
            separatorBuilder: (context,index) => const Divider(thickness: 1,indent: 22,endIndent: 22,),
            itemCount: SocialCubit.get(context).users.length,
        ):const Center(child: CircularProgressIndicator(),);
      },
    );
  }
}
//https://images.unsplash.com/photo-1673906510964-780fd008924f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMzJ8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60