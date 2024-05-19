import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_app/constants.dart';
import 'package:social_app/shared/style/icon_broken.dart';
import 'package:social_app/social_app/social_lauout/cubit/social_cubit.dart';
import 'package:social_app/social_app/social_lauout/cubit/social_cubit.dart';
import 'package:social_app/social_app/social_lauout/cubit/social_states.dart';

class NewPostScreen extends StatelessWidget {
   NewPostScreen({Key? key}) : super(key: key);
  var inputController = TextEditingController();
   var dateTime = DateFormat('EEEE,d MMM,yyy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        builder: (context,state){
         var profile = SocialCubit.get(context).socialUserModel;
          var postImage = SocialCubit.get(context).postImage;
      return Scaffold(
          appBar:defaultAppBar(
            context,
            title: 'Add post',
            actions: [
              defaultTextButton(
                  pressed: (){
                if(SocialCubit.get(context).postImage == null){
                  SocialCubit.get(context).uploadPostData(
                      dateTime: dateTime,
                      text: inputController.text);
                }else{
                  SocialCubit.get(context).uploadPostImage(
                      dateTime: dateTime,
                      text: inputController.text);
                }
              }, text: 'Post')
            ],
          ),
          body:SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if(state is SocialAddPostLoadingState)
                    const LinearProgressIndicator(),
                  if(state is SocialAddPostLoadingState)
                    const SizedBox(height: 20,),

                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25.0,
                        backgroundImage:  NetworkImage('${profile?.image}'),
                      ),
                      const SizedBox(width: 10.0,),
                      Expanded(child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${profile?.name}',style:const TextStyle(height: 1.3),),
                          // Text(dateFormat,style: Theme.of(context).textTheme.caption!.copyWith(height: 1.3),)
                          // const SizedBox(height: 10,),
                          TextField(
                            controller: inputController,
                            decoration:const InputDecoration(
                              hintText: 'what\'s on your mind...',
                              border: InputBorder.none,
                            ),
                          ),
                        ],
                      )),

                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  // todo: show Post image if exist
                  if(SocialCubit.get(context).postImage != null)
                  Stack(alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 420,width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            image: DecorationImage(
                                image:postImage == null? NetworkImage('${SocialCubit.get(context).postImage}'):FileImage(postImage) as ImageProvider,
                                fit: BoxFit.cover

                            )
                        ),
                      ),
                      IconButton(icon:const CircleAvatar(radius: 15,
                          child:Icon(IconBroken.Close_Square)),
                        onPressed: () {
                          SocialCubit.get(context).removePostImage();
                        },)
                    ],
                  ),

                  const SizedBox(
                    height: 20.0,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: ()
                          {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:const [
                              Icon(
                                IconBroken.Image,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'add photos',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child:const Text(
                            '# tags',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
      );

    }, listener: (context,state){

    });
  }
}
