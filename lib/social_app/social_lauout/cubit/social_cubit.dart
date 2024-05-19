import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/constants.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/modules/settings_screen.dart';
import 'package:social_app/shared/style/icon_broken.dart';
import 'package:social_app/social_app/social_lauout/chats_screen.dart';
import 'package:social_app/social_app/social_lauout/cubit/social_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/social_app/social_lauout/feeds_screen.dart';
class SocialCubit extends Cubit<SocialStates>{
  SocialCubit():super(SocialInitState());
  static SocialCubit get(context)=>BlocProvider.of(context);
  TextEditingController commentController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  SocialUserModel? socialUserModel;
  int currentIndex = 0;
  String profileImageUrl = '';
  String profileCoverUrl = '';
  List<String> titles =[
    'Home',
    'Chats',
    'Profile',
    'Profile',
    'Settings'
  ];
List<Widget> screens =[
    FeedsScreen(),
    ChatsScreen(),
    const Center(child: Text('Add Post'),),
    const Center(child: Text('Add Post'),),
    SettingsScreen(),
];
List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(icon:  Icon(IconBroken.Home),label: 'Home'),
    BottomNavigationBarItem(icon:  Icon(IconBroken.Chat),label: 'Chats'),
    BottomNavigationBarItem(icon:  Icon(IconBroken.Paper_Upload),label: 'upload'),
    BottomNavigationBarItem(icon:  Icon(IconBroken.Location),label: 'Users'),
    BottomNavigationBarItem(icon:  Icon(IconBroken.Setting),label: 'Settings'),
  ];
void changeNavBar(int index){
  if(index == 1){
    getUsers();}
  if( index == 2) {
    emit(SocialUploadPostState());
  } else{
    currentIndex = index;
    emit(SocialChangeNavState());
  }
}
void incIndex(int index){
    index++;
    emit(SocialIncIndexState());
}


  void getUserData() {
    emit(SocialUpdateUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value){

      print(value.data());
      socialUserModel = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetSuccessState());
    }).catchError((error){
      print('Social Get Data! --> \n $error');
      emit(SocialGetErrorState(error.toString()));
    });

  }
  File? profileImage;
  File? coverImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialGetFileImageState());
    }else{
      print("No image selected!");
      emit(SocialGetFileImageErrorState());

    }
  }
  Future<void> getCoverImage() async{
    final cover = await picker.pickImage(source: ImageSource.gallery);
    if(cover != null){
      coverImage = File(cover.path);
      print(cover.path);

      emit(CoverImageChangeState());
    }else{
      print("No Image Selected!");
      emit(CoverImageErrorState());
    }
  }
  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,}){
    emit(SocialUpdateUserLoadingState());

    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri.file(profileImage!.path)
        .pathSegments.last}').putFile(profileImage!).then((value){
          value.ref.getDownloadURL().then((value){
            // profileImageUrl = value;
            updateUserData(name: name, phone: phone, bio: bio,image: value);
            // print(value);
            // emit(SocialUploadImageState());
          }).catchError((error){
            print(error.toString());
            emit(SocialUploadErrorState());
          });
    }).catchError((error){
      print(error.toString());
      emit(SocialUploadErrorState());

    });
  }
  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,}){
    emit(SocialUpdateUserLoadingState());

    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri.file(coverImage!.path).pathSegments.last}').putFile(coverImage!).then((value){
      value.ref.getDownloadURL().then((value){
        print(value);
        // profileCoverUrl = value;
        updateUserData(name: name, phone: phone, bio: bio,cover: value);

        // emit(SocialUploadCoverImageState());
      }).catchError((error){
        print(error.toString());
        emit(SocialUploadCoverErrorState());
      });
    }).catchError((error){
      print(error.toString());
      emit(SocialUploadCoverErrorState());

    });
  }
  // void updateUserImages({required String name,required String phone,required String bio}){
  // emit(SocialUpdateUserLoadingState());
  //   if(coverImage != null){
  //     uploadCoverImage();
  //     updateUserData(name: name,phone: phone,bio:bio);
  //   }else if(profileImage != null){
  //     uploadProfileImage();
  //   }else if(profileImage != null && coverImage != null){
  //     uploadProfileImage();
  //   }
  //   else{
  //
  //   }
  //
  // }
  // update profile data
  void updateUserData({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,}){
    emit(SocialUpdateUserLoadingState());

    SocialUserModel model = SocialUserModel(
        name: name,
        phone:phone,
        email: socialUserModel?.email,
        bio:bio,
        uId: socialUserModel?.uId,
        image:image??socialUserModel?.image,
        isEmailVerified: false,
        backgroundImage:cover?? socialUserModel?.backgroundImage //not updated may cause data loss
    );
    FirebaseFirestore.instance.collection('users').doc(socialUserModel!.uId
    ).update(model.toMap()).then((value){
      getUserData();
    }).catchError((error){
      print(error.toString());
      emit(SocialUploadErrorState());
    });
  }


  File? postImage;
  Future<void> getPostImage()async{
    final post = await picker.pickImage(source: ImageSource.gallery);
    if(post != null){
      postImage = File(post.path);
      emit(PostImageChangeState());
    }else{
      print('No Image Selected!');
      emit(PostImageErrorState());
    }
  }

  void removePostImage(){
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }){
    emit(SocialAddPostLoadingState());

    firebase_storage.FirebaseStorage.instance.ref().child('posts/${Uri.file(postImage!.path).pathSegments.last}').putFile(postImage!).then((value){
      value.ref.getDownloadURL().then((value){
        print(value);
        uploadPostData(dateTime: dateTime, text: text,postImage:value);

      });

    }).catchError((error){
      print(error.toString());
      emit(SocialAddPostErrorState());
    });
  }
  void uploadPostData({
  required String dateTime,
  String? postImage,
  required String text,}){
    emit(SocialAddPostLoadingState());

    PostModel model = PostModel(
        name: socialUserModel?.name,
        image:socialUserModel?.image,
        dateTime: dateTime,
        text:text,
        uId: socialUserModel?.uId,
        postImage: postImage??''
    );

    // FirebaseFirestore.instance.collection('posts').doc('1').update(model.toMap()).then((value){
      FirebaseFirestore.instance.collection('posts').add(model.toMap()).then((value) {
      emit(SocialAddPostState());
    }).catchError((error){
      print(error.toString());
      emit(SocialAddPostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<String> commentId = [];
  List<int> likes = [];
  List<String> comments = [];
  // get posts
  void getPosts(){
    FirebaseFirestore.instance.collection('posts').get().then((value)
    {
      for (var element in value.docs) {
        // print(element.id);
        element.reference.collection('likes').get().then((value){
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          emit(SocialGetPostsLikesState());

        }).catchError((error){
          print(error.toString());
        });
        element.reference.collection('comments').get().then((value){
          comments.add(value.docs.length.toString());
          commentId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          emit(SocialGetPostsCommentsState());

        }).catchError((error){
          print(error.toString());
        });

      }
      emit(SocialGetPostsState());
    }).catchError((error){
      print(error.toString());
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }


  // likes  function
void likePost(String postId){
    FirebaseFirestore.instance.collection('posts').doc(postId).collection('likes').doc(socialUserModel?.uId).set(
        {
         'like' : true
        }).then((value){
            emit(SocialGetLikesState());
    }).catchError((error){
      print(error.toString());
      emit(SocialGetLikesErrorState(error.toString()));
    });
}
void writeComment(String commentId){
    FirebaseFirestore.instance.collection('posts').doc(commentId).collection('comments').doc(socialUserModel?.uId).set(
        {
          'comment' : true,
          'comment-content' : commentController.text
        }).then((value){
          commentController.clear();
          emit(SocialWriteCommentState());
    }).then((error){
      print(error.toString());
      emit(SocialWriteCommentErrorState(error.toString()));
    });
}
List<SocialUserModel> users = [];
void getUsers(){
    // users = [];
    if(users.isEmpty){
      FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var element in value.docs){
          if(element.data()['uId'] != socialUserModel?.uId){
          users.add(SocialUserModel.fromJson(element.data()));
        }
        }
        emit(SocialGetAllUsersState());
      }).catchError((error){
        print(error.toString());
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
    }
}
// chat
// send message
void sendMessage({required String receiverId,required String dateTime,required String text}){
  MessageModel model = MessageModel(
    text: text,
    dateTime: dateTime,
    receriverId: receiverId,
    senderId: socialUserModel?.uId
  );
  //set sender chat
  FirebaseFirestore.instance.collection('users').doc(socialUserModel?.uId).collection('chats').doc(receiverId).collection('messages').add(model.toMap()).then((value){
      emit(SocialSendMessageState());
  }).catchError((error){
    print(error.toString());
    emit(SocialSendMessageErrorState(error.tostring));
  });
  //set receiver chat
    FirebaseFirestore.instance.collection('users').doc(receiverId).collection('chats').doc(socialUserModel?.uId).collection('messages').add(model.toMap()).then((value){
      emit(SocialSendMessageState());
    }).catchError((error){
      print(error.toString());
      emit(SocialSendMessageErrorState(error.tostring));
    });
}

List<MessageModel> messages = [];

void getMessages({required String receiverId}){
  FirebaseFirestore.instance.collection('users').doc(socialUserModel?.uId).collection('chats').doc(receiverId).collection('messages').snapshots().listen((event){
    messages = [];
    for(var element in event.docs){
      messages.add(MessageModel.fromJson(element.data()));
    }
    emit(SocialGetMessageState());
  });
}

}