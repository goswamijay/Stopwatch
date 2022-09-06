import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int seconds = 0, minutes = 0, hours = 0;
  String digitSeconds = "00", digitMinutes = "00", digitHours = "00";
  Timer? timer;
  bool started = false;
  List laps = [];

  //Stop times
  void stops() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  //reset
  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;

      digitSeconds = "00";
      digitMinutes = "00";
      digitHours = "00";

      started = false;
      for(int i = 0; i<=laps.length;i++) {
        laps.remove(laps[i]);
      }
    });
  }

  void addLaps() {
    String lap = "$digitHours:$digitMinutes:$digitSeconds";
    setState(() {
      laps.add(lap);
    });
  }

  void Start() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;

      if (localSeconds > 59) {
        if (localMinutes > 59) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSeconds = 0;
        }
      }
      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;
        digitSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitHours = (hours >= 10) ? "$hours" : "0$hours";
        digitMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C2757),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                "StopWatch App",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,fontFamily: "MavenPro"),
              )),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "$digitHours:$digitMinutes:$digitSeconds",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 80.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Hubballi",
                  ),
                ),
              ),
              Container(
                height: 400.0,
                decoration: BoxDecoration(
                    color: Color(0xFF323F68),
                    borderRadius: BorderRadius.circular(8.0)),
                child: ListView.builder(
                    itemCount: laps.length,
                    itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Lap n°${index + 1}",style: TextStyle(color: Colors.white,fontSize: 16.0),),
                          Text("${laps[index]}",style: TextStyle(color: Colors.white,fontSize: 16.0),)
                        ],
                      ),
                        )),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: RawMaterialButton(
                    onPressed: () {
                      (!started)? Start() :stops();
                      },
                    shape: const StadiumBorder(
                      side: BorderSide(color: Colors.blue),
                    ),
                    child: Text(
                      (!started)? "Start":"Stop",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
                  SizedBox(
                    width: 8,
                  ),
                  IconButton(
                      onPressed: () {
                        addLaps();
                      },
                      icon: Icon(
                        Icons.flag,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: RawMaterialButton(
                    onPressed: () {
                      reset();
                    },
                    fillColor: Colors.blue,
                    shape: const StadiumBorder(
                      side: BorderSide(color: Colors.blue),
                    ),
                    child: Text(
                      "Reset",
                      style: TextStyle(color: Colors.white),
                    ),
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
