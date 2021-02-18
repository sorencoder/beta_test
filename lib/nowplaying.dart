import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
class NowPlaying extends StatefulWidget {
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  String url2 ='https://firebasestorage.googleapis.com/v0/b/fir-9e06b.appspot.com/o/y2mate.com%20-%20O%20Dear%20Darling%20Nagpuri%20Song.mp3?alt=media&token=7eeeb050-5a3a-45ae-8e44-10fd4b833a4e';
  String url1 ='https://firebasestorage.googleapis.com/v0/b/fir-9e06b.appspot.com/o/DINGRA%20KORA%20%20NEW%20SANTHALI%20VIDEO%20%20ATISH%20TUDU%20%20ASHA%20KIRAN%20TUDU%20%20SHYAM%20MARANDI%20%20RESHMA%20HEMBROM.mp3?alt=media&token=e56556a6-b458-47d0-9c1f-b4536449076f';
  String url = 'https://firebasestorage.googleapis.com/v0/b/fir-9e06b.appspot.com/o/Heart%20Beat%20%20Nawab%20%20Gurlez%20Akhtar%20%20Pranjal%20Dahiya%20%20%20Desi%20Crew%20%20Latest%20Punjabi%20Songs%202021.mp3?alt=media&token=8d626c4c-33d2-4b36-99e4-a844d5d1d1b1';
  // double _currentSliderValue = 5;
  // bool _isPlaying = false;
  bool _isFavourite = false;
  bool _isShuffle = false;
  String artistName = 'Tom Murmu';
  String songName = 'Song Name';
  Duration duration;
  Duration position;
  String audioState;
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  initState(){
    initAudio();
    super.initState();
  }
  initAudio() {
    audioPlayer.onPlayerStateChanged.listen((playerState) {
      if(playerState == AudioPlayerState.STOPPED)
        audioState = "Stopped";
      if(playerState==AudioPlayerState.PLAYING)
        audioState = "Playing";
      if(playerState==AudioPlayerState.PAUSED)
        audioState = "Paused";
    });
  }

  play() async{
    await audioPlayer.stop();
    await audioPlayer.play(url);
    audioPlayer.onAudioPositionChanged.listen((Duration p) {
      setState(() {
        position=p;
      });
    });
    audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        duration = d;
      });
    });
  }
  pause()async{
    await audioPlayer.pause();
  }
  resume()async{
    await audioPlayer.resume();
  }
  playPrevious()async{
    await audioPlayer.stop();
    await audioPlayer.play(url2);
  }
  playNext() async{
    await audioPlayer.stop();
    await  audioPlayer.play(url1);
    // audioPlayer.onAudioPositionChanged.listen((Duration p) {
    //   setState(() {
    //     position=p;
    //   });
    // });
    // audioPlayer.onDurationChanged.listen((Duration d) {
    //   setState(() {
    //     duration = d;
    //   });
    // });
  }
  seek(Duration duration){
    audioPlayer.seek(duration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Now Playing',style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: Container(
        height:MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 5,),
            Container(
              height: 150,
            width: 150,
              child: Image.asset("assets/images/cover.jpg"),
            decoration: BoxDecoration(
              // image: DecorationImage(
              //   image: AssetsImage("assets/images/cover.jpg"),
              // ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            ),
            SizedBox(height: 10,),
            Text(songName,style: TextStyle(color: Colors.black,fontSize: 30),),
            SizedBox(height: 10,),
            Text(artistName,style: TextStyle(color: Colors.black,fontSize: 15),),
            SizedBox(height: 25,),
            Slider(
                value:position==null?0:position.inMilliseconds.toDouble(),
                max: duration==null?20:duration.inMilliseconds.toDouble(),
                min: 0,
                inactiveColor: Colors.teal,
               onChanged: (value){
                  seek(Duration(milliseconds: value.toInt()));
               },
            ),
            Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50,
                  child: Text(position.toString().split('.').first,style: TextStyle(fontSize: 15),),
                ),
                Container(
                  width: 50,
                  child: Text(duration.toString().split('.').first,style: TextStyle(fontSize: 15),),
                )
              ],
            ),
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(icon: Icon(_isFavourite ? Icons.favorite : Icons.favorite_border),onPressed: () {
          _isFavourite = !_isFavourite;
          setState(() {

          });
      }),
                IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
                  playPrevious();
                }),
                IconButton(icon: Icon(audioState=="Playing"? Icons.pause_circle_outline:Icons.play_circle_outline), onPressed: (){
                  setState(() {
                  });
                  audioState=="Playing"?pause():resume();
                },iconSize: 70,),
                IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: (){
                  playNext();
                }),
                IconButton(icon: Icon(_isShuffle?Icons.shuffle:Icons.loop), onPressed: (){
                  _isShuffle=!_isShuffle;
                  setState(() {

                  });
                })
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: ()=>play(),
      ),
    );
  }
}