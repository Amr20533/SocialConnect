class SocialUserModel{
  String? name,phone,email,uId,image,bio,backgroundImage;
  bool? isEmailVerified;
  SocialUserModel({this.phone,this.backgroundImage,this.email,this.bio,this.image,this.name,this.uId,this.isEmailVerified});
  SocialUserModel.fromJson(Map<String,dynamic> json){
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
    image = json['image'];
    backgroundImage = json['backgroundImage'];
    bio = json['bio'];
  }
  Map<String,dynamic> toMap(){
    Map<String,dynamic> data =<String,dynamic>{};
    data['email'] = email;
    data['phone'] = phone;
    data['name'] = name;
    data['backgroundImage'] = backgroundImage;
    data['uId'] = uId;
    data['image'] = image;
    data['bio'] = bio;
    data['isEmailVerified'] = isEmailVerified;
    return data;
  }
}