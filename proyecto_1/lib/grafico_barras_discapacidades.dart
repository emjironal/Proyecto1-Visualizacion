import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:proyecto1/grafico_barras_edades.dart';
import 'datos_discapacidades.dart';
import 'datos.dart';
import 'grafico_barras.dart';
import 'interface_datos.dart';

class GraficoBarrasDiscapacidad extends GraficoBarras
{
  int provincia;

  GraficoBarrasDiscapacidad(this.provincia)
  {
    super.datos = new DatosDiscapacidad(this.provincia);
    super.appTitle = "Discapacidades";
    super.title = "Tipos de discapacidades en ${Data.getInstance().provincias[provincia].nombre}";
    super.subtitle = "Presione alguna sección\n para más información";
  }
  
  @override
  State<StatefulWidget> createState() => GraficoBarrasDiscapacidadState(this.datos, this.appTitle, this.title, this.subtitle, this.provincia);
}

class GraficoBarrasDiscapacidadState extends GraficoBarrasState
{
  int provincia;
  
  GraficoBarrasDiscapacidadState(Datos datos, String appTitle, String title, String subtitle, this.provincia)
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
      domainAxis: new OrdinalAxisSpec(renderSpec: new NoneRenderSpec()),
      selectionModels: [
        new SelectionModelConfig<String>(
          changedListener: (model)
          {
            if(model.selectedDatum.length > 0)
              Navigator.push(context, MaterialPageRoute(builder: (context) => GraficoBarrasEdades(provincia, model.selectedDatum[0].datum.id)));
          },
        )
      ],
    );
  }
}