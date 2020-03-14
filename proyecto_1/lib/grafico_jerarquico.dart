import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';

class GraficoJerarquico extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => GraficoJerarquicoState();
}

class GraficoJerarquicoState extends State<GraficoJerarquico>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gráfico Jerárquico"),
        centerTitle: true
      ),
      body: Text("Grafico jerarquico")
    );
  }
}