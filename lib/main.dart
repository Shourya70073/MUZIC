// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'card.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final player = AudioPlayer();
  var flag = true;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setplayer();

    player.onDurationChanged.listen((Duration d) {
      setState(() {
        duration = d;
      });
    });

    player.onPositionChanged.listen((newp) {
      setState(() {
        position = newp;
      });
    });
  }

  void setplayer() async {
    await player.setSource(AssetSource('rockstar.mp3'));
    await player.setVolume(1.0);
    await player.setPlaybackRate(1.0);
  }

  void play() async {
    if (flag == false) {
      pause();
      return;
    }
    setState(() {
      flag = false;
    });

    await player.resume();
  }

  void pause() async {
    setState(() {
      flag = true;
    });
    await player.pause();
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(': ');
  }

  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Muzic Player UI",
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Cardd(
                      height: 60.0,
                      width: 60.0,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      padd: 12.0,
                    ),
                    Text("M U Z I C "),
                    Cardd(
                      height: 60.0,
                      width: 60.0,
                      child: Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                      padd: 12.0,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Cardd(
                  height: 390.0,
                  width: double.infinity,
                  padd: 13.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: AssetImage("assets/OIP.jpg"),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Post Malone",
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Rockstar",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          Text(
                            "❤️",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(formatTime(position)),
                    Icon(Icons.shuffle),
                    Icon(Icons.repeat),
                    Text(formatTime(duration - position))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Cardd(
                    height: 30.0,
                    width: double.infinity,
                    padd: 8.0,
                    child: Slider(
                      activeColor: Colors.green,
                      inactiveColor: Colors.lightGreen,
                      min: 0,
                      max: duration.inSeconds.toDouble(),
                      value: position.inSeconds.toDouble(),
                      onChanged: (value) async {
                        final position = Duration(seconds: value.toInt());
                        await player.seek(position);
                        setState(() {
                          flag = false;
                        });
                        await player.resume();
                      },
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23.0),
                child: Center(
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Cardd(
                        height: 80.0,
                        width: 80.0,
                        child: Icon(
                          Icons.skip_previous,
                          size: 40,
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      GestureDetector(
                        onTap: play,
                        child: Cardd(
                          height: 80.0,
                          width: 130.0,
                          child: flag
                              ? Icon(
                                  Icons.play_arrow,
                                  size: 40,
                                )
                              : Icon(Icons.pause, size: 40),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Cardd(
                        height: 80.0,
                        width: 80.0,
                        child: Icon(
                          Icons.skip_next,
                          size: 40,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
