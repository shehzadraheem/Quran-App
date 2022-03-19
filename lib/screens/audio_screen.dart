import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:rxdart/rxdart.dart';

import '../constants/constants.dart';
import '../models/qari.dart';
import '../models/surah.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({Key? key,required this.qari , required this.index ,required this.list}) : super(key: key);
  final Qari qari;
  final int index;
  final List<Surah>? list;

  @override
  _AudioScreenState createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final _player = AudioPlayer();
  bool isLoopingCurrentItem = false;
  Duration defaultDuration = Duration(milliseconds: 1);
  String? ind;
  int currentIndex = 0;
  int dataIndex = 0;

  @override
  void initState() {


    setState(() {
      currentIndex = widget.index-1;
      dataIndex = widget.index - 1;
    });

    // Surah is from 1 to 114 so
    // 001 , 002 , 003 ..... 010, 011 , 012 , .....099 , 100 , 101, ...114
    if(widget.index<10){
      ind = "00"+(widget.index.toString());
    }else if(widget.index<100){
      ind  = "0"+(widget.index.toString());
    }else if(widget.index>100){
      ind = (widget.index.toString());
    }


    _initAudioPlayer(ind!,widget.qari);

    print('index ${widget.index}   current Index ${currentIndex}');
    super.initState();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }


  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      _player.stop();
    }
  }

  void handleLooping() async {
    if (isLoopingCurrentItem)
      await _player.setLoopMode(LoopMode.one);
    else
      await _player.setLoopMode(LoopMode.off);
    setState(() {
      isLoopingCurrentItem = !isLoopingCurrentItem;
    });
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
              (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
   // double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios , color: Colors.black,),
        ),
        title: Text('Now Playing',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800),),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.2,
                padding: EdgeInsets.all(20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Constants.kPrimary,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      offset: Offset(0,2),
                      color: Colors.black12
                    ),
                  ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.list![currentIndex].name!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Total Aya : ${widget.list![currentIndex].numberOfAyahs}',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
              Container(
                // margin: EdgeInsets.symmetric(
                //     vertical: _width * 0.1, horizontal: _width * 0.015),
                child: StreamBuilder<PositionData>(
                  stream: _positionDataStream,
                  builder: (context, snapshot) {
                    final positionData = snapshot.data;
                    return SeekBar(
                      duration: positionData?.duration ?? defaultDuration,
                      position: positionData?.position ?? Duration.zero,
                      bufferedPosition:
                      positionData?.bufferedPosition ?? Duration.zero,
                      onChanged: _player.seek,
                    );
                  },
                ),
              ),
              SizedBox(height: 10,),
              Container(
               // margin: EdgeInsets.symmetric(horizontal: _width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          if(currentIndex > 0){
                             setState(() {
                               dataIndex = currentIndex;
                               currentIndex--;
                             });
                             if(dataIndex<10){
                               ind = "00"+(dataIndex.toString());
                             }else if(dataIndex<100){
                               ind  = "0"+(dataIndex.toString());
                             }else if(dataIndex>100){
                               ind = (dataIndex.toString());
                             }

                             _initAudioPlayer(ind!, widget.qari);

                          }
                        },
                        icon: Icon(
                          FontAwesomeIcons.stepBackward,
                          color: Colors.black,
                          size: MediaQuery.of(context).size.width * 0.05,
                        )),
                    StreamBuilder<PlayerState>(
                      stream: _player.playerStateStream,
                      builder: (context, snapshot) {
                        final playerState = snapshot.data;
                        final processingState = playerState?.processingState;
                        final playing = playerState?.playing;
                        if (processingState == ProcessingState.loading ||
                            processingState == ProcessingState.buffering) {
                          return Container(
                              //padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Constants.kPrimary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                             // width: _width * 0.24,
                             // height: _width * 0.24,
                              child: SpinKitRipple(
                                color: Colors.black,
                                duration: Duration(milliseconds: 800),
                              //  size: _width * 0.24,
                              ));
                        } else if (playing != true) {
                          return InkWell(
                            onTap: _player.play,
                            child: Container(
                              //width: _width * 0.24,
                              //height: _width * 0.24,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Constants.kPrimary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(
                                FontAwesomeIcons.play,
                                color: Colors.black,
                                size: MediaQuery.of(context).size.width * 0.05,
                              ),
                            ),
                          );
                        } else if (processingState != ProcessingState.completed) {
                          return InkWell(
                            onTap: _player.pause,
                            child: Container(
                            //  width: _width * 0.24,
                            //  height: _width * 0.24,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Constants.kPrimary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(
                                FontAwesomeIcons.pause,
                                color: Colors.black,
                                size: MediaQuery.of(context).size.width * 0.05,
                              ),
                            ),
                          );
                        } else {
                          return InkWell(
                            onTap: () => _player.seek(Duration.zero),
                            child: Container(
                            //  width: _width * 0.24,
                            //  height: _width * 0.24,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Constants.kPrimary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(
                                Icons.shuffle,
                                color: Colors.black,
                                size: MediaQuery.of(context).size.width * 0.05,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        if(currentIndex >= 0 && currentIndex<113){
                          //currentIndex = (currentIndex + 1);
                          setState(() {
                            currentIndex++;
                            dataIndex = currentIndex + 1;
                          });
                          if(dataIndex<10){
                            ind = "00"+(dataIndex.toString());
                          }else if(dataIndex<100){
                            ind  = "0"+(dataIndex.toString());
                          }else if(dataIndex>100){
                            ind = (dataIndex.toString());
                          }

                          _initAudioPlayer(ind!, widget.qari);

                        }
                      },
                      icon: Icon(
                        FontAwesomeIcons.stepForward,
                        color: Colors.black,
                        size: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.volume_up,
                      size: MediaQuery.of(context).size.width * 0.1,
                      ),
                      onPressed: () {
                        showSliderDialog(
                          context: context,
                          title: "Adjust volume",
                          divisions: 10,
                          min: 0.0,
                          max: 1.0,
                          value: _player.volume,
                          stream: _player.volumeStream,
                          onChanged: _player.setVolume,
                        );
                      },
                    ),
                    // Opens speed slider dialog
                    StreamBuilder<double>(
                      stream: _player.speedStream,
                      builder: (context, snapshot) => IconButton(
                        icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                        onPressed: () {
                          showSliderDialog(
                            context: context,
                            title: "Adjust speed",
                            divisions: 10,
                            min: 0.5,
                            max: 1.5,
                            value: _player.speed,
                            stream: _player.speedStream,
                            onChanged: _player.setSpeed,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              currentIndex >= 113 ? Container() :Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        spreadRadius: 0.01,
                        offset: Offset(0.0,1),
                      ),
                    ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('UPCOMING SURAH',style: TextStyle(color: Colors.black,
                            fontSize: 20,fontWeight: FontWeight.bold),),
                        SizedBox(height: 12,),
                        Visibility(
                          visible: (currentIndex<=112) ? true : false,
                          child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Icon(Icons.play_circle_fill,color: Constants.kPrimary,),
                             Text(widget.list![currentIndex+1].name!,style: TextStyle(color: Colors.black,
                             fontSize: 20),),
                           ],
                       ),
                        ),
                        SizedBox(height: 12,),
                        Visibility(
                          visible: ( currentIndex <=111) ? true : false,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(currentIndex>111 ? null :Icons.play_circle_fill,color: Constants.kPrimary,),
                              Text(currentIndex>111 ? '' : widget.list![currentIndex+2].name!,style: TextStyle(color: Colors.black,
                                  fontSize: 20),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _initAudioPlayer(String ind, Qari qari,) async {
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
          print('A stream error occurred: $e');
        });
    // Try to load audio from a source and catch any errors.
    try {
      var url = "https://download.quranicaudio.com/quran/${qari.path}$ind.mp3";
      print('url $url');
     defaultDuration =  (await _player.setAudioSource(AudioSource.uri(Uri.parse(url))))!;
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

}



class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}


class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;

  SeekBar({
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
  });

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double? _dragValue;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Constants.kPrimary,
            inactiveTrackColor: Colors.grey,
            trackHeight: 5.0,
            thumbColor: Constants.kPrimary,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
            overlayColor: Colors.purple.withAlpha(32),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 14.0),
          ),
          child: Slider(
            min: 0.0,
            max: widget.duration.inMilliseconds.toDouble(),
            value: min(_dragValue ?? widget.position.inMilliseconds.toDouble(),
                widget.duration.inMilliseconds.toDouble()),
            onChanged: (value) {
              setState(() {
                _dragValue = value;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(Duration(milliseconds: value.round()));
              }
              _dragValue = null;
            },
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: _width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _positionText,
                style: TextStyle(
                    color: Colors.black,
                   // fontFamily: MyFont.alegreyaSansRegular,
                    fontSize: _width * 0.05),
              ),
              Text(
                _durationText,
                style: TextStyle(
                    color: Colors.black,
                  //  fontFamily: MyFont.alegreyaSansRegular,
                    fontSize: _width * 0.05),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String get _durationText =>
      "${widget.duration.inMinutes.remainder(60).toString().padLeft(2, '0')}"
          ":${widget.duration.inSeconds.remainder(60).toString().padLeft(2, '0')}";

  String get _positionText =>
      "${widget.position.inMinutes.remainder(60).toString().padLeft(2, '0')}"
          ":${widget.position.inSeconds.remainder(60).toString().padLeft(2, '0')}";
}



void showSliderDialog({
  required BuildContext context,
  required String title,
  required int divisions,
  required double min,
  required double max,
  String valueSuffix = '',

  required double value,
  required Stream<double> stream,
  required ValueChanged<double> onChanged,}) {
  showDialog<void>(
    context: context,
    builder: (context) =>
        AlertDialog(
          title: Text(title, textAlign: TextAlign.center),
          content: StreamBuilder<double>(
            stream: stream,
            builder: (context, snapshot) =>
                Container(
                  height: 100.0,
                  child: Column(
                    children: [
                      Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                          style: TextStyle(
                              fontFamily: 'Fixed',
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0)),
                      Slider(
                        divisions: divisions,
                        min: min,
                        max: max,
                        value: snapshot.data ?? value,
                        onChanged: onChanged,
                      ),
                    ],
                  ),
                ),
          ),
        ),
  );
}










