
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constants.dart';
import 'package:social_app/shared/style/icon_broken.dart';
import 'package:social_app/social_app/social_lauout/cubit/social_cubit.dart';
import 'package:social_app/social_app/social_lauout/cubit/social_states.dart';
class EditProfileScreen extends StatelessWidget {
   EditProfileScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){},
        builder: (context,state){
          var userModel = SocialCubit.get(context).socialUserModel;
          nameController.text = userModel!.name!;
          phoneController.text = userModel.phone!;
          bioController.text = userModel.bio!;

          var profileImage = SocialCubit.get(context).profileImage;
          var coverImage = SocialCubit.get(context).coverImage;
          return Scaffold(
            appBar:defaultAppBar(
              context,
              title: 'Edit Profile',
              actions: [
                defaultTextButton(pressed: (){
                  SocialCubit.get(context).updateUserData(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                }, text: 'Update')
              ],
            ),
            body:Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if(state is SocialUpdateUserLoadingState)
                    const LinearProgressIndicator(),
                    const SizedBox(height: 10,),
                    Container(
                      margin:const EdgeInsets.only(bottom: 15),
                      height: 190,
                      child: Stack(alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(alignment: AlignmentDirectional.topCenter,
                            child: Stack(alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height: 130,width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius:const BorderRadius.only(topLeft: Radius.circular(4.0),topRight: Radius.circular(4.0)),
                                      image: DecorationImage(
                                          image:coverImage == null? NetworkImage('${userModel.backgroundImage}'):FileImage(coverImage) as ImageProvider,
                                          fit: BoxFit.cover

                                      )
                                  ),
                                ),
                                IconButton(icon:const CircleAvatar(radius: 15,
                                    child:Icon(IconBroken.Camera)),
                                  onPressed: () {
                                  SocialCubit.get(context).getCoverImage();
                                  },)
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
                                 backgroundImage:profileImage == null?NetworkImage('${userModel.image}'):FileImage(profileImage) as ImageProvider
                               ),
                             ),
                              IconButton(icon:const CircleAvatar(radius: 15,
                                  child:Icon(IconBroken.Camera)),
                                onPressed: () {
                                SocialCubit.get(context).getProfileImage();
                                },)
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5,),
                    if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null )
                    Row(
                      children: [
                        if(SocialCubit.get(context).profileImage != null)

                          Expanded(child: TextButton(onPressed:(){
                            SocialCubit.get(context).uploadProfileImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);

                          },child:const Text('Update Profile')),),
                        if(SocialCubit.get(context).coverImage != null )

                          Expanded(child: TextButton(onPressed:(){
                            SocialCubit.get(context).uploadCoverImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                          },child:const Text('Update Cover')),)
                      ],
                    ),
                    defaultTextForm(controller: nameController,
                        type: TextInputType.text,
                        prefix: IconBroken.User, label: 'Name', validate: (String? value ) {
                            if(value == null || value.trim().isEmpty) return 'required';
                        }),
                    const SizedBox(height: 5.0,),
                    defaultTextForm(controller: bioController,
                        type: TextInputType.text,
                        validate: (String? value ) {
                          if(value == null || value.trim().isEmpty) return 'required';
                        },
                        prefix: IconBroken.Info_Circle, label: 'bio'),
                    const SizedBox(height: 5.0,),
                    defaultTextForm(controller: phoneController,
                        type: TextInputType.phone,
                        validate: (String? value ) {
                          if(value == null || value.trim().isEmpty) return 'required';
                        },
                        prefix: Icons.phone, label: 'phone'),
                    // Card(
                    //   child: TextFormField(controller: nameController,
                    //       keyboardType:TextInputType.text,
                    //       decoration: InputDecoration(
                    //         prefix:const Icon(IconBroken.User),
                    //         hintText: 'Type in your name...',
                    //         border: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(10))
                    //       ),),
                    // ),
                    // Card(
                    //   child: TextFormField(controller: bioController,
                    //       keyboardType:TextInputType.text,
                    //       decoration: InputDecoration(
                    //         prefix: const Icon(IconBroken.Edit),
                    //         hintText: 'Type in your bio...',
                    //           border: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(10))
                    //
                    //       ),),
                    // ),
                  ],
                ),
              ),
            ),

          );
        },

    );
  }
}
