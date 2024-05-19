import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({required this.alignment,required this.text,required this.color,required this.borderRadius,Key? key}) : super(key: key);
  final AlignmentDirectional alignment;
  final String text;
  final Color color;
  final BorderRadiusDirectional borderRadius;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10),
          decoration: BoxDecoration(
              color: color,
              borderRadius: borderRadius),
          child: Text(text,style:const TextStyle(fontSize: 16,fontWeight: FontWeight.w400),)),
    );
  }
}
