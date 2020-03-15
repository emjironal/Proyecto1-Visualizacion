import 'read_csv.dart';

class Data
{
  static final Data instance = new Data();

  final List sanjose = new List(),
    alajuela = new List(),
    heredia = new List(),
    cartago = new List(),
    limon = new List(),
    guanacaste = new List(),
    puntarenas = new List();

  Data(){loadData();}

  void loadData() async
  {
    sanjose.addAll(await read_csv('assets/data/sanjose.csv'));
    cartago.addAll(await read_csv('assets/data/cartago.csv'));
    alajuela.addAll(await read_csv('assets/data/alajuela.csv'));
    heredia.addAll(await read_csv('assets/data/heredia.csv'));
    guanacaste.addAll(await read_csv('assets/data/guanacaste.csv'));
    puntarenas.addAll(await read_csv('assets/data/puntarenas.csv'));
    limon.addAll(await read_csv('assets/data/limon.csv'));
  }

  static Data getInstance() => instance;
}