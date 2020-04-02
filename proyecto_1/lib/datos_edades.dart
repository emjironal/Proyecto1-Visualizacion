import 'package:charts_flutter/flutter.dart';
import 'package:random_color/random_color.dart';
import 'datos.dart';
import 'interface_datos.dart';

class DatosEdades implements Datos
{
  int provincia, discapacidad;

  DatosEdades(this.provincia, this.discapacidad);

  List<Series<DataChart, String>> getDatos()
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
      datosEdades.add(new DataChart(k, Data.getInstance().provincias[provincia].datos[k][0], Data.getInstance().provincias[provincia].datos[k][discapacidad]));
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