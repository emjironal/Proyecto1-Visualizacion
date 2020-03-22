import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:proyecto1/grafico_jerarquico.dart';

void main() => runApp(
  MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.indigo
    ),
    home: MyApp()
  )
);

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    final buttons = [["Gráfico jerárquico", GraficoJerarquico()]];
    return Scaffold(
        appBar: AppBar(
          title: Text("Proyecto 1"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: createButtons(context, Colors.indigo, buttons)
          )
        )
      );
  }

  //Available at: https://gitlab.com/Tribethr/flutter-tutorial-visualizacion/-/blob/master/main.dart
  List<Widget> createButtons(BuildContext context, Color color, List<dynamic> buttonsInfo){
    List<Widget> ret = new List<Widget>();
    for(List button in buttonsInfo){
      ret.add(FlatButton(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Text(button[0], textScaleFactor: 2, style: TextStyle(color: Colors.white),),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => button[1]));
        },
      )
      );
    }
    return ret;
  }
}