import 'package:flutter/material.dart';
import 'package:proyecto1/interface_grafico.dart';
import 'package:random_color/random_color.dart';
import 'package:charts_flutter/flutter.dart';
import 'datos.dart';
import 'grafico_edades_discapacidades.dart';

class GraficoDiscapacidad extends StatefulWidget
{
  final int provincia;

  GraficoDiscapacidad(this.provincia);

  @override
  State<StatefulWidget> createState() => GraficoDiscapacidadState(provincia);
}

class GraficoDiscapacidadState extends State<GraficoDiscapacidad> implements Grafico
{
  final int provincia;

  GraficoDiscapacidadState(this.provincia);

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discapacidades"),
        centerTitle: true
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: getGrafico(),
        ),
      ),
    );
  }

  @override
  Widget getGrafico()
  {
    return new PieChart(
      getDatos(),
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
          "Tipos de discapacidades en ${Data.getInstance().provincias[provincia].nombre}",
          subTitle: "Presione alguna sección\n para más información",
          behaviorPosition: BehaviorPosition.top
        ),
        new DatumLegend(
          position: BehaviorPosition.bottom,
          horizontalFirst: false,
          cellPadding: new EdgeInsets.only(right: 5.0, bottom: 5.0),
        )
      ],
      selectionModels: [
        new SelectionModelConfig(
          changedListener: (model)
          {
            if(model.selectedDatum.length > 0)
              Navigator.push(context, MaterialPageRoute(builder: (context) => GraficoEdad(provincia, model.selectedDatum[0].datum.id)));
          },
        )
      ],
    );
  }
  
  @override
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
      labelAccessorFn: (datum, index) => datum.value.toString(),
    ));

    return datosDiscapacidadesSerie;
  }
}