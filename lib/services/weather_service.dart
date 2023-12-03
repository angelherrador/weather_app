import 'package:http/http.dart' as http;

import '../models/meteo.dart';

class WeatherService {
  static const double latitude = 41.123401;//38.0976033; // //41.358889;
  static const double longitude = 1.2409893;//-3.6517936; // //2.099167;

  Future<Meteo> fetchData() async {
    //esta url que nos da la predicción del tiempo está en https://7timer.info
    //clicando en Wiki está tot explicado y la url a capturar, modificando astro por civil uy xml por json

    var response = await http.get(Uri.parse(
        'https://www.7timer.info/bin/api.pl?lon=$longitude&lat=$latitude&product=civil&output=json'));
    //debugPrint(response.body); //para ver en consola los datos
    final meteo = meteoFromJson(response.body);
    return meteo;
  }
}
