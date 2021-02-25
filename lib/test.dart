import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  List<int> first = new List<int>();
  List<int> second = new List<int>();
  List<int> third = new List<int>();
  @override
  void initState() {
    first = [1, 3, 5];
    second = [2, 8, 9, 10];
    for (int j = 0; j < first.length; j++) {
      for (int i = 0; i < second.length; i++) {
        if (first[j] < second[i])
          third.add(first[j]);
        else
          third.add(second[i]);
      }
    }
    print((third.length / 2) + 1);
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SingleChildScrollView(child: Container()));
  }
}
