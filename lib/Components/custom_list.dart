import 'package:flutter/material.dart';

Widget customListTile({
  required String title,
  required String artistName,
  required String cover,
  onTap
}) {
  return  InkWell(
    onTap: onTap,
    child: Container(
    padding: EdgeInsets.all(8),
    child: Row(
      children: [
        Container(
          height:80.0,
          width: 80.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            image: DecorationImage(
              image: NetworkImage(cover),
            )

          ),
        ),
        SizedBox(width: 10.0),
        Column(
          children: [
            Text(title,
              style:
              TextStyle(
                color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,

            ),
            ),
            SizedBox(height: 5.0,),
            Text(artistName, style: TextStyle(color:Colors.white, fontSize: 16.0 ),)
          ],
        )
      ],
    ),

  ),
  );
}