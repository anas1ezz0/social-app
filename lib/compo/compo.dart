// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, void_checks, sized_box_for_whitespace

import 'package:flutter/material.dart';
import '../style/colors.dart';
import '../style/icon_broken.dart';



Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  bool isUpperCase = true,
  required Function function,
  required String text ,
}) =>  Container(
  width: width,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    color: background,

  ),
  child: MaterialButton(
      onPressed: (){
        function();
      },
      height: 50.0,
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: const TextStyle(
            color: Colors.white
        ),
      )),
);
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData? prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
})
=> TextFormField(
  style: TextStyle(fontSize: 15),
  controller: controller,
  keyboardType: type ,
  obscureText: isPassword,
  enabled: isClickable,
  onFieldSubmitted: (s)
  {
    onSubmit!(s);
  },
// onChanged: (s)
// {
// onChange!();
// },
  validator: (a){
    return validate(a);
  },
cursorColor: Colors.black,
  decoration: InputDecoration(
      suffixIcon: suffix != null?(IconButton(
        onPressed: (){
          suffixPressed!();
        },
        icon: Icon(
            suffix
        ),
      )):null,
      labelText: label,
      labelStyle: TextStyle(color: defaultColor,fontSize: 15),
      prefixIcon: Icon(
          prefix
      ),
      enabled: true,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: defaultColor
          )),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black
          )
      ),
      border:   OutlineInputBorder(
          borderSide: BorderSide(
              color: defaultColor)
      )
  ),
);
Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300]
  ),
);

Widget defaultAppBar({
  required String title,
   BuildContext? context,
   List<Widget>? actions,
})=>  AppBar(
 leading: IconButton(
   onPressed: (){
     Navigator.pop(context!);
   },
   icon: Icon(IconBroken.Arrow___Left_2),
 ),
  title: Text(title),
  actions: actions
  ,
);


void navigateTo(
    context,widget)=> Navigator.push(
    context,
    MaterialPageRoute(
      builder:
          (context) => widget ,

    )
);

void navigateAndFinsh(context,widget)=>Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(
  builder:
      (context) => widget ,

), (route) => false);
// void showToast({
//   required String text,
//   required ToastStates state,
// })=> Fluttertoast.showToast(
//     msg:text,
//     toastLength: Toast.LENGTH_LONG,
//     gravity: ToastGravity.BOTTOM,
//     timeInSecForIosWeb: 5,
//     backgroundColor: chooseToastColor(state),
//     textColor: Colors.white,
//     fontSize: 16.0
// );
// enum

enum ToastStates{success , error,warning}
Color chooseToastColor(ToastStates state)
{
  Color color;
  switch(state)
  {
    case ToastStates.success:
      color= Colors.green;
      break;
    case ToastStates.error:
      color= Colors.red;
      break;
    case ToastStates.warning:
      color= Colors.amber;
      break;

  }
  return color;
}


Widget buildListProduct(
    model,
    context, {
      bool isOldPrice = true,
    }) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: 120.0,
                  height: 120.0,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.teal,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          model.oldPrice.toString(),
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      // IconButton(
                      //   onPressed: () {
                      //     // SocialCubit.get(context).changeFavourites(model.id);
                      //   },
                      //   icon: CircleAvatar(
                      //     radius: 15.0,
                      //     backgroundColor:
                      //     // SocialCubit.get(context).favourites[model.id]!
                      //         ? Colors.teal
                      //         : Colors.grey,
                      //     child: Icon(
                      //       Icons.favorite_border,
                      //       size: 14.0,
                      //       color: Colors.white,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );