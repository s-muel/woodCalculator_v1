import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forest1/pdf_page.dart';

import 'calculator_page.dart';

class VeneerVolume extends StatefulWidget {
  const VeneerVolume({Key? key}) : super(key: key);

  @override
  State<VeneerVolume> createState() => _VeneerVolumeState();
}

class _VeneerVolumeState extends State<VeneerVolume> {
  // form Controllers
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController thicknessController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController lengthController = TextEditingController();
  final TextEditingController noOfPiecesController = TextEditingController();

  // initial Variables for the card
  String volume = "";
  String thickness = "";
  String area = "";
  String length = "";
  String noOfPieces = "";

  //function for volume
  List result(double thick, double area) {
    List value = [];
    double innerThickness = thick / 1000;
    double volume;

    volume = (innerThickness * area);

    value.addAll([
      volume,
      innerThickness,
      area,
    ]);
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50))),
        title: const Text(
          "Sliced Veneer Volume",
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
                children: [
                  Card(
                    elevation: 5,
                    shadowColor: Colors.blueGrey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(
                          'Volume (m3):  $volume',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),

                          // ),
                        ),
                        trailing: const Icon(
                          Icons.check_circle,
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                      CupertinoIcons
                                          .rectangle_compress_vertical,
                                      size: 17),
                                  Text('Thickness(m):  $thickness'),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                              Row(children: [
                                const Icon(
                                    CupertinoIcons.rectangle_expand_vertical,
                                    size: 17),
                                Text('Area (m2):  $area'),
                              ]),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 100.0,
                  ),

                  // begin of textField
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '* Required';
                              }
                              return null;
                            },
                            controller: thicknessController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              label: Text(
                                "Thickness",
                                style: TextStyle(fontSize: 12),
                              ),
                              border: OutlineInputBorder(),
                              hintText: 'mm',
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
                            controller: areaController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              label: Text(
                                "Area",
                                style: TextStyle(fontSize: 12),
                              ),
                              border: OutlineInputBorder(),
                              hintText: 'm2',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey,
                            ),
                            onPressed: () async {
                              // double noOf =
                              // String noOf = noOfPiecesController.text;
                              // print(noOf);
                              if (_formKey.currentState!.validate()) {
                                List funcResults = result(
                                  double.parse(thicknessController.text),
                                  double.parse(areaController.text),
                                );
                                setState(() {
                                  volume = funcResults[0].toStringAsFixed(3);
                                  thickness = funcResults[1].toStringAsFixed(5);
                                  area = funcResults[2].toStringAsFixed(3);
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Processing Done')));
                              }
                            },
                            child: const Text('Submit'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.orange,
                            ),
                            onPressed: () {
                              return setState(() {
                                //clearing the form fields
                                _formKey.currentState!.reset();
                                thicknessController.clear();
                                areaController.clear();
                                lengthController.clear();
                                noOfPiecesController.clear();

                                // clearing the card results
                                volume = "";
                                thickness = "";
                                area = "";
                                length = "";
                                noOfPieces = "";
                              });
                            },
                            child: const Text('Clear')),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => PDFpage()));
        },
        tooltip: 'Increment',
        //insert_chart
        child: const Icon(Icons.bookmarks),
        backgroundColor: Colors.blueGrey,
        splashColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        //bottom navigation bar on scaffold
        color: Colors.blueGrey,
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
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.calculate,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CalculatorPage()));
              },
            ),
            const SizedBox(
              width: 40,
            ),
          ],
        ),
      ),
    );
  }
}
