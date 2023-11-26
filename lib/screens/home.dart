import 'package:flutter/material.dart';
import 'package:whether_app/services/weather_service.dart';

import '../models/meteo.dart';
import '../widgets/forecast_widget.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Future<Meteo> meteoFuture = WeatherService().fetchData();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Weather App"),
        ),
        body: FutureBuilder(
            future: meteoFuture,
            builder: (context, snaphot) {
              if (snaphot.hasData) {
                var meteo = snaphot.data!; // con la ! nos aseguramos q no sea null
                //return const Center(child: Text("Data Loaded Successfully"));
                return ListView(
                  children: meteo.dataseries
                    .map((e) => ForecastWidget(dataSerie: e, reference: meteo.initDateTime,))
                    .toList(),
                 );
              } else if (snaphot.hasError) {
                return Center(child: Text("Error getting fucking data: $Error"));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            })
        // para mostrar los datos a partir de clicar un botón
        /*const Text('Wheather'),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var meteo = await WeatherService().fetchData();
          debugPrint(meteo.init);
        },
        child: const Icon(Icons.refresh),
      ),*/

        );
  }
}
