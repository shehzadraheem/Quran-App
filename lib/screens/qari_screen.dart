import 'package:flutter/material.dart';

import '../models/qari.dart';
import '../services/api_services.dart';
import '../widgets/qari_custom_tile.dart';
import 'audio_surah_screen.dart';

class QariListScreen extends StatefulWidget {
  const QariListScreen({Key? key}) : super(key: key);

  @override
  _QariListScreenState createState() => _QariListScreenState();
}

class _QariListScreenState extends State<QariListScreen> {
  ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Qari\'s '),centerTitle: true,),
        body: Padding(
          padding: const EdgeInsets.only(top: 20,left: 12,right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 1,
                        spreadRadius: 0.0,
                        offset: Offset(0,1),
                      ),
                    ]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text('Search'),
                      Spacer(),
                      Icon(Icons.search),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Expanded(
                child: FutureBuilder(
                  future: apiServices.getQariList(),
                  builder: (BuildContext context , AsyncSnapshot<List<Qari>> snapshot){
                    if(snapshot.hasError){
                      return Center(child: Text('Qari\'s data not found '),);
                    }
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator(),);
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context , index){
                        return QariCustomTile(qari: snapshot.data![index],
                            ontap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder:(context)=>
                                      AudioSurahScreen(qari: snapshot.data![index])));
                            });
                      },
                    );

                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
