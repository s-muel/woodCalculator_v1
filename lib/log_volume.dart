import 'package:flutter/material.dart';
import 'dart:math';

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
  double avDiameter1 = 0;
  double avDiameter2 = 0;

//
// List<int> getNumbers(int num1, int num2, int num3) {
//   int sum = num1 + num2 + num3;
//   int product = num1 * num2 * num3;
//   return [sum, product];
// }
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

  double calculateLogVolume(double DT1, double DT2, double l) {
    double v = (0.785 * pow(DT1 + DT2, 2) * l) / 10000;
    return v;
  }

  // double calculateLogVolume(
  //     double DB1, double DB2, double DT1, double DT2, double l) {
  //   double v = (0.785 * pow(DB1 + DB2 + DT1 + DT2, 2) * l) / 10000;
  //   return v;
  // }

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

                        trailing: Icon(Icons.access_time_filled),
                        // subtitle: Text('Average Diameter Base  :$avDiameter1'),

                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.arrow_downward_outlined),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text('Average Diameter Base   :$avDiameter1'),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.arrow_upward_rounded),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text('Average Diameter Topper  :$avDiameter2'),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    // child: Column(
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.all(40.0),
                    //       child: Text(
                    //         'Result: $_result',
                    //         style: const TextStyle(fontSize: 20),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ),
                  const SizedBox(
                    height: 100.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
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
                          child: TextField(
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
                          child: TextField(
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
                          child: TextField(
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
                        child: TextField(
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
                            onPressed: () {
                              double DB1 = double.parse(DBASE1.text);
                              double DB2 = double.parse(DBASE2.text);
                              double DT1 = double.parse(DTOP1.text);
                              double DT2 = double.parse(DTOP2.text);
                              double Len = double.parse(Lenght.text);
                              List<double> numbers =
                                  avergeDiameters(DB1, DB2, DT1, DB2);
                              avDiameter1 = numbers[0];
                              avDiameter2 = numbers[1];
                              setState(() {
                                volume = calculateLogVolume(
                                    avDiameter1, avDiameter2, Len);

                                // _result = int.parse(DBASE1.text) +
                                //     int.parse(DBASE2.text);
                              });
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
                            avDiameter1 = 0;
                            avDiameter2 = 0;
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
        shape: CircularNotchedRectangle(), //shape of notch
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