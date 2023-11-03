import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestWidget extends StatefulWidget {
  String name;
  TestWidget({super.key, required this.name});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  int counter = 0;
  @override
  void initState() {
    print("test init");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("test widget");
    return InkWell(
      onTap: () {
        setState(() {
          counter++;
          widget.name += "j ";
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.lightGreen,
        child: Text("${widget.name} $counter"),
      ),
    );
  }
}
