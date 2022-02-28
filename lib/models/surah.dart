class Surah{

  int? number;
  String? name;
  String? englishName;
  String? englishNameTranslation;
  int? numberOfAyahs;
  String? revelationType;

  Surah({this.number, this.name, this.englishName, this.englishNameTranslation,
      this.numberOfAyahs, this.revelationType});

  factory  Surah.fromJson(Map<String,dynamic> json){
    return Surah(
      number: json['number'],
      name: json['name'],
      englishName: json['englishName'],
      englishNameTranslation: json['englishNameTranslation'],
      numberOfAyahs: json['numberOfAyahs'],
      revelationType: json['revelationType'],
    );
  }
}