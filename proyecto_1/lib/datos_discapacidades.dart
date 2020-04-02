import 'package:charts_flutter/flutter.dart';
import 'package:random_color/random_color.dart';
import 'datos.dart';
import 'interface_datos.dart';

class DatosDiscapacidad implements Datos
{
  int provincia;

  DatosDiscapacidad(this.provincia);

  List<Series<DataChart, String>> getDatos()
  {
    RandomColor _randomColor = RandomColor(14); //6, 10, 17, 25 opciones
    List<DataChart> datosDiscapacidades = new List();
    List<Series<DataChart, String>> datosDiscapacidadesSerie = new List();
    List colores = _randomColor.randomColors(
      count: Data.getInstance().provincias[provincia].datos[0].length, //numero de discapacidades
      colorBrightness: ColorBrightness.dark,
      colorSaturation: ColorSaturation.highSaturation
    );

    int k = 2;
    while(k < Data.getInstance().provincias[provincia].datos[0].length - 1)
    {
      int total = 0;
      for(int j = 1; j < Data.getInstance().provincias[provincia].datos.length; j++)
      {
        total += Data.getInstance().provincias[provincia].datos[j][k];
      }
      datosDiscapacidades.add(new DataChart(k, Data.getInstance().provincias[provincia].datos[0][k], total));
      k++;
    }

    datosDiscapacidadesSerie.add(new Series(
      data: datosDiscapacidades,
      id: "Discapacidades",
      domainFn: (DataChart data, _) => data.name,
      measureFn: (DataChart data, _) => data.value,
      colorFn: (datum, index) => new Color(
        r: colores[index].red,
        b: colores[index].blue,
        g: colores[index].green,
        a: colores[index].alpha
      ),
      displayName: "Discapacidades",
      labelAccessorFn: (datum, index) => "${datum.name}: ${datum.value.toString()}",
    ));

    return datosDiscapacidadesSerie;
  }
}