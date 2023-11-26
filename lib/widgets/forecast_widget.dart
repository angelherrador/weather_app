import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whether_app/models/meteo.dart';

class ForecastWidget extends StatelessWidget {
  const ForecastWidget({super.key, required this.dataSerie, required this.reference});

  final DataSerie dataSerie;
  final DateTime reference;

  @override
  Widget build(BuildContext context) {
    var instantDate = reference.add(Duration(hours: dataSerie.timePoint));
    var screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: screenWidth*0.5,
          child: Text(//reference.toString(),
            //dataSerie.timePoint.toString(),
            "Día ${DateFormat("dd\nHH:mm").format(instantDate)}",
            style: const TextStyle(
              fontSize: 24,
              color: Colors.black45,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
            width: screenWidth*0.2,
            child: Icon(dataSerie.iconData, size: 32,)),
        SizedBox(
          width: screenWidth*0.3,
          child: Text(
            "${dataSerie.temp2M.toString()} Cº",
            style: const TextStyle(
              fontSize: 36,
              color: Colors.black45,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const Divider(
            color: Colors.black
        )
      ],
    );
  }
}
