import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import 'package:charts_flutter/flutter.dart';
import 'datos.dart';

class GraficoEdad extends StatefulWidget
{
  final int provincia;
  final int discapacidad;

  GraficoEdad(this.provincia, this.discapacidad);

  @override
  State<StatefulWidget> createState() => GraficoEdadState(provincia, discapacidad);
}

class GraficoEdadState extends State<GraficoEdad>
{
  final int provincia;
  final int discapacidad;

  GraficoEdadState(this.provincia, this.discapacidad);

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edades"),
        centerTitle: true
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: _getGrafico(),
        ),
      ),
    );
  }

  Widget _getGrafico()
  {
    return new PieChart(
      getDatosEdad(),
      animate: false,
      defaultRenderer: new ArcRendererConfig(
        arcWidth: 80,
        arcRendererDecorators: [
          new ArcLabelDecorator(
            labelPosition: ArcLabelPosition.auto,
          )
        ]
      ),
      behaviors: [
        new ChartTitle(
          "Rangos de edades en ${Data.getInstance().provincias[provincia].nombre}",
          subTitle: "${Data.getInstance().provincias[provincia].datos[0][discapacidad]}",
          behaviorPosition: BehaviorPosition.top
        ),
        new DatumLegend(
          position: BehaviorPosition.bottom,
          horizontalFirst: false,
          cellPadding: new EdgeInsets.only(right: 5.0, bottom: 5.0),
        )
      ],
    );
  }
  
  List<Series<DataChart, String>> getDatosEdad()
  {
    RandomColor _randomColor = RandomColor(14); //6, 10, 17, 25 opciones
    List<DataChart> datosEdades = new List();
    List<Series<DataChart, String>> datosEdadesSerie = new List();
    List colores = _randomColor.randomColors(
      count: Data.getInstance().provincias[provincia].datos.length, //numero de Edades
      colorBrightness: ColorBrightness.dark,
      colorSaturation: ColorSaturation.highSaturation
    );

    int k = 1;
    while(k < Data.getInstance().provincias[provincia].datos.length - 1)
    {
      int total = 0;
      for(int j = 1; j < Data.getInstance().provincias[provincia].datos[k].length; j++)
      {
        total += Data.getInstance().provincias[provincia].datos[k][j];
      }
      datosEdades.add(new DataChart(k, Data.getInstance().provincias[provincia].datos[k][0], total));
      k++;
    }

    datosEdadesSerie.add(new Series(
      data: datosEdades,
      id: "Edades",
      domainFn: (DataChart data, _) => data.name,
      measureFn: (DataChart data, _) => data.value,
      colorFn: (datum, index) => new Color(
        r: colores[index].red,
        b: colores[index].blue,
        g: colores[index].green,
        a: colores[index].alpha
      ),
      displayName: "Edades",
      labelAccessorFn: (datum, index) => datum.value.toString(),
    ));

    return datosEdadesSerie;
  }
}