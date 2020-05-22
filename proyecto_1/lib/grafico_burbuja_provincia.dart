import 'package:charts_flutter/flutter.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:proyecto1/enum_tipo_data.dart';
import 'package:proyecto1/interface_grafico.dart';
import 'package:random_color/random_color.dart';
import 'datos.dart';

class GraficoBurbuja extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    return GraficoBurbujaState();
  }
}

class GraficoBurbujaState extends State<GraficoBurbuja> implements Grafico
{
  Widget _widget;
  String tipo = "San José";
  String titulo;
  Dato datos;

  @override
  Widget build(BuildContext context)
  {
    datos = Data.getInstance().provincias[0];
    List<String> tipos = ["San José", "Alajuela", "Cartago", "Heredia", "Guanacaste", "Puntarenas", "Limón", "Hombres", "Mujeres"];

    return Scaffold(
      appBar: AppBar(
        title: Text("Burbujas"),
        centerTitle: true
      ),
      body: Container(
        color: Colors.white,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
            [
              /*DropDownField(
                value: tipo,
                labelText: "Datos del gráfico",
                items: tipos,
                setter: (newValue)
                {
                  datos = Data.getInstance().getDatos(tipo);
                  tipo = newValue;
                  setState(()
                  {
                    titulo = newValue;
                    _widget = getGrafico();
                  });
                },
              ),*/
              Center(
                child: _widget,
              ),
            ]
        )
      ),
    );
  }

  @override
  Widget getGrafico()
  {
    return ScatterPlotChart(
      datosProcesados(),
      animate: false,
      behaviors: [
        new ChartTitle(
          titulo,
          behaviorPosition: BehaviorPosition.top
        ),
      ],
    );
  }

  List<Series<DataChart, String>> datosProcesados()
  {
    RandomColor _randomColor = RandomColor(14); //6, 10, 17, 25 opciones
    List<DataChart> datosEdades = new List();
    List<Series<DataChart, String>> datosEdadesSerie = new List();
    List colores = _randomColor.randomColors(
      count: datos.datos.length, //numero de Edades
      colorBrightness: ColorBrightness.dark,
      colorSaturation: ColorSaturation.highSaturation
    );

    int total = 0;
    for(int i = 1; i < datos.datos.length; i++)
    {
      total += datos.datos[i];
    }

    for(int i = 1; i < datos.datos.length; i++)
    {
      datosEdades.add(new DataChart(datos.datos[i][1] * 100 / total, datos.datos[i][0], datos.datos[i][1]));
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
      radiusPxFn: (DataChart data, _) => data.id,
    ));
  }

  void isLoading() async
  {
    Data data = Data.getInstance();
    if(data.provincias.isEmpty)
    {
      _widget = Loading(indicator: BallPulseIndicator(), size: 100.0,color: Colors.indigo);
      await data.loadData();
      setState(()
      {
        _widget = getGrafico();
      });
    }
    else
    {
      _widget = getGrafico();
    }
  }
}