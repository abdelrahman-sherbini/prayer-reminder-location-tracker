import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
// import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';

import '../met.dart';

enum PermissionGroup {
  /// Android: Fine and Coarse Location
  /// iOS: CoreLocation - Always
  locationAlways,

  /// Android: Fine and Coarse Location
  /// iOS: CoreLocation - WhenInUse
  locationWhenInUse
}

class sapi {
  static const String _kLocationServicesDisabledMessage =
      'Location services are disabled.';
  static const String _kPermissionDeniedMessage = 'Permission denied.';
  static const String _kPermissionDeniedForeverMessage =
      'Permission denied forever.';
  static const String _kPermissionGrantedMessage = 'Permission granted.';

  // final List<_PositionItem> _positionItems = <_PositionItem>[];
  // StreamSubscription<Position>? _positionStreamSubscription;
  // StreamSubscription<ServiceStatus>? _serviceStatusStreamSubscription;
  bool positionStreamStarted = false;
  // static const String _kPermissionDeniedMessage = 'Permission denied.';
  static void perma() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      // Permission.storage,
    ].request();
    print(statuses[Permission.location]);
  }
// final ph = PermissionHandler();
// final requested = await ph.requestPermissions([
  // PermissionGroup.locationAlways,
  // PermissionGroup.locationWhenInUse
// ]);

// final alwaysGranted = requested[PermissionGroup.locationAlways] == loc.PermissionStatus.granted;
// final whenInUseGranted = requested[PermissionGroup.locationWhenInUse] == loc.PermissionStatus.granted;}
  // static Position? locm;
  // // void getCurrentLocation() async
  // static Future getLocation() async {
  //   // await Geolocator.requestPermission();
  //   //Do it dynamic !!
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.best);

  //   locm = position;
  //   // var lastpos = await Geolocator.getLastKnownPosition();
  //   // final coordinates = new Coordinates(position.latitude, position.longitude);
  //   // var addresses =
  //   //     await placemarkFromCoordinates(position.latitude, position.longitude);
  //   // print(addresses[0].toJson());

  //   // print(position);
  //   // print('maybe');
  //   // print(lastpos);
  //   return position;
  // }

  // late Position position;
  static Future getUsers(BuildContext context, Position? position) async {
    // final hasPermission = await _handlePermission();
    // await Geolocator.requestPermission();
    if (position == null) {
      Position positionn = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      position = positionn;
    }
    // Position position = await Geolocator.getCurrentPosition(
    // desiredAccuracy: LocationAccuracy.best);
    // var lastpos = await Geolocator.getLastKnownPosition();
    // final coordinates = new Coordinates(position.latitude, position.longitude);

    var la = await position.latitude;
    var lo = await position.longitude;
    // print(la);
    // print(lo);
    var addresses = await placemarkFromCoordinates(la, lo);
    var country = addresses[0].toJson()['country'];
    var addr = addresses[0].toJson()['locality'];
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    int mon = dateParse.month;
    var yea = dateParse.year;
    print(position);
    print('maybe');
    // print(lastpos);
    final Map<String, dynamic> param = {
      'city': addr,
      'country': country,
      'method': "5",
      'month': mon.toString(),
      'year': yea.toString()
    };
    var respone = await http.get(Uri.https(
      "api.aladhan.com",
      "v1/calendarByCity",
      param,
    )); //?city=Mansoura&country=Egypt&method=1&month=01&year=2022"));
    // var respone2 = "[" + respone.body + "]";
    var respone2 = respone.body;
    var jsondata = json.decode(respone2);
    // print(jsondata['data'][25]);
    List<Data> ayam = [];
    for (var b in jsondata['data']) {
      Data dat = Data(
          fajr: b['timings']["Fajr"],
          bfajr: b['timings']["Sunrise"],
          dohr: b['timings']["Dhuhr"],
          asr: b['timings']["Asr"],
          maghrib: b['timings']["Maghrib"],
          eisha: b['timings']["Isha"]);
      ayam.add(dat);
    }
    // ignore: avoid_print
    print(ayam[dateParse.day].eisha);
    return ayam;
  }
}
