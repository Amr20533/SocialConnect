abstract class SocialStates{}
class SocialInitState extends SocialStates {}
class SocialIncIndexState extends SocialStates {}
class SocialChangeNavState extends SocialStates {}
class SocialUploadPostState extends SocialStates {}
// get User Data states
class SocialGetSuccessState extends SocialStates {}
class SocialGetErrorState extends SocialStates {
  final String error;
  SocialGetErrorState(this.error);
}
// get All User Data states
class SocialGetAllUsersState extends SocialStates {}
class SocialGetAllUsersErrorState extends SocialStates {
  final String error;
  SocialGetAllUsersErrorState(this.error);
}
// get posts states
class SocialGetPostsState extends SocialStates {}
class SocialGetPostsLoadingState extends SocialStates {}
class SocialGetPostsErrorState extends SocialStates {
  final String error;
  SocialGetPostsErrorState(this.error);
}
// likes & getLikes STATES
class SocialGetPostsLikesState extends SocialStates {}

class SocialGetLikesState extends SocialStates {}
class SocialGetLikesLoadingState extends SocialStates {}
class SocialUpdateUserLoadingState extends SocialStates {}
class SocialGetLikesErrorState extends SocialStates {
  final String error;
  SocialGetLikesErrorState(this.error);
}

// class SocialGetLikesState extends SocialStates {}
class SocialWriteCommentState extends SocialStates {}
class SocialGetPostsCommentsState extends SocialStates {}
class SocialWriteCommentErrorState extends SocialStates {
  final String error;
  SocialWriteCommentErrorState(this.error);
}

// update user data states
class SocialUpdateUserErrorState extends SocialStates {}

// profile image states
class SocialGetFileImageState extends SocialStates {}
class SocialGetFileImageErrorState extends SocialStates {}
//cover image states
class CoverImageChangeState extends SocialStates {}
class CoverImageErrorState extends SocialStates {}
// post image states
class PostImageChangeState extends SocialStates {}
class PostImageErrorState extends SocialStates {}
// uploadImage states
class SocialUploadImageState extends SocialStates {}
class SocialUploadErrorState extends SocialStates {}
//upload coverImagesStates
class SocialUploadCoverImageState extends SocialStates {}
class SocialUploadCoverErrorState extends SocialStates {}
// add posts states
class SocialAddPostLoadingState extends SocialStates {}
class SocialAddPostErrorState extends SocialStates {}
class SocialAddPostState extends SocialStates {}
// remove post state
class SocialRemovePostImageState extends SocialStates {}

// chat
class SocialGetMessageState extends SocialStates{}
class SocialGetMessageErrorState extends SocialStates{
  String error;
  SocialGetMessageErrorState(this.error);
}
class SocialSendMessageState extends SocialStates{}
class SocialSendMessageErrorState extends SocialStates{
  String error;
  SocialSendMessageErrorState(this.error);
}
