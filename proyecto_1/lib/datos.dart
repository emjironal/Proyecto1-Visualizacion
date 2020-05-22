import 'package:proyecto1/enum_tipo_data.dart';

import 'read_csv.dart';

class Dato
{
  final String nombre;
  final List datos;

  Dato(this.nombre, this.datos);
}

class Data
{
  static final Data _instance = new Data();

  final List<Dato> provincias = new List<Dato>();
  final List<Dato> sexo = new List<Dato>();

  Future<void> loadData() async
  {
    provincias.add(new Dato("San José", await read_csv('assets/data/sanjose.csv')));
    provincias.add(new Dato("Cartago", await read_csv('assets/data/cartago.csv')));
    provincias.add(new Dato("Alajuela", await read_csv('assets/data/alajuela.csv')));
    provincias.add(new Dato("Heredia", await read_csv('assets/data/heredia.csv')));
    provincias.add(new Dato("Guanacaste", await read_csv('assets/data/guanacaste.csv')));
    provincias.add(new Dato("Puntarenas", await read_csv('assets/data/puntarenas.csv')));
    provincias.add(new Dato("Limón", await read_csv('assets/data/limon.csv')));
    sexo.add(new Dato("Hombres", await read_csv('assets/data/hombres.csv')));
    sexo.add(new Dato("Mujeres", await read_csv('assets/data/mujeres.csv')));
  }

  Dato getDatos(String tipo)
  {
    Dato dato;
    this.sexo.forEach((sexo)
    {
      if(sexo.nombre == tipo)
      {
        dato = sexo;
      } //end if
    }); //end forEach

    this.provincias.forEach((provincia)
    {
      if(provincia.nombre == tipo)
      {
        dato = provincia;
      }
    }); //end forEach

    return dato;
  } //end getDatos

  static Data getInstance() => _instance;
}

class DataChart
{
  final int id;
  final String name;
  final int value;

  DataChart(this.id, this.name, this.value);
}