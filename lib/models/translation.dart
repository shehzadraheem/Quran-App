
class SurahTranslationList{
  final List<SurahTranslation> translationList;

  SurahTranslationList({required this.translationList});

  factory SurahTranslationList.fromJson(Map<String,dynamic> map){
    Iterable translation = map['result'];
    List<SurahTranslation> list = translation.map((e) =>SurahTranslation.fromJson(e)).toList();
    print(list.length);
    return SurahTranslationList(translationList: list);
  }
}

class SurahTranslation{
   String? sura;
   String? aya;
   String? arabic_text;
   String? translation;

  SurahTranslation({this.sura, this.aya, this.arabic_text, this.translation});

  factory SurahTranslation.fromJson(Map<String,dynamic> json){
    return SurahTranslation(
        sura: json['sura'],
        aya: json['aya'],
        arabic_text: json['arabic_text'],
        translation: json['translation'],
    );
  }
}