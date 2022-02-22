import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:task4/API Model/UserModel.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
class GetMethodScreen extends StatefulWidget {
  const GetMethodScreen({Key? key}) : super(key: key);

  @override
  _GetMethodScreenState createState() => _GetMethodScreenState();
}

class _GetMethodScreenState extends State<GetMethodScreen> {
  static List<UserModel> Listdata = [];
  TextEditingController updateUID = TextEditingController();
  TextEditingController updateTitle = TextEditingController();
  TextEditingController updateBody = TextEditingController();
  Future<void> _displayTextInputDialog(BuildContext context, index) async {
    setState(() {
      updateUID.text = Listdata[index].userId.toString();
      updateTitle.text = Listdata[index].title;
      updateBody.text = Listdata[index].body;
    });
    return showDialog(
        context: context,
        builder: (context) {
          return SingleChildScrollView(

            child: AlertDialog(
              title: Text('Update User'),
              content: Column(
                children: [
                  TextField(
                    controller: updateUID,
                  ),
                  TextField(
                    controller: updateTitle,

                  ),
                  TextField(
                    controller: updateBody,
                  ),
                ],
              ),

              actions: <Widget>[
                FlatButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text('CANCEL'),
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                ),
                FlatButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  child: Text('Update'),
                  onPressed: () {
                    setState(() {
                      Listdata[index].userId = int.parse(updateUID.text);
                      Listdata[index].title = updateTitle.text;
                      Listdata[index].body = updateBody.text;
                      updateUser(updateTitle.text, updateBody.text ,index.toString());
                      Navigator.pop(context);
                    });
                  },
                ),
              ],
            ),
          );
        });
  }



  Future deleteData(String id) async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts/$id');
    var response = await http.delete(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "User Deleted Sucessfully",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.blue,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 5,
          textColor: Colors.red,



      );
      setState(() {
        Listdata.removeWhere((element){
          return element.id.toString() == id;
        });
      });
      // return UserModel.fromJson(jsonDecode(response.body));

    } else {
      throw Exception('Failed to delete Usermodel.');
    }
  }

  Future<UserModel?> updateUser(String title ,String body, String id) async {
    final response = await http.put(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'body' : body,
      }),
    );
    if (response.statusCode == 200) {
      setState(() {
        Listdata[int.parse(id)].title = title;
        Listdata[int.parse(id)].body = body;
      });
      // return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update User.');
    }
  }

  Future <List<UserModel>> fetchData() async {
    var response = await http.get(Uri.https("jsonplaceholder.typicode.com", "posts"));
    if(response.statusCode == 200){
      List jsonResponse = json.decode(response.body);
      var data = jsonResponse.map((user) => new UserModel.fromJson(user)).toList();
      AddData(data);
      return data;
    }
    else{
      throw Exception('Unexpected error occured!');
    }
  }
  AddData(List data){
    for(int i=0; i<10; i++){
      Listdata.add(data[i]);
    }
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: Listdata.length,
        itemBuilder: (BuildContext context,int index){
          return Container(
            margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
            height: 100,
            // padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
            decoration: BoxDecoration(
                // border: Border.all(width: 1,color: Colors.blue)
            ),
            child: Card(
              elevation: 5,
              child: ListTile(
                style: ListTileStyle.drawer,
                title:Text(Listdata[index].title,style: TextStyle(fontSize: 15,wordSpacing:1),),
                leading: IconButton(
                  iconSize: 20,
                  icon: Icon(Icons.edit),
                  onPressed: (){
                    _displayTextInputDialog(context,index);

                  },
                ),
                subtitle: Text("ID: "+ Listdata[index].id.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                trailing: IconButton(
                  onPressed: () {
                    deleteData(Listdata[index].id.toString());


                    },
                  icon: Icon(Icons.delete),
                  tooltip: "delete row",
                  color: Colors.red,)

              ),
            ),
          );
        }
    );
  }
}


