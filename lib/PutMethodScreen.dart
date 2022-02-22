import 'package:flutter/material.dart';

class PutMethodScreen extends StatefulWidget {
  const PutMethodScreen({Key? key}) : super(key: key);

  @override
  _PutMethodScreenState createState() => _PutMethodScreenState();
}

class _PutMethodScreenState extends State<PutMethodScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Card(
        child: Column(
          children: [
            TextField(),
            TextField(),
            TextField(),
            ElevatedButton(
                onPressed: null,
                child: Text('Update')
            )
          ],
        ),
      ),
    );
  }
}
