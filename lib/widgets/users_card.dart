import 'package:flutter/material.dart';
import 'package:social_app/constants.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/social_app/social_lauout/chat_details.dart';
import 'package:social_app/social_app/social_lauout/cubit/social_cubit.dart';

class UsersCard extends StatelessWidget {
  UsersCard({required this.user,Key? key}) : super(key: key);
  final SocialUserModel user;
  // final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
        navigateTo(context, ChatDetails(userModel: user,));

      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage:  NetworkImage(user.image!),
            ),
            const SizedBox(width: 10.0,),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(user.name!,style:const TextStyle(height: 1.3),),
                    const SizedBox(width: 5.0),
                    const Icon(Icons.check_circle,size: 16.0,color: Colors.blue,),
                  ],
                ),
                Text(DateTime.now().toString(),style: Theme.of(context).textTheme.caption!.copyWith(height: 1.3),)
              ],
            )),
            const SizedBox(width: 5.0,),
            IconButton(onPressed: (){},
                icon:const Icon(Icons.more_horiz))
            // TextFormField(
            // controller:commentController,
            // decoration:InputDecoration(
            // hintText:'write a comment',
            // border:const OutlineInputBorder(),
            // ),),
          ],
        ),
      ),
    );
  }
}
