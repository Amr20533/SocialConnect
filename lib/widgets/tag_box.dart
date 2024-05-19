import 'package:flutter/material.dart';

class TagBox extends StatelessWidget {
  const TagBox({required this.onPressed,required this.title, Key? key}) : super(key: key);
  final VoidCallback onPressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25.0,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: MaterialButton( onPressed:onPressed,
          minWidth: 1.0,
          padding: EdgeInsets.zero,
          child: Text('#$title',style:Theme.of(context).textTheme.caption!.copyWith(color: Colors.blue,fontWeight: FontWeight.w500),)),
    );
  }
}
