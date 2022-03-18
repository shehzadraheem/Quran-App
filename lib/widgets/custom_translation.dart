import 'package:flutter/material.dart';
import 'package:flutter_quran_yt/constants/constants.dart';
import '../models/translation.dart';

class TranslationTile extends StatelessWidget {
  final int index;
  final SurahTranslation surahTranslation;

  TranslationTile({required this.index,required this.surahTranslation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              blurRadius: 1
            ),
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                     color: Constants.kPrimary,
                    //color: Color(0xffA5D2D6),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                  ),
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                ),
                Positioned(
                  top: 3,
                  left: 12,
                  child: Container(
                    padding: EdgeInsets.all(6),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black
                    ),
                    child: Text(surahTranslation.aya!,
                      style: TextStyle(color: Colors.white,fontSize: 16),),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  SizedBox(
                    width: double.infinity,
                    child: Text(surahTranslation.arabic_text!,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      surahTranslation.translation!,
                      textAlign: TextAlign.end,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
