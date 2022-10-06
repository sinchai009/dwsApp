// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class StationAllModel {
  final String id;
  final String station_id;
  final String title;
  final String tumbon;
  final String amphoe;
  final String province;
  final String postcode;
  final String project;
  final String lat;
  final String lng;
  final String image;
  final String type;
  final String status;
  StationAllModel({
    required this.id,
    required this.station_id,
    required this.title,
    required this.tumbon,
    required this.amphoe,
    required this.province,
    required this.postcode,
    required this.project,
    required this.lat,
    required this.lng,
    required this.image,
    required this.type,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'station_id': station_id,
      'title': title,
      'tumbon': tumbon,
      'amphoe': amphoe,
      'province': province,
      'postcode': postcode,
      'project': project,
      'lat': lat,
      'lng': lng,
      'image': image,
      'type': type,
      'status': status,
    };
  }

  factory StationAllModel.fromMap(Map<String, dynamic> map) {
    return StationAllModel(
      id: (map['id'] ?? '') as String,
      station_id: (map['station_id'] ?? '') as String,
      title: (map['title'] ?? '') as String,
      tumbon: (map['tumbon'] ?? '') as String,
      amphoe: (map['amphoe'] ?? '') as String,
      province: (map['province'] ?? '') as String,
      postcode: (map['postcode'] ?? '') as String,
      project: (map['project'] ?? '') as String,
      lat: (map['lat'] ?? '') as String,
      lng: (map['lng'] ?? '') as String,
      image: (map['image'] ?? '') as String,
      type: (map['type'] ?? '') as String,
      status: (map['status'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StationAllModel.fromJson(String source) => StationAllModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
