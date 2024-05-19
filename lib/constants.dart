import 'package:flutter/material.dart';
import 'package:social_app/shared/style/icon_broken.dart';

const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);
String? uId;
bool notAuthorized = false;
bool registered = false;


const kDefaultPadding= 20.0;
Widget defaultButton({
  double width=double.infinity,
  Color background=Colors.blue,
  Color textColor=Colors.white,
  required VoidCallback pressed,
  double height=40.0,
  required String text,
  bool isUpperCase=true,
}
    )=> Container(
  width:width ,
  height:height,
  decoration: BoxDecoration(
    color:background,
border: Border.all(color: Colors.black12,width: 1)
  ),
  child: MaterialButton(
    onPressed:pressed,
    child:Text(text.toUpperCase(),
        style: TextStyle(
          fontWeight:FontWeight.w400,
          color:textColor,
          fontSize:25.0,
        )),
  ),
);
Widget defaultTextButton({
  Color background=Colors.blue,
  required VoidCallback pressed,
  required String text,
}
    )=> TextButton(
      onPressed:pressed,
      child:Text(text.toUpperCase(),
          style:const TextStyle(
            fontWeight:FontWeight.w600,
            color:Colors.blue,
            fontSize:20.0,
          )),
    );

AppBar defaultAppBar(BuildContext context,{
  required String title,
  required List<Widget> actions
}
    )=> AppBar(
  titleSpacing: 5.0,
  leading: IconButton(onPressed: (){
    Navigator.pop(context);
  },
      icon: Icon(IconBroken.Arrow___Left_2),
  ),
  title: Text(title),
  actions: actions,
);

Widget defaultTextForm({
  required TextEditingController controller,
  required TextInputType type,
  double height=60.0,
  Function? onSubmit,
  // Function ?onChanged,
  bool isPassword=false,
  required String? Function(String?)? validate,
  required IconData prefix,
  required String label,
  VoidCallback? redEye,
  IconData? suffix,
  VoidCallback? onTap,
})=>SizedBox(
  height: height,
  child:   TextFormField(

    controller:controller,

    decoration:InputDecoration(

      labelText:label,

      border:OutlineInputBorder(),

      prefix:Icon(prefix),

      suffix:IconButton(onPressed:redEye,icon:Icon(suffix),

      ),),

    keyboardType:type,

    onTap:onTap,

    obscureText:isPassword,

    validator:validate

  ),
);
void navigateTo(context,Widget widget){
  Navigator.push(context,MaterialPageRoute(builder: (context)=>widget));
}