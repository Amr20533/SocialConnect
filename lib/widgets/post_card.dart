import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/profile_image.dart';
import 'package:social_app/shared/style/icon_broken.dart';
import 'package:social_app/social_app/social_lauout/cubit/social_cubit.dart';
import 'package:social_app/widgets/tag_box.dart';

class PostCard extends StatelessWidget {
   PostCard({required this.profile,required this.index,Key? key}) : super(key: key);
   // Profile profile;
   int index;
   PostModel profile;
  var dateFormat=DateFormat('EEEE,d MMM,yyy').format(DateTime.now());
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var cubit = SocialCubit.get(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10.0,
      child: Padding(
        padding:const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5.0),
        child: Form(
          key:formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                   CircleAvatar(
                    radius: 20.0,
                    backgroundImage:  NetworkImage('${profile.image}'),
                  ),
                  const SizedBox(width: 10.0,),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('${profile.name}',style:const TextStyle(height: 1.3),),
                          const SizedBox(width: 5.0),
                          const Icon(Icons.check_circle,size: 16.0,color: Colors.blue,),
                        ],
                      ),
                      Text(profile.dateTime!,style: Theme.of(context).textTheme.caption!.copyWith(height: 1.3),)
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
              // Divider
              Container(margin: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5.0),
                color: Colors.grey[300],
                height: 1.0,
              ),
              Text(profile.text!,style:Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.black,fontWeight: FontWeight.w400),),
              const SizedBox(height: 8.0,),
              // **************   tags  ********************
              // Wrap(
              //   spacing: 5.0,
              //   children: [
              //     TagBox(onPressed:(){},title: 'Software_developer',),
              //     TagBox(onPressed:(){},title: 'Flutter',),
              //     TagBox(onPressed:(){},title: 'Mobile_development',),
              //     TagBox(onPressed:(){},title: 'Flutter',),
              //     TagBox(onPressed:(){},title: 'dart',),
              //     TagBox(onPressed:(){},title: 'programming',),
              //
              //   ],
              // ),
              ////***********  post image *****************
              if(SocialCubit.get(context).postImage != null)
               Card(
                margin:  EdgeInsets.zero,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 5.0,
                child:   Image(image: NetworkImage('${profile.postImage}'),width: double.infinity,height: 280,fit: BoxFit.fitWidth,),

              ),
              //********** comment & likes box
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Row(
                          children: [
                            const Icon(IconBroken.Heart,size: 16.0,color: Colors.redAccent,),
                            const SizedBox(width: 5.0,),
                            Text('${SocialCubit.get(context).likes[index]}'),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Row(
                          children: [
                            const Icon(IconBroken.Chat,size: 16.0,color: Colors.amber,),
                            const SizedBox(width: 5.0,),
                            Text( cubit.comments[index].length <= 1 ?'${cubit.comments[index]} comment':'${cubit.comments[index]} comments', style:const TextStyle(fontSize: 14,color: Colors.black38,fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                    ),
                    // Divider

                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                width:double.infinity,color: Colors.grey[300],
                height: 1.0,
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 15.0,
                    backgroundImage:  NetworkImage(SocialCubit.get(context).socialUserModel!.image!),
                  ),
                  const SizedBox(width: 8.0,),
                  Expanded(child: TextFormField(
                    controller: SocialCubit.get(context).commentController,
                  decoration: InputDecoration(
                    hintText: 'Write a comment...',
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon:const Icon(IconBroken.Chat),
                      onPressed: (){
                        if(SocialCubit.get(context).formKey.currentState!.validate()){
                            SocialCubit.get(context).writeComment(SocialCubit.get(context).postsId[index]);
                      }
                        },
                    ),
                  ),
                  validator: (String? value){
                      if(value == null || value.trim().isEmpty){
                          return null;
                      }
                  }
                  ,style: Theme.of(context).textTheme.caption!.copyWith(height: 1.3),)),
                  // const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: (){
                            SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                          },
                          child: Row(
                            children:const [
                              Icon(IconBroken.Heart,size: 16.0,color: Colors.redAccent,),
                              SizedBox(width: 5.0,),
                              Text('Like',style: TextStyle(fontSize: 14,color: Colors.black38,fontWeight: FontWeight.w400),),
                            ],
                          ),
                        ),
                        const SizedBox(width: 15.0,),
                        InkWell(
                          onTap: (){},
                          child: Row(
                            children:const [
                              Icon(IconBroken.Chat,size: 16.0,color: Colors.amber,),
                              SizedBox(width: 5.0,),
                              Text('Share',style: TextStyle(fontSize: 14,color: Colors.black38,fontWeight: FontWeight.w400),),
                            ],
                          ),
                        ),
                        // Divider

                      ],
                    ),
                  ),

                  // TextFormField(
                  // controller:commentController,
                  // decoration:InputDecoration(
                  // hintText:'write a comment',
                  // border:const OutlineInputBorder(),
                  // ),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//elnemr8119
//https://www.picuki.com/profile/ruslana_kutsa.69.69
//https://www.picuki.com/profile/elnemr8119
