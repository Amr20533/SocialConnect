class PostModel{
  String? name,postImage,uId,image,dateTime,text;
  PostModel({this.image,this.name,this.uId,this.postImage,this.text,this.dateTime});
  PostModel.fromJson(Map<String,dynamic> json){
    postImage = json['postImage'];
    name = json['name'];
    dateTime = json['dateTime'];
    uId = json['uId'];
    text = json['text'];
    image = json['image'];
  }
  Map<String,dynamic> toMap(){
    Map<String,dynamic> data =<String,dynamic>{};
    data['text'] = text;
    data['postImage'] = postImage;
    data['name'] = name;
    data['dateTime'] = dateTime;
    data['uId'] = uId;
    data['image'] = image;
    return data;
  }
}