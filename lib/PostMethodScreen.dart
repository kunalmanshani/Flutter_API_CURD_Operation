import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'API Model/UserModel.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class PostMethodScreen extends StatefulWidget {
  const PostMethodScreen({Key? key}) : super(key: key);

  @override
  _PostMethodScreenState createState() => _PostMethodScreenState();
}

Future<UserModel?> submitData(int userId ,String title, String bodyy) async {

  Map<String,dynamic> data = {
    'userId': userId,
    'title' : title,
    'body': bodyy

  };
  var body = json.encode(data);
  var response = await http.post(Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    body: body,
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
      }
  );
  var jsonresponse = json.decode(response.body);
  print(jsonresponse);
  if (response.statusCode == 201){
    print(response.statusCode);
  }
  else {
    print(response.statusCode);
  }
}

class _PostMethodScreenState extends State<PostMethodScreen> {
  TextEditingController userIdController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyControlller = TextEditingController();
  showToast(String){
    Fluttertoast.showToast(
        msg: String,
        fontSize: 20,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.yellow
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter userId"
                ),
                controller: userIdController,
              ),
              SizedBox(height: 20,),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter title"
                ),
                 controller: titleController,
              ),
              SizedBox(height: 20,),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter body"
                ),
                controller: bodyControlller,
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: () async{
                     String title = titleController.text;
                     String body = bodyControlller.text;
                     int userId = int.parse(userIdController.text);

                     if(title == '' || body == '' || userId < 0){
                       showToast("please fill all required fields");
                     }
                     else{
                       submitData(userId, title, body);
                       showToast("User Sucessfully added.");
                     }


                  },
                  child: Text('submit'),

              ),
            ],
          ),
        ),
    );
  }
 }
