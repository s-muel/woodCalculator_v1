import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:forest1/main.dart';

class PDFpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Work Instructions'),
          //titleTextStyle: ,
        ),
        body: ListView(
          children: [
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (_) => PDFViewerFromAsset(
                    pdfAssetPath: 'assets/documents/checkpoint.pdf',
                  ),
                ),
              ),
              child: const PDFCard(
                pdfName: 'Inspection and Grading of Logs',
                pdfPages: " 7",
              ),
            ),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (_) => PDFViewerFromAsset(
                    pdfAssetPath: 'assets/documents/logID.pdf',
                  ),
                ),
              ),
              child: const PDFCard(
                pdfName: 'GRADING OF LOGS',
                pdfPages: " 20",
              ),
            ),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (_) => PDFViewerFromAsset(
                    pdfAssetPath: 'assets/documents/square.pdf',
                  ),
                ),
              ),
              child: const PDFCard(
                pdfName: 'Square-Edged Sawn Timber Inspection and Grading ',
                pdfPages: " 10",
              ),
            ),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (_) => PDFViewerFromAsset(
                    pdfAssetPath: 'assets/documents/Non.pdf',
                  ),
                ),
              ),
              child: const PDFCard(
                pdfName: 'NON-ANATOMICAL CHARACTERS IN WOOD ',
                pdfPages: " 14",
              ),
            ),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (_) => PDFViewerFromAsset(
                    pdfAssetPath: 'assets/documents/veneer.pdf',
                  ),
                ),
              ),
              child: const PDFCard(
                pdfName: 'Sliced Veneer Inspection and Grading',
                pdfPages: " 7",
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MyHomePage(
                      title: '',
                    )));
            // Navigator.of(context).pop();
          },
          tooltip: 'Increment',
          //insert_chart
          child: const Icon(Icons.home),
          backgroundColor: Colors.green,
          splashColor: Colors.lightGreenAccent,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          //bottom navigation bar on scaffold
          color: Colors.green,
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
                  Icons.settings,
                  color: Colors.green,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PDFCard extends StatelessWidget {
  const PDFCard({
    Key? key,
    required this.pdfName,
    required this.pdfPages,
  }) : super(key: key);

  final String pdfName;
  final String pdfPages;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: const CircleAvatar(
          backgroundImage: AssetImage(
            'assets/images/book.jpg',
          ),
          radius: 15,
        ),
        title: Text("$pdfName", style: const TextStyle(fontSize: 15)),
        subtitle: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              CupertinoIcons.book_circle,
              color: Colors.green,
            ),
            Text(
              "View Document",
              style: TextStyle(
                color: Colors.green,
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Pages :"),
            Text(
              "$pdfPages",
              style: const TextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}

class PDFViewerFromAsset extends StatelessWidget {
  PDFViewerFromAsset({Key? key, required this.pdfAssetPath}) : super(key: key);
  final String pdfAssetPath;
  final Completer<PDFViewController> _pdfViewController =
      Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
      StreamController<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Work Instructions Reader'),
        actions: <Widget>[
          StreamBuilder<String>(
              stream: _pageCountController.stream,
              builder: (_, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green[400],
                      ),
                      child: Text(snapshot.data!),
                    ),
                  );
                }
                return const SizedBox();
              }),
        ],
      ),
      body: PDF(
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
        onPageChanged: (int? current, int? total) =>
            _pageCountController.add('${current! + 1} / $total'),
        onViewCreated: (PDFViewController pdfViewController) async {
          _pdfViewController.complete(pdfViewController);
          final int currentPage = await pdfViewController.getCurrentPage() ?? 0;
          final int? pageCount = await pdfViewController.getPageCount();
          _pageCountController.add('${currentPage + 1} - $pageCount');
        },
      ).fromAsset(
        pdfAssetPath,
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _pdfViewController.future,
        builder: (_, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: '<',
                  child: const Text('<'),
                  onPressed: () async {
                    final PDFViewController pdfController = snapshot.data!;
                    final int currentPage =
                        (await pdfController.getCurrentPage())! - 1;
                    if (currentPage >= 0) {
                      await pdfController.setPage(currentPage);
                    }
                  },
                ),
                FloatingActionButton(
                  heroTag: '>',
                  child: const Text('>'),
                  onPressed: () async {
                    final PDFViewController pdfController = snapshot.data!;
                    final int currentPage =
                        (await pdfController.getCurrentPage())! + 1;
                    final int numberOfPages =
                        await pdfController.getPageCount() ?? 0;
                    if (numberOfPages > currentPage) {
                      await pdfController.setPage(currentPage);
                    }
                  },
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
