// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RainModel {
  final String id;
  final String ondate;
  final String soil;
  final String temp;
  final String moisture;
  final String v_battery;
  final String r15m;
  final String r12h;
  final String r24h;
  final String pm25;
  final String pm10;
  final String reg_date;
  RainModel({
    required this.id,
    required this.ondate,
    required this.soil,
    required this.temp,
    required this.moisture,
    required this.v_battery,
    required this.r15m,
    required this.r12h,
    required this.r24h,
    required this.pm25,
    required this.pm10,
    required this.reg_date,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'ondate': ondate,
      'soil': soil,
      'temp': temp,
      'moisture': moisture,
      'v_battery': v_battery,
      'r15m': r15m,
      'r12h': r12h,
      'r24h': r24h,
      'pm25': pm25,
      'pm10': pm10,
      'reg_date': reg_date,
    };
  }

  factory RainModel.fromMap(Map<String, dynamic> map) {
    return RainModel(
      id: (map['id'] ?? '') as String,
      ondate: (map['ondate'] ?? '') as String,
      soil: (map['soil'] ?? '') as String,
      temp: (map['temp'] ?? '') as String,
      moisture: (map['moisture'] ?? '') as String,
      v_battery: (map['v_battery'] ?? '') as String,
      r15m: (map['r15m'] ?? '') as String,
      r12h: (map['r12h'] ?? '') as String,
      r24h: (map['r24h'] ?? '') as String,
      pm25: (map['pm25'] ?? '') as String,
      pm10: (map['pm10'] ?? '') as String,
      reg_date: (map['reg_date'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RainModel.fromJson(String source) => RainModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
