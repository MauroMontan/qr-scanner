import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class ScanModel {
  int? id;
  String? tipo;
  String valor;
  String? title;

  ScanModel({
    this.id,
    this.tipo,
    this.title,
    required this.valor,
  }) {
    if (valor.contains("http")) {
      tipo = "http";
    } else if (valor.contains("geo")) {
      tipo = "geo";
    } else {
      tipo = "anything";
    }
  }

  String toJson() => jsonEncode(toMap());

  LatLng get getLatLng {
    final latLgn = valor.split(",");

    final lat = double.parse(latLgn[0]);
    final lng = double.parse(latLgn[1]);
    print("$lat , $lng");
    return LatLng(lat, lng);
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
        title: json["title"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
        "title": title,
      };
}
