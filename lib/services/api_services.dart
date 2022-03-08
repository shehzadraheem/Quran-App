import 'dart:convert';
import 'dart:math';
import 'package:flutter_quran_yt/models/aya_of_the_day.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../models/juz.dart';
import '../models/sajda.dart';
import '../models/surah.dart';
import '../models/translation.dart';

class ApiServices{

  final endPointUrl ="http://api.alquran.cloud/v1/surah";
  List<Surah> list = [];

  Future<AyaOfTheDay> getAyaOfTheDay() async {

    // for random Aya we need to generate random number
    // (1,6237) from 1 to 6236
    // Random Aya
    String url = "https://api.alquran.cloud/v1/ayah/${random(1,6237)}/editions/quran-uthmani,en.asad,en.pickthall";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
        return AyaOfTheDay.fromJSON(json.decode(response.body));
    } else {
      print("Failed to load");
      throw Exception("Failed  to Load Post");
    }
  }
  random(min, max){
    var rn = new Random();
    return min + rn.nextInt(max - min);
  }

  Future<List<Surah>> getSurah() async{

    Response res = await http.get(Uri.parse(endPointUrl));
    if(res.statusCode == 200){
      Map<String,dynamic> json = jsonDecode(res.body);
      json['data'].forEach((element){
        if(list.length<114) {
          list.add(Surah.fromJson(element));
        }
      });
      print('ol ${list.length}');
      return list;
    }else{
      throw ("Can't get the Surah");
    }
  }

  Future<SajdaList> getSajda() async {
    String url =   "http://api.alquran.cloud/v1/sajda/en.asad";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return SajdaList.fromJSON(json.decode(response.body));
    } else {
      print("Failed to load");
      throw Exception("Failed  to Load Post");
    }
  }

  Future<JuzModel> getJuzz(int index) async {
    String url = "http://api.alquran.cloud/v1/juz/$index/quran-uthmani";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return JuzModel.fromJSON(json.decode(response.body));
    } else {
      print("Failed to load");
      throw Exception("Failed  to Load Post");
    }
  }

  Future<SurahTranslationList> getTranslation(int index) async{
    final url = "https://quranenc.com/api/translation/sura/urdu_junagarhi/$index";
    var res = await http.get(Uri.parse(url));

    return SurahTranslationList.fromJson(json.decode(res.body));
  }
}