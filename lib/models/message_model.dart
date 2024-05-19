class MessageModel{
  String? senderId;
  String? receriverId;
  String? dateTime;
  String? text;
  MessageModel({required this.dateTime,required this.senderId,required this.text,required this.receriverId});
  MessageModel.fromJson(Map<String,dynamic> json){
    senderId = json['senderId'];
    receriverId = json['receriverId'];
    dateTime = json['dateTime'];
    text = json['text'];
  }
  Map<String,dynamic> toMap(){
    Map<String,dynamic> data = <String,dynamic>{};
    data['senderId'] = senderId;
    data['receriverId'] = receriverId;
    data['dateTime'] = dateTime;
    data['text'] = text;
    return data;
  }
}