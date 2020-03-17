import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:random_color/random_color.dart';
import 'datos.dart';

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
        title: Text("Gráfico Circular Radial"),
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
    if(data.alajuela.isEmpty)
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
    final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();
    List<CircularStackEntry> data = <CircularStackEntry>[
      new CircularStackEntry(
        getDatosProvincia(Data.getInstance().alajuela),
        rankKey: 'Alajuela',
      ),
      new CircularStackEntry(
        getDatosProvincia(Data.getInstance().heredia),
        rankKey: 'Heredia',
      ),
      new CircularStackEntry(
        getDatosProvincia(Data.getInstance().sanjose),
        rankKey: 'San José',
      ),
      new CircularStackEntry(
        getDatosProvincia(Data.getInstance().limon),
        rankKey: 'Limon',
      ),
      new CircularStackEntry(
        getDatosProvincia(Data.getInstance().cartago),
        rankKey: 'Cartago',
      ),
      new CircularStackEntry(
        getDatosProvincia(Data.getInstance().guanacaste),
        rankKey: 'Guanacaste',
      ),
      new CircularStackEntry(
        getDatosProvincia(Data.getInstance().puntarenas),
        rankKey: 'Puntarenas',
      ),
    ];
    return new AnimatedCircularChart(
      key: _chartKey,
      size: const Size(300.0, 300.0),
      initialChartData: data,
      chartType: CircularChartType.Radial,
    );
  }

  List<CircularSegmentEntry> getDatosProvincia(List provincia)
  {
    RandomColor _randomColor = RandomColor(10);
    List<CircularSegmentEntry> datosProvincia = new List();
    for(int i = 1; i < provincia.length; i++)
    {
      datosProvincia.add(
        new CircularSegmentEntry(
          provincia[i][1].toDouble(), //valor
          _randomColor.randomColor(colorBrightness: ColorBrightness.light), //color
          rankKey: provincia[i][0] //nombre
        )
      );
    }
    return datosProvincia;
  }
}