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



import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Choose an option'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    InkWell(
                      child: Text('Option 1'),
                      onTap: () {
                        // Handle option 1
                        Navigator.of(context).pop(); // close the dialog
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                    InkWell(
                      child: Text('Option 2'),
                      onTap: () {
                        // Handle option 2
                        Navigator.of(context).pop(); // close the dialog
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Card(
        child: Column(
          children: [
            Text('My card'),
            Text('Tap to choose an option'),
          ],
        ),
      ),
    );
  }
}

