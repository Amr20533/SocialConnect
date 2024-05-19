import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/shared/style/icon_broken.dart';
import 'package:social_app/social_app/social_lauout/cubit/social_cubit.dart';
import 'package:social_app/social_app/social_lauout/cubit/social_states.dart';
import 'package:social_app/widgets/message_card.dart';

class ChatDetails extends StatelessWidget {
  ChatDetails({required this.userModel,Key? key}) : super(key: key);
  final SocialUserModel userModel;
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (BuildContext context){
          SocialCubit.get(context).getMessages(receiverId:userModel.uId!);
      return BlocConsumer<SocialCubit,SocialStates>(
          listener: (context,state){
            if(state is SocialSendMessageState){
              textController.clear();
            }
          },
          builder:(context,state){
            return Scaffold(
                appBar: AppBar(
                    titleSpacing: 0.0,
                    title: Row(children: [
                      CircleAvatar(radius: 20,
                        backgroundImage: NetworkImage('${userModel.image}'),),
                      const SizedBox(width: 15.0,),
                      Text(userModel.name!,style:const TextStyle(fontSize: 16,fontWeight: FontWeight.w800)),
                    ],)
                ),
                body:SocialCubit.get(context).messages.isNotEmpty?Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(itemBuilder: (context,index){
                          var message = SocialCubit.get(context).messages[index];
                          // sender message
                          if(SocialCubit.get(context).socialUserModel?.uId == message.senderId){
                            return MessageCard(
                              text: message.text!,
                              color: Colors.black12,
                              borderRadius:const BorderRadiusDirectional.only(bottomEnd: Radius.circular(10),topStart:Radius.circular(10.0),topEnd: Radius.circular(10.0)),
                              alignment: AlignmentDirectional.centerStart,
                            );
                          }
                          // receiver message
                          else{
                            return MessageCard(
                              text: message.text!,
                              color: Colors.blue.withOpacity(0.2),
                              borderRadius:const BorderRadiusDirectional.only(topStart:Radius.circular(10.0),bottomStart: Radius.circular(10.0),topEnd:Radius.circular(10.0)),
                              alignment: AlignmentDirectional.centerEnd,
                            );
                          }
                        }, separatorBuilder: (context,index) => const SizedBox(height: 15.0,), itemCount: SocialCubit.get(context).messages.length),
                      ),
                      const Spacer(),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        padding:const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey[300]!,width: 1
                            ),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Row(
                          children: [
                            Expanded(child: TextFormField(
                              controller: textController,
                              decoration:const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'type in Your message here..',
                              ),
                            ),
                            ),
                            MaterialButton(onPressed: (){
                              SocialCubit.get(context).sendMessage(receiverId: userModel.uId!, dateTime: DateTime.now().toString(), text: textController.text);
                            },
                              minWidth: 1.0,
                              child:const Icon(IconBroken.Send,size: 22,color: Colors.blue,),)
                          ],
                        ),
                      )
                    ],
                  ),
                ):Container(),
            );
          }
      );
    });
  }
}
