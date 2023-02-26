// import 'package:csv/csv.dart';
// import 'package:flutter/services.dart';

// class CsvLoader {
//   List<List<dynamic>> _table = [];

//   Future<void> loadCsv(String path) async {
//     String csvData = await rootBundle.loadString(path);
//     List<List<dynamic>> listData = CsvToListConverter().convert(csvData);
//     _table = listData;
//   }

//   List<List<dynamic>> get table => _table;
// }


// CsvLoader csvLoader = CsvLoader();
// await csvLoader.loadCsv("assets/documents/file.csv");
// List<List<dynamic>> tableData = csvLoader.table;