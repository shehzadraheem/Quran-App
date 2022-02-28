import 'package:flutter/material.dart';
import 'package:flutter_quran_yt/constants/constants.dart';

import '../models/sajda.dart';
import '../models/surah.dart';
import '../services/api_services.dart';
import '../widgets/sajda_custom_tile.dart';
import '../widgets/surah_custem_tile.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({Key? key}) : super(key: key);

  @override
  _QuranScreenState createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {

  ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Added
      initialIndex: 0,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Quran'),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Text(
                  'Surah',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),//index - 0
                Text(
                  'Sajda',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),//index - 1
                Text(
                  'Juz',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),// index - 2
              ],
            ),
          ),
          body: TabBarView(
            children:  <Widget>[
              FutureBuilder(
                future: apiServices.getSurah(),
                builder: (BuildContext context, AsyncSnapshot<List<Surah>> snapshot) {
                  if (snapshot.hasData) {
                    List<Surah>? surah = snapshot.data;
                    return ListView.builder(
                      itemCount: surah!.length,
                      itemBuilder: (context, index) => SurahCustomListTile(surah: surah[index],
                          context: context, ontap: (){}),
                     );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              FutureBuilder(
                future: apiServices.getSajda(),
                builder: (context,AsyncSnapshot<SajdaList> snapshot){
                  if(snapshot.hasError){
                    return Center(child: Text('Something went wrong'),);
                  }
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.sajdaAyahs.length,
                    itemBuilder: (context , index) => SajdaCustomTile(snapshot.data!.sajdaAyahs[index], context),
                  );
                },
              ),
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                    itemCount: 30,
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: (){
                        },
                        child: Card(
                          elevation: 4,
                          color: Colors.blueGrey,
                          child: Center(
                            child: Text('${index+1} ',style: TextStyle(color: Colors.white,fontSize: 20),),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
