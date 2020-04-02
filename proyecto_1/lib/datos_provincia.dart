import 'package:charts_flutter/flutter.dart';
import 'package:random_color/random_color.dart';
import 'datos.dart';
import 'interface_datos.dart';

class DatosProvincia implements Datos
{
  List<Series<DataChart, String>> getDatos()
  {
    RandomColor _randomColor = RandomColor(14); //6, 10, 17, 25 opciones
    List<DataChart> datosProvincia = new List();
    List<Series<DataChart, String>> datosProvinciaSerie = new List();
    List colores = _randomColor.randomColors(
      count: Data.getInstance().provincias.length,
      colorBrightness: ColorBrightness.dark,
      colorSaturation: ColorSaturation.highSaturation
    );

    for(int i = 0; i < Data.getInstance().provincias.length; i++)
    {
      int total = 0;
      for(int j = 1; j < Data.getInstance().provincias[i].datos.length; j++)
      {
        total += Data.getInstance().provincias[i].datos[j][1];
      }
      datosProvincia.add(new DataChart(i, Data.getInstance().provincias[i].nombre, total));
    }

    datosProvinciaSerie.add(new Series(
      data: datosProvincia,
      id: "Provincias",
      domainFn: (DataChart data, _) => data.name,
      measureFn: (DataChart data, _) => data.value,
      colorFn: (datum, index) => new Color(
        r: colores[index].red,
        b: colores[index].blue,
        g: colores[index].green,
        a: colores[index].alpha
      ),
      displayName: "Provincias",
      labelAccessorFn: (datum, index) => datum.value.toString(),
    ));

    return datosProvinciaSerie;
  }
}