import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

enum ScanType {
  http('http'),
  geo('geo');

  final String value;
  const ScanType(this.value);
}


class ScanModel {
    int? id;
    ScanType? type;
    String value;

    ScanModel({
        this.id,
        this.type,
        required this.value,
    }){
      type = ScanType.geo;
      if (value.contains('http')) {
        type = ScanType.http;
      }

    }

    LatLng getLatLng() {
      final latLng = value.substring(4).split(',');
      final lat = double.parse(latLng[0]);
      final lng = double.parse(latLng[1]);
      return LatLng(lat, lng);
    }

    factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json['id'],
        type: ScanType.values.firstWhere((element) => element.value == json['type']),
        value: json['value'],
    );

    Map<String, dynamic> toJson() =>{
      'id': id,
      'type': type!.value,
      'value': value,
    };
    
}
