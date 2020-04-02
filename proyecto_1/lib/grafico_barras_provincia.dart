import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:proyecto1/datos_provincia.dart';
import 'grafico_barras.dart';
import 'grafico_barras_discapacidades.dart';
import 'interface_datos.dart';

class GraficoBarrasProvincia extends GraficoBarras
{
  GraficoBarrasProvincia()
  {
    super.datos = new DatosProvincia();
    super.appTitle = "Provincia";
    super.title = "Discapacitados por provincia";
    super.subtitle = "Presione alguna sección\n para más información";
  }

  @override
  State<StatefulWidget> createState() => GraficoBarrasProvinciaState(this.datos, this.appTitle, this.title, this.subtitle);
}

class GraficoBarrasProvinciaState extends GraficoBarrasState
{
  GraficoBarrasProvinciaState(Datos datos, String appTitle, String title, String subtitle)
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
      selectionModels: [
        new SelectionModelConfig<String>(
          changedListener: (model)
          {
            if(model.selectedDatum.length > 0)
              Navigator.push(context, MaterialPageRoute(builder: (context) => GraficoBarrasDiscapacidad(model.selectedDatum[0].datum.id)));
          },
        )
      ],
    );
  }
}