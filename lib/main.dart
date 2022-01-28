import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:workmanager/workmanager.dart';
import 'pages/def.dart';
import './api/sapi.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  //  (Geolocator()..forceAndroidLocationManager = true);
  // final hasPermission = await sapi.handlePermission();
  // await Workmanager().initialize(
  //     callbackDispatcher, // The top level function, aka callbackDispatcher
  //     isInDebugMode:
  //         true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  //     );
  // await Geolocator.requestPermission();
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager().initialize(callbackDispatcher);
  await Workmanager().registerPeriodicTask(
    "1",
    fetchBackground,
    inputData: {"as": "asdd", "qwe": "rd"},
    frequency: const Duration(minutes: 15),
    initialDelay: const Duration(minutes: 1),
  );
  try {
    sapi.perma();
  } catch (err) {}
  int flag = 0;
  while (true) {
    var status = await Permission.location.status;
    if (status.isDenied) {
      flag = 0;
    } else {
      flag = 1;

      break;
    }
  }
  if (flag == 1) {
    runApp(const salah());
  }
}

class salah extends StatelessWidget {
  const salah({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // sapi.perma();
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: def(),
    );
  }
}
