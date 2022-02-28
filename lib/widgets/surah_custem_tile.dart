import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/surah.dart';

Widget SurahCustomListTile({
     required Surah surah ,
     required BuildContext context ,
     required VoidCallback ontap})
{
  return GestureDetector(
     onTap: ontap,
     child: Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3.0,
            ),
          ]),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                height: 30,
                width: 40,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: Text((surah.number).toString(),
                  style: TextStyle(color:Colors.white ,fontSize: 16,fontWeight: FontWeight.bold),),
              ),
              SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(surah.englishName!,style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(surah.englishNameTranslation!),
                ],
              ),
              Spacer(),
              Text(surah.name!,style: TextStyle(color: Colors.black54,
                  fontWeight: FontWeight.bold,fontSize: 20),),
            ],
          ),
        ],
      ),
    ),
  );
}


