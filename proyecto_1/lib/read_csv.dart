import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

Future<List> read_csv(String path) async
{
  String file = await rootBundle.loadString(path);
  List result = CsvToListConverter().convert(file, eol: "\n", fieldDelimiter: ",").toList();
  return result;
}