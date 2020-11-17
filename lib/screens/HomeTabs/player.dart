import 'dart:async';
import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';

typedef void OnError(Exception exception);


enum PlayerState { stopped, playing, paused }

class AudioApp extends StatefulWidget {
  var kUrl;
  var name;
  var image;
  var title;
  AudioApp({this.kUrl, this.image,this.name, this.title});

  @override
  _AudioAppState createState() => _AudioAppState();
}

class _AudioAppState extends State<AudioApp> {
  Duration duration;
  Duration position;

  AudioPlayer audioPlayer;

  String localFilePath;

  PlayerState playerState = PlayerState.stopped;

  get isPlaying => playerState == PlayerState.playing;
  get isPaused => playerState == PlayerState.paused;

  get durationText =>
      duration != null ? duration.toString().split('.').first : '';

  get positionText =>
      position != null ? position.toString().split('.').first : '';

  bool isMuted = false;

  StreamSubscription _positionSubscription;
  StreamSubscription _audioPlayerStateSubscription;

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  @override
  void dispose() {
    _positionSubscription.cancel();
    _audioPlayerStateSubscription.cancel();
    audioPlayer.stop();
    super.dispose();
  }

  void initAudioPlayer() {
    audioPlayer = AudioPlayer();
    _positionSubscription = audioPlayer.onAudioPositionChanged
        .listen((p) => setState(() => position = p));
    _audioPlayerStateSubscription =
        audioPlayer.onPlayerStateChanged.listen((s) {
          if (s == AudioPlayerState.PLAYING) {
            setState(() => duration = audioPlayer.duration);
          } else if (s == AudioPlayerState.STOPPED) {
            onComplete();
            setState(() {
              position = duration;
            });
          }
        }, onError: (msg) {
          setState(() {
            playerState = PlayerState.stopped;
            duration = Duration(seconds: 0);
            position = Duration(seconds: 0);
          });
        });
  }

  Future play() async {
    await audioPlayer.play(widget.kUrl);
    setState(() {
      playerState = PlayerState.playing;
    });
  }


  Future pause() async {
    await audioPlayer.pause();
    setState(() => playerState = PlayerState.paused);
  }

  Future stop() async {
    await audioPlayer.stop();
    setState(() {
      playerState = PlayerState.stopped;
      position = Duration();
    });
  }

  Future mute(bool muted) async {
    await audioPlayer.mute(muted);
    setState(() {
      isMuted = muted;
    });
  }

  void onComplete() {
    setState(() => playerState = PlayerState.stopped);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: Scaffold(
        appBar: AppBar(
          leading: Center(child: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.cancel,color:  Color(0xFF340c64), size: 35,))),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Center(
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom:0.0),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: 200,
                              height: 200,
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 7.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(5.0, 5.0), // shadow direction: bottom right
                                  )
                                ],
                              ),
                              child: Text(''),// child widget, replace with your own
                          ),

                          Positioned.fill(
                              child:Container(
                                margin: EdgeInsets.all(15),
                                child: Hero(
                                  tag: widget.name,
                                       child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                      radius: 20,
                                      backgroundImage: NetworkImage(widget.image.toString())
                                  ),
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Text(
                    widget.name,
                    style: TextStyle(color: Color(0xFF340c64),fontSize: 17, fontWeight: FontWeight.bold),
                ),
                  ),
                    Text(
                       widget.title,
                      style: TextStyle(color: Color(0xFF340c64),),
                    ),
                Material(child: _buildPlayer()),

        ],
        ),
        ),
        ),
      ),
    );
  }

  Widget _buildPlayer() => Container(
      padding: EdgeInsets.all(4.0),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
      audioPlayer.loading?Text('Loading...', style: TextStyle(fontWeight:FontWeight.bold),):Container(),
      if (duration != null)
  SliderTheme(
  data: SliderTheme.of(context).copyWith(
  activeTrackColor: Color(0xFF340c64),
  inactiveTrackColor: Color(0xFF340c64),
  trackShape: RoundedRectSliderTrackShape(),
  trackHeight: 5.0,
  thumbShape:
  RoundSliderThumbShape(enabledThumbRadius: 12.0),
  thumbColor:Color(0xAA553772),
  overlayColor:Color(0xFF340c64),
  overlayShape:
  RoundSliderOverlayShape(overlayRadius: 15.0),
  tickMarkShape: RoundSliderTickMarkShape(),
  activeTickMarkColor: Color(0xFF340c64),
  inactiveTickMarkColor:Color(0xFF340c64),
  valueIndicatorShape: PaddleSliderValueIndicatorShape(),
  valueIndicatorColor: Color(0xAA553772),
  valueIndicatorTextStyle: TextStyle(
  color: Colors.white,
  ),
  ),
    child: Slider(
    value: position?.inMilliseconds?.toDouble() ?? 0.0,
    onChanged: (double value) {
    return audioPlayer.seek((value / 1000).roundToDouble());
    },
    min: 0.0,
    max: duration.inMilliseconds.toDouble()),
  )
  else if(duration == null)
  SliderTheme(
  data: SliderTheme.of(context).copyWith(
  activeTrackColor: Color(0xFF340c64),
  inactiveTrackColor: Color(0xFF340c64),
  trackShape: RoundedRectSliderTrackShape(),
  trackHeight: 5.0,
  thumbShape:
  RoundSliderThumbShape(enabledThumbRadius: 12.0),
  thumbColor:Color(0xAA553772),
  overlayColor:Color(0xFF340c64),
  overlayShape:
  RoundSliderOverlayShape(overlayRadius: 15.0),
  tickMarkShape: RoundSliderTickMarkShape(),
  activeTickMarkColor: Color(0xFF340c64),
  inactiveTickMarkColor:Color(0xFF340c64),
  valueIndicatorShape: PaddleSliderValueIndicatorShape(),
  valueIndicatorColor: Color(0xAA553772),
  valueIndicatorTextStyle: TextStyle(
  color: Colors.white,
  ),
  ),
    child: Slider(
    value: 0,
    onChanged: (double value) {

    },
    min: 0.0,
    max: 10.0,
    ),
  ),
  if (position != null) _buildMuteButtons()
  else if(position == null)
  FlatButton.icon(
  onPressed: () {

  },
  icon: Icon(
  Icons.headset_off,
  color: Colors.grey,
  ),
  label: Text('Mute', style: TextStyle(color: Colors.grey,)),
  )
  ,
  if (position != null) _buildProgressView()
  else if(position == null)
  Row(mainAxisSize: MainAxisSize.min, children: [
  Padding(
  padding: EdgeInsets.all(4.0),
  child: CircularProgressIndicator(
  value:  0.0,
  valueColor: AlwaysStoppedAnimation(Color(0xFF340c64)),
  backgroundColor: Colors.grey.shade400,
  ),
  ),
  Text(
  "0:00:00/0:00:00",
  style: TextStyle(fontSize: 24.0),
  )
  ]),

  Padding(
    padding: const EdgeInsets.only(top:4.0),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
    Container(
    margin: EdgeInsets.all(8),
    decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: Colors.white,
    boxShadow: [
    BoxShadow(
    color: Colors.black26,
    blurRadius: 7.0,
    spreadRadius: 2.0,
    offset: Offset(5.0, 5.0), // shadow direction: bottom right
    )
    ],
    ),
    child: IconButton(
    onPressed: isPlaying ? null : (){
    play();
    },
    iconSize: 50.0,
    icon: Icon(Icons.play_arrow),
    color: Color(0xFF340c64),
    ),
    ),
    Container(
    margin: EdgeInsets.all(8),
    decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: Colors.white,
    boxShadow: [
    BoxShadow(
    color: Colors.black26,
    blurRadius: 7.0,
    spreadRadius: 2.0,
    offset: Offset(5.0, 5.0), // shadow direction: bottom right
    )
    ],
    ),
    child: IconButton(
    onPressed: isPlaying ? () => pause() : null,
    iconSize: 50.0,
    icon: Icon(Icons.pause),
    color: Color(0xFF340c64),
    ),
    ),
    Container(
    margin: EdgeInsets.all(8),
    decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: Colors.white,
    boxShadow: [
    BoxShadow(
    color: Colors.black26,
    blurRadius: 7.0,
    spreadRadius: 2.0,
    offset: Offset(5.0, 5.0), // shadow direction: bottom right
    )
    ],
    ),
    child: IconButton(
    onPressed: isPlaying || isPaused ? () => stop() : null,
    iconSize: 50.0,
    icon: Icon(Icons.stop),
    color:Color(0xFF340c64),
    ),
    ),
    ]),
  ),
  ],
  ),
  );

  Row _buildProgressView() => Row(mainAxisSize: MainAxisSize.min, children: [
    Padding(
      padding: EdgeInsets.all(5.0),
      child: CircularProgressIndicator(
        value: position != null && position.inMilliseconds > 0
            ? (position?.inMilliseconds?.toDouble() ?? 0.0) /
            (duration?.inMilliseconds?.toDouble() ?? 0.0)
            : 0.0,
        valueColor: AlwaysStoppedAnimation(Color(0xFF340c64)),
        backgroundColor: Colors.grey.shade400,
      ),
    ),
    Text(
      position != null
          ? "${positionText ?? ''} / ${durationText ?? ''}"
          : duration != null ? durationText : '',
      style: TextStyle(fontSize: 24.0),
    )
  ]);

  Row _buildMuteButtons() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
        if (!isMuted)
    FlatButton.icon(
      onPressed: () => mute(true),
      icon: Icon(
        Icons.headset,
        color: Color(0xFF340c64),
      ),
      label: Text('Mute', style: TextStyle(color: Color(0xFF340c64))),
    ),
    if (isMuted)
    FlatButton.icon(
    onPressed: () => mute(false),
    icon: Icon(Icons.headset_off, color: Colors.cyan),
    label: Text('Unmute', style: TextStyle(color: Colors.cyan)),
    ),
    ],
    );
    }
}