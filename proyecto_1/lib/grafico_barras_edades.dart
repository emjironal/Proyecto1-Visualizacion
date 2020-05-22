import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'datos.dart';
import 'datos_edades.dart';
import 'grafico_barras.dart';
import 'interface_datos.dart';

class GraficoBarrasEdades extends GraficoBarras
{
  int provincia, discapacidad;

  GraficoBarrasEdades(this.provincia, this.discapacidad)
  {
    super.datos = new DatosEdades(this.provincia, this.discapacidad);
    super.appTitle = "Edades";
    super.title = "Rangos de edades en ${Data.getInstance().provincias[provincia].nombre}";
    super.subtitle = "${Data.getInstance().provincias[provincia].datos[0][discapacidad]}";
  }
  
  @override
  State<StatefulWidget> createState() => GraficoBarrasEdadesState(this.datos, this.appTitle, this.title, this.subtitle, this.provincia, this.discapacidad);
}

class GraficoBarrasEdadesState extends GraficoBarrasState
{
  int provincia, discapacidad;

  GraficoBarrasEdadesState(Datos datos, String appTitle, String title, String subtitle, this.provincia, this.discapacidad)
  {
    super.datos = datos;
    super.appTitle = appTitle;
    super.title = title;
    super.subtitle = subtitle;
    isLoading();
  }

  @override
  Widget getGrafico()
  {
    return new BarChart(
      datos.getDatos(),
      animate: false,
      vertical: false,
      behaviors: [
        new ChartTitle(
          title,
          subTitle: subtitle,
          behaviorPosition: BehaviorPosition.top
        ),
      ],
      barRendererDecorator: new BarLabelDecorator<String>(),
    );
  }
}