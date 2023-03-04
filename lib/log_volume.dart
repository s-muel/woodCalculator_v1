import 'package:flutter/material.dart';
import 'dart:math';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

class LogVolume extends StatefulWidget {
  const LogVolume({Key? key}) : super(key: key);

  @override
  State<LogVolume> createState() => _LogVolumeState();
}

class _LogVolumeState extends State<LogVolume> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController DBASE1 = TextEditingController();
  final TextEditingController DBASE2 = TextEditingController();
  final TextEditingController DTOP1 = TextEditingController();
  final TextEditingController DTOP2 = TextEditingController();
  final TextEditingController Lenght = TextEditingController();
  double volume = 0;
  double averageDiameterBase = 0;
  double averageDiameterTop = 0;

  double reckonerValue = 0;

  //adding the reckoner
  List<List<dynamic>> table = [];

  Future<List> _loadCSV() async {
    final _rawData = await rootBundle.loadString("assets/documents/file2.csv");
    List<List<dynamic>> _listData =
        const CsvToListConverter().convert(_rawData);
    table = _listData;
    return table;
  }

  List<double> avergeDiameters(
    DB1,
    DB2,
    DT1,
    DT2,
  ) {
    double DB = (DB1 + DB2) / 2;
    double DT = (DT1 + DT2) / 2;
    return [DB, DT];
  }

// new volume with reckoner
  double calculateLogVolume(double length, double reckoner) {
    double volume = length * reckoner;
    return volume;
  }

  // adding color to icon
  bool setColor = false;
  Color _getIconColor(bool result) {
    if (result) {
      return Colors.green; // assign green color if result is true
    } else {
      return Colors.grey; // assign red color if result is false
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50))),
        title: const Text(
          "Timber Log Volume Calculator",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: ListView(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                    elevation: 5,
                    shadowColor: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(
                          'Volume (m3):  ${volume.toStringAsFixed(3)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          // style: TextStyle(

                          // ),
                        ),

                        trailing: Icon(Icons.check_circle,
                            color: _getIconColor(setColor)),
                        // subtitle: Text('Average Diameter Base  :$avDiameter1'),

                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.arrow_downward_outlined),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    'Average Diameter Base   :$averageDiameterBase'),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.arrow_upward_rounded),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    'Average Diameter Topper  :$averageDiameterTop'),
                              ],
                            ),
                            Visibility(
                              visible: setColor,
                              child: Row(
                                children: [
                                  const Icon(Icons.my_library_books),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text('Reckoner Value  :$reckonerValue'),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 100.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '* Required';
                              }
                              return null;
                            },
                            controller: DBASE1,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              label: Text(
                                "Diameter Base 1",
                                style: TextStyle(fontSize: 12),
                              ),
                              border: OutlineInputBorder(),
                              hintText: 'cm',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '* Required';
                              }
                              return null;
                            },
                            controller: DBASE2,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              label: Text(
                                "Diameter Base 2",
                                style: TextStyle(fontSize: 12),
                              ),
                              border: OutlineInputBorder(),
                              hintText: 'cm',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '* Required';
                              }
                              return null;
                            },
                            controller: DTOP1,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              label: Text(
                                "Diameter Tapper 1",
                                style: TextStyle(fontSize: 12),
                              ),
                              border: OutlineInputBorder(),
                              hintText: 'cm',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '* Required';
                              }
                              return null;
                            },
                            controller: DTOP2,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              label: Text(
                                "Diameter Tapper 2",
                                style: TextStyle(fontSize: 12),
                              ),
                              border: OutlineInputBorder(),
                              hintText: 'cm',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '* Required';
                            }
                            return null;
                          },
                          controller: Lenght,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            label: Text("Length"),
                            hintText: "m",
                            border: OutlineInputBorder(),
                            //icon: Icon(Icons.person),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            child: const Text('Add'),
                            color: Colors.green,
                            elevation: 9,
                            onPressed: () async {
                              List tableData = await _loadCSV();
                              print(tableData);
                              // checking if the form field is not empty
                              if (_formKey.currentState!.validate()) {
                                double DB1 = double.parse(DBASE1.text);
                                double DB2 = double.parse(DBASE2.text);
                                double DT1 = double.parse(DTOP1.text);
                                double DT2 = double.parse(DTOP2.text);
                                double Len = double.parse(Lenght.text);
                                List<double> numbers =
                                    avergeDiameters(DB1, DB2, DT1, DT2);
                                averageDiameterBase = numbers[0].toDouble();
                                averageDiameterTop = numbers[1].toDouble();

                                //generating reckoner
                                int reckDBase = averageDiameterBase.toInt();
                                int reckDTop = averageDiameterTop.toInt();
                                if (reckDTop < reckDBase ||
                                    reckDTop == reckDBase) {
                                  List checker = [];
                                  
                                  checker.add(tableData[reckDBase][reckDTop]);
                                  //reckonerValue = tableData[reckDBase][reckDTop];
                                  if (checker[0] is! num || checker[0].isNaN) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                            'Reckoner Error',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          content: const Text(
                                              'Kindly contact Admin'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Ok'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    setState(() {
                                      reckonerValue = checker[0];
                                      volume = calculateLogVolume(
                                          Len, reckonerValue);
                                      setColor = true;
                                    });
                                  }

                                  //double reckcheck = tableData[20][20];
                                  // print(reckcheck.runtimeType);

                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                          'Error',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        content: const Text(
                                            'Diameter Topper can not be greater than Diameter Base'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Try Again'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }

                                //The SnackBar
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );
                              } else {}
                            },
                          ),
                        ),
                      ),
                      Expanded(
                          child: RaisedButton(
                        color: Colors.orange,
                        elevation: 9,
                        onPressed: () {
                          setState(() {
                            _formKey.currentState!.reset();
                            DBASE1.clear();
                            DBASE2.clear();
                            DTOP1.clear();
                            DTOP2.clear();
                            Lenght.clear();
                            volume = 0;
                            averageDiameterBase = 0;
                            averageDiameterTop = 0;
                            reckonerValue = 0;
                            setColor = false;
                          });
                        },
                        child: Text("Clear"),
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        //insert_chart
        child: const Icon(Icons.bookmarks),
        backgroundColor: Colors.blue,
        splashColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        //bottom navigation bar on scaffold
        color: Colors.blue,
        shape: const CircularNotchedRectangle(), //shape of notch
        notchMargin:
            5, //notche margin between floating button and bottom appbar
        child: Row(
          //children inside bottom appbar
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.home,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

//LogVolume
