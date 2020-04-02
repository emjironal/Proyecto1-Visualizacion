import 'package:charts_flutter/flutter.dart';
import 'datos.dart';

abstract class Datos
{
  List<Series<DataChart, String>> getDatos();
}