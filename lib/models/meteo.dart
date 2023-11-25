// Esto te explica como usar la clase donde quieras leer los datos
// To parse this JSON data, do
//
//     final meteo = meteoFromJson(jsonString);
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

Meteo meteoFromJson(String str) => Meteo.fromJson(json.decode(str));

String meteoToJson(Meteo data) => json.encode(data.toJson());

class Meteo {
  String product;
  String init;
  List<DataSerie> dataseries;
  DateTime get initDateTime{
    //"init" : "2023112514" formato q necesitamos para obtener fecha, hora... así viene en el json
    // y hay que ponerlo así  "20231125T142500"  año, mes, dia T hora, minutos, segundos
    return DateTime.parse("${init.substring(0,8)}T${init.substring(8)}0000");
    // el susbstring extrae de 2023112514 del 0 al 8 primeros, añadimos T,
    // luego quitar 8 primeros (queda número 14) y añadimos 0000
  }

  Meteo({
    required this.product,
    required this.init,
    required this.dataseries,
  });

  factory Meteo.fromJson(Map<String, dynamic> json) => Meteo(
        product: json["product"],
        init: json["init"],
        dataseries: List<DataSerie>.from(
            json["dataseries"].map((x) => DataSerie.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product": product,
        "init": init,
        "dataseries": List<dynamic>.from(dataseries.map((x) => x.toJson())),
      };
}

class DataSerie {
  int timePoint;
  int cloudCover;
  int liftedIndex;
  PrecType precType;
  int precAmount;
  int temp2M;
  String rh2M;
  Wind10M wind10M;
  String weather;

  IconData get iconData {
    return switch(weather){
      "clearday" => WeatherIcons.day_sunny,
      "clearnight" => WeatherIcons.night_clear,
      "pcloudyday" => WeatherIcons.day_cloudy,
      "mcloudyday" => WeatherIcons.day_cloudy_high,
      "cloudynight" => WeatherIcons.night_cloudy,
      _ => WeatherIcons.day_sunny, //Default value
    };
  }

  DataSerie({
    required this.timePoint,
    required this.cloudCover,
    required this.liftedIndex,
    required this.precType,
    required this.precAmount,
    required this.temp2M,
    required this.rh2M,
    required this.wind10M,
    required this.weather,
  });

  factory DataSerie.fromJson(Map<String, dynamic> json) => DataSerie(
        timePoint: json["timepoint"],
        cloudCover: json["cloudcover"],
        liftedIndex: json["lifted_index"],
        precType: precTypeValues.map[json["prec_type"]]!,
        precAmount: json["prec_amount"],
        temp2M: json["temp2m"],
        rh2M: json["rh2m"],
        wind10M: Wind10M.fromJson(json["wind10m"]),
        weather: json["weather"],
      );

  Map<String, dynamic> toJson() => {
        "timepoint": timePoint,
        "cloudcover": cloudCover,
        "lifted_index": liftedIndex,
        "prec_type": precTypeValues.reverse[precType],
        "prec_amount": precAmount,
        "temp2m": temp2M,
        "rh2m": rh2M,
        "wind10m": wind10M.toJson(),
        "weather": weather,
      };
}

enum PrecType { NONE, RAIN }

final precTypeValues =
    EnumValues({"none": PrecType.NONE, "rain": PrecType.RAIN});

class Wind10M {
  String direction;
  int speed;

  Wind10M({
    required this.direction,
    required this.speed,
  });

  factory Wind10M.fromJson(Map<String, dynamic> json) => Wind10M(
        direction: json["direction"],
        speed: json["speed"],
      );

  Map<String, dynamic> toJson() => {
        "direction": direction,
        "speed": speed,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
