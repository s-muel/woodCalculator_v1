import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forest1/pdf_page.dart';

class VariedLumberVolume extends StatefulWidget {
  const VariedLumberVolume({Key? key}) : super(key: key);

  @override
  State<VariedLumberVolume> createState() => _VariedLumberVolumeState();
}

class _VariedLumberVolumeState extends State<VariedLumberVolume> {
  // form Controllers
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController thicknessController = TextEditingController();
  final TextEditingController totalWidthController = TextEditingController();
  final TextEditingController lengthController = TextEditingController();
  final TextEditingController noOfPiecesController = TextEditingController();

  // initial Variables for the card
  String volume = "";
  String thickness = "";
  String totalWidth = "";
  String length = "";
  String noOfPieces = "";

  //function for volume
  List result(double thick, double totalWidth, double length) {
    List value = [];
    double innerThickness = thick / 1000;
    double innerTotalWidth = totalWidth / 1000;
    double volume;

    volume = (innerThickness * innerTotalWidth * length);

    value.addAll([
      volume,
      innerThickness,
      innerTotalWidth,
      length,
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
          "Lumber with Varied Width",
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
                                Text('Total Width:  $totalWidth'),
                              ]),
                              Row(
                                children: [
                                  const Icon(
                                      CupertinoIcons
                                          .arrow_left_right_square_fill,
                                      size: 17),
                                  Text('Length (m):  $length'),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                ],
                              ),
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
                            controller: totalWidthController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              label: Text(
                                "total Width",
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
                            controller: lengthController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              label: Text(
                                "Length",
                                style: TextStyle(fontSize: 12),
                              ),
                              border: OutlineInputBorder(),
                              hintText: 'm',
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
                                  double.parse(totalWidthController.text),
                                  double.parse(lengthController.text),
                                );
                                setState(() {
                                  volume = funcResults[0].toStringAsFixed(3);
                                  thickness = funcResults[1].toStringAsFixed(5);
                                  totalWidth =
                                      funcResults[2].toStringAsFixed(3);
                                  length = funcResults[3].toStringAsFixed(3);
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
                                totalWidthController.clear();
                                lengthController.clear();
                                noOfPiecesController.clear();

                                // clearing the card results
                                volume = "";
                                thickness = "";
                                totalWidth = "";
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
          ],
        ),
      ),
    );
  }
}
