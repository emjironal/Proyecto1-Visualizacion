import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:random_color/random_color.dart';
import 'package:charts_flutter/flutter.dart';
import 'datos.dart';
import 'grafico_discapacidades_provincia.dart';

class GraficoJerarquico extends StatefulWidget
{  
  @override
  State<StatefulWidget> createState() => GraficoJerarquicoState();
}

class GraficoJerarquicoState extends State<GraficoJerarquico>
{
  Widget _widget;

  GraficoJerarquicoState(){isLoading();}

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Provincias"),
        centerTitle: true
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: _widget,
        ),
      ),
    );
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
        _widget = _getGrafico();
      });
    }
    else
    {
      _widget = _getGrafico();
    }
  }

  Widget _getGrafico()
  {
    return new PieChart(
      getDatosProvincia(),
      animate: false,
      defaultRenderer: new ArcRendererConfig(
        arcWidth: 80,
        arcRendererDecorators: [
          new ArcLabelDecorator(
            labelPosition: ArcLabelPosition.inside,
          )
        ]
      ),
      behaviors: [
        new ChartTitle(
          "Discapacitados por provincia",
          subTitle: "Presione alguna sección\n para más información",
          behaviorPosition: BehaviorPosition.top
        ),
        new DatumLegend(
          position: BehaviorPosition.bottom,
          horizontalFirst: false,
          cellPadding: new EdgeInsets.only(right: 5.0, bottom: 5.0),
          desiredMaxRows: 3
        )
      ],
      selectionModels: [
        new SelectionModelConfig(
          changedListener: (model)
          {
            Navigator.push(context, MaterialPageRoute(builder: (context) => GraficoDiscapacidad(model.selectedDatum[0].datum.id)));
          },
        )
      ],
    );
  }
  
  List<Series<DataChart, String>> getDatosProvincia()
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