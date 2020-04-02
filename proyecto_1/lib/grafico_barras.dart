import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'interface_datos.dart';
import 'interface_grafico.dart';
import 'datos.dart';

abstract class GraficoBarras extends StatefulWidget
{
  String appTitle, title, subtitle;
  Datos datos;
}

abstract class GraficoBarrasState extends State<GraficoBarras> implements Grafico
{
  Widget _widget;
  String appTitle, title, subtitle;
  Datos datos;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
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
        _widget = getGrafico();
      });
    }
    else
    {
      _widget = getGrafico();
    }
  }
}