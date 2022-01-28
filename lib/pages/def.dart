// ignore_for_file: prefer_const_constructors
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading_animations/loading_animations.dart';
import '../met.dart';
import '../api/sapi.dart';
// import 'dart:math';
// import 'dart:convert';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:intl/date_symbol_data_local.dart';

import './Notification.dart' as notif;

Position? locm;
const fetchBackground = "fetchBackground";
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("Native called background task: ");
    switch (task) {
      case fetchBackground:
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        locm = position;
        var la = position.latitude;
        var lo = position.longitude;
        // print(la);
        // print(lo);
        var addresses = await placemarkFromCoordinates(la, lo);
        var country = addresses[0].toJson()['country'];
        var addr = addresses[0].toJson()['locality'];
        notif.Notification notification = notif.Notification();
        notification.showNotificationWithoutSound(
            title: "Location fetched!", body: country + " " + addr);

        break;
    }
    return Future.value(true);
  });
}

class def extends StatefulWidget {
  const def({Key? key}) : super(key: key);

  @override
  _defState createState() => _defState();
}

class _defState extends State<def> {
  // const def({Key? key}) : super(key: key);
  // void getCurrentLocation() async
  // late Position locm;

  void getLocation() async {
    // await Geolocator().checkGeolocationPermissionStatus();
    // await Geolocator.requestPermission();
    //Do it dynamic !!

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    setState(() {
      locm = position;
    });
  }

  //   // var lastpos = await Geolocator.getLastKnownPosition();
  //   // final coordinates = new Coordinates(position.latitude, position.longitude);
  //   // var addresses =
  //   // await placemarkFromCoordinates(position.latitude, position.longitude);
  //   // print(addresses[0].toJson());

  //   // print(position);
  //   // print('maybe');
  //   // print(lastpos);
  // }
  void asdd() async {
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );
  }

  void fa(var a) {
    DateTime startDatee = DateFormat('kk:mm').parse(a);

    // print(startDate.toString());
    // print(myl[dateParse.day].fajr.toString());
    startDatee = startDatee.add(Duration(hours: 1));
    if (myController.text.isEmpty) {
      myController.text = "0";
    }
    if (myController1.text.isEmpty) {
      myController1.text = "0";
    }
    startDatee =
        startDatee.subtract(Duration(hours: int.parse(myController.text)));
    startDatee =
        startDatee.subtract(Duration(minutes: int.parse(myController1.text)));
    String tpm = startDatee.toString().split(" ")[1];
    // print(tpm.split(" ")[1]);
    String hour = tpm.substring(0, 5).split(':')[0];
    String min = tpm.substring(0, 5).split(':')[1];
    FlutterAlarmClock.createAlarm(int.parse(hour), int.parse(min));
  }

  final myController = TextEditingController(text: "0");
  final myController1 = TextEditingController(text: "0");
  int as = 0;
  @override
  void initState() {
    // notif.Notification.showNotificationWithoutSound(
    // title: "meh", body: "as", payload: "sarah");
    // TODO: implement initState
    setState(() {
      as = d;
    });
    super.initState();
    this.getLocation();
    asdd();
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );
    // Workmanager().registerPeriodicTask(
    //   "1",
    //   fetchBackground,
    //   frequency: Duration(seconds: 10),
    // );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    myController1.dispose();
    super.dispose();
  }

  static int d = 0;
  Color getC(int a) {
    if (a == d) {
      return Colors.deepOrangeAccent;
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );
    // sapi.perma();
    var date = DateTime.now().toString();
    var dateParse = DateTime.parse(date);

    // Workmanager().initialize(
    //   callbackDispatcher,
    //   isInDebugMode: true,
    // );
// var mjk = blaa(Dateti)
    List<String> ad = ['as', 'as', 'asd', 's', 'a', 'a'];
    String kak = '';
    String blaa(DateTime now, List<String> lise) {
      // var now = new DateTime.now();
      for (int as = 0; as < 6; as++) {
        var formattedDate = DateFormat('kk:mm').format(now);
        DateTime startDate = DateFormat('kk:mm').parse(formattedDate);
        DateTime endDate = DateFormat('kk:mm').parse(lise[as]);
        Duration dif = endDate.difference(startDate);
        ad[as] = "${dif.inHours} : ${dif.inMinutes.remainder(60)}";
        // if (as == 0) {
        //   ad[as] = "${24 + dif.inHours} : ${60 + dif.inMinutes.remainder(60)}";
        // }
      }
      List<int> ints = [1, 1, 1, 1, 1, 1];
      List<int> intss = [1, 1, 1, 1, 1, 1];
      String qe = "d";
      String qee = "d";
      int flag = 0;
      for (int as = 0; as < 6; as++) {
        qe = ad[as].split(':')[0];
        qee = ad[as].split(':')[1];
        ints[as] = int.parse(qe);
        intss[as] = int.parse(qee);
        if (ints[as] >= 0 && intss[as] >= 0) {
          flag = 1;
          d = as;
          break;
        }
        if (flag == 0) {
          var formattedDate = DateFormat('kk:mm').format(now);
          DateTime startDate = DateFormat('kk:mm').parse(formattedDate);
          DateTime endDate = DateFormat('kk:mm').parse(lise[0]);
          Duration dif = endDate.difference(startDate);

          ad[0] = "${24 + dif.inHours} : ${60 + dif.inMinutes.remainder(60)}";
        }
      }
      return ad[d];
    }

    // bla();
    // Future ayam = sapi.getUsers(context);
    // print(ayam.runtimeType);

    // Duration dif = endDate.difference(startDate);
    // print(dif.toString());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  (Colors.indigo[500])!,
                  (Colors.yellow[200])!,
                ],
              ),
            ),
            // child: Align(
            child: Container(
              color: Colors.transparent,
              child:
                  // sapi.perma();
                  FutureBuilder(
                future: sapi.getUsers(context, locm),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var myl = (snapshot.data)! as List<Data>;
                    List<String> lista = [
                      myl[dateParse.day].fajr.substring(0, 5).toString(),
                      myl[dateParse.day].bfajr.substring(0, 5).toString(),
                      myl[dateParse.day].dohr.substring(0, 5).toString(),
                      myl[dateParse.day].asr.substring(0, 5).toString(),
                      myl[dateParse.day].maghrib.substring(0, 5).toString(),
                      myl[dateParse.day].eisha.substring(0, 5).toString()
                    ];
                    blaa(DateTime.now(), lista);
                    // print(DateFormat('hh:mm').parse(DateTime.now().toString()));
                    // var formattedDate =
                    // DateFormat('kk:mm').format(DateTime.now());
                    // DateTime startDate =
                    // DateFormat('kk:mm').parse(formattedDate);
                    // print(DateFormat('kk:mm')
                    //     .parse(lista[1])
                    //     .difference(startDate));
                    return
                        //  ClipRRect(
// width: MediaQuery.of(context).size.width,
                        // height: 280,
                        Wrap(
                      runAlignment: WrapAlignment.center,
                      spacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.end,
                      runSpacing: 10,
                      // mainAxisSize: MainAxisSize.min,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Container(
                        // child: Row(
                        // children: [
                        Container(
                          child: TextFormField(
                            // initialValue: "0",
                            decoration: new InputDecoration(labelText: "Hours"),
                            controller: myController,
                            style: TextStyle(
                                color: Colors.amber[200],
                                fontSize: 48,
                                fontWeight: FontWeight.bold),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Container(
                          child: TextFormField(
                            // initialValue: "0",
                            decoration:
                                new InputDecoration(labelText: "Minutes"),
                            controller: myController1,
                            style: TextStyle(
                                color: Colors.amber[200],
                                fontSize: 48,
                                fontWeight: FontWeight.bold),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        // ],
                        // ),
                        // ),
                        Container(
                          color: Colors.blueGrey[300],
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          getC(0))),
                              onPressed: () {
                                // setState(() {
                                // initializeDateFormatting('fr_FR', null)
                                // .then((_) {
                                fa(myl[dateParse.day].fajr);
                                // });
                                // FlutterAlarmClock.showAlarms();
                                // });
                              },
                              child: Text(
                                "الفجر",
                                style: TextStyle(
                                    color: Colors.amber[200],
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                        Container(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          getC(1))),
                              onPressed: () {
                                // Provider.of(context, listen: false);
                                fa(myl[dateParse.day].bfajr);
                              },
                              child: Text("الشروق",
                                  style: TextStyle(
                                      color: Colors.amber[200],
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold))),
                        ),
                        Container(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          getC(2))),
                              onPressed: () {
                                fa(myl[dateParse.day].dohr);
                              },
                              child: Text("الظهر",
                                  style: TextStyle(
                                      color: Colors.amber[200],
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold))),
                        ),
                        Container(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          getC(3))),
                              onPressed: () {
                                fa(myl[dateParse.day].asr);
                              },
                              child: Text("العصر",
                                  style: TextStyle(
                                      color: Colors.amber[200],
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold))),
                        ),
                        Container(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          getC(4))),
                              onPressed: () {
                                fa(myl[dateParse.day].maghrib);
                              },
                              child: Text("المغرب",
                                  style: TextStyle(
                                      color: Colors.amber[200],
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold))),
                        ),
                        Container(
                          // height: ,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          getC(5))),
                              onPressed: () {
                                fa(myl[dateParse.day].eisha);
                              },
                              child: Text("العشاء",
                                  style: TextStyle(
                                      color: Colors.amber[200],
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 120),
                          child: Container(
                              child: StreamBuilder(
                                  stream: Stream.periodic(
                                      const Duration(seconds: 1)),
                                  builder: (context, snapshot) {
                                    return Text(
                                        blaa(DateTime.now(), lista)
                                        // myl[dateParse.day]
                                        //     .eisha
                                        //     .substring(0, 5)
                                        //     .split(':')
                                        //     .toString(),
                                        ,
                                        style: TextStyle(
                                            color: Colors.brown[500],
                                            fontSize: 48,
                                            fontWeight: FontWeight.bold));
                                  })
                              //  ElevatedButton(
                              //     onPressed: () {},
                              //     child: Text(
                              //         current
                              //         // myl[dateParse.day]
                              //         //     .eisha
                              //         //     .substring(0, 5)
                              //         //     .split(':')
                              //         //     .toString(),
                              //         ,
                              //         style: TextStyle(
                              //             color: Colors.amber[200],
                              //             fontSize: 48,
                              //             fontWeight: FontWeight.bold))
                              //             ),
                              ),
                        ),
                      ],
                    );
                    // ListView.builder(
                    //     itemCount: myl.length,
                    //     itemBuilder: (context, i) {
                    //       // if(snapshot.data != null)
                    //       return ListTile(
                    //         title: Text(myl[i].fajr),
                    //       );
                    //     });
                  } else {
                    return
                        // return DecoratedBox(
                        // decoration: BoxDecoration(color: Colors.transparent),
                        // Container(
                        // decoration: InputDecoration(fillColor: Colors.black,filled: true),
                        Center(
                            child: LoadingJumpingLine.circle(
                      borderColor: Colors.black38,
                      borderSize: 3.0,
                      size: 100.0,
                      backgroundColor: Colors.black38,
                      duration: Duration(milliseconds: 500),
                    ));
                  }
                },

                // sapi.getLocation();
              ),
            )
            // FutureBuilder<List<Data>>(
            //   future: sapi.getUsersLocally(context),
            //   builder: (context, _) {
            //     final bla = _.data;
            //     switch (_.connectionState) {
            //       case ConnectionState.waiting:
            //         return Center(
            //           child: CircularProgressIndicator(),
            //         );
            //       //break;
            //       default:
            //         if (_.hasError) {
            //           return Center(
            //             child: Text("Error"),
            //           );
            //         }
            //         return buildUsers(bla);
            //     }
            //   },
            // )
            ));
  }

  // Widget buildUsers(List<Data> data) {}
}
