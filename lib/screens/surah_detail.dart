import 'package:flutter/material.dart';
import 'package:flutter_quran_yt/constants/constants.dart';

import '../models/translation.dart';
import '../services/api_services.dart';
import '../widgets/custom_translation.dart';

class Surahdetail extends StatefulWidget {
  const Surahdetail({Key? key}) : super(key: key);

  static const String id = 'surahDetail_screen';

  @override
  _SurahdetailState createState() => _SurahdetailState();
}

class _SurahdetailState extends State<Surahdetail> {

  ApiServices _apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _apiServices.getTranslation(Constants.surahIndex!),
        builder: (BuildContext context, AsyncSnapshot<SurahTranslationList> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          else if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.translationList.length,
              itemBuilder: (context,index){
                return TranslationTile(index: index,
                    surahTranslation: snapshot.data!.translationList[index]
                );
              },
            );
          }
          else return Center(child: Text('Translation Not found'),);
        },
      ),
    );
  }
}
