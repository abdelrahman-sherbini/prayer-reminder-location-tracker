import 'package:meta/meta.dart';

class Data {
  final String fajr;
  final String bfajr;
  final String dohr;
  final String asr;
  final String maghrib;
  final String eisha;

  const Data({
    @required this.fajr = "s",
    @required this.bfajr = "s",
    @required this.dohr = "s",
    @required this.asr = "s",
    @required this.maghrib = "s",
    @required this.eisha = "s",
  });
  // static Data fromJson(json) => Data(
  //     fajr: json['data'][1]['Fajr'],
  //     dohr: json['data'][1]['Dhuhr'],
  //     asr: json['data'][1]['Asr'],
  //     maghrib: json['data'][1]['Maghrib'],
  //     eisha: json['data'][1]['Isha']);
}
