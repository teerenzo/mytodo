

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mytodo/DbHelper.dart';
import 'package:mytodo/models/Todo.dart';
import 'package:mytodo/screens/HomePage.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
late String errorMsg;
  late bool isLoading;
  late String title,description;
  late Todo newTodo1;
  late List<Todo> newTodo;
   List<Todo> todo=[];
  @override
  void dispose() {
    // TODO: implement dispose
   // TodoDatabase.instance.close();
    super.dispose();
  }

  late String prioritys;
  @override
  void initState() {
    // TODO: implement initState
    errorMsg="";
    prioritys="1";
    isLoading=false;
    title="";
    description="";
refreshTodo();
    super.initState();
  }


  void refreshTodo() async{
    newTodo=(await TodoDatabase.instance.readAll())!;
    setState(() {
      todo=newTodo;
    });

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List priorityList = [
      {
        "id":1,
        "name":"Low"
      },
      {
        "id":2,
        "name":"High"
      },
      {
        "id":3,
        "name":"Medium"
      }
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,), onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return HomePage();
          }));
        },),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            SizedBox(height: size.height/30),
           Text("New Task",style: TextStyle(
             color: HexColor("#0C0D0D"),
             fontWeight: FontWeight.bold,
             fontSize: 18
           ),),
            SizedBox(height: size.height/18),
           Text("add image",style: TextStyle(
               color: HexColor("#0C0D0D"),
               fontWeight: FontWeight.bold,
               fontSize: 16)),
            SizedBox(height: 5),
           Container(
             height: size.height * .18,
             color: HexColor("#F4F5F6"),
             child: Center(
               child: Text("Add Image")
             ),
           ),
            SizedBox(height: size.height/18),
            Text("title",style: TextStyle(
                color: HexColor("#0C0D0D"),
                fontWeight: FontWeight.bold,
                fontSize: 16)),
            SizedBox(height: 5),
            Container(
              color: HexColor("#F4F5F6"),
              child: TextField(

                textInputAction: TextInputAction.next,
                autofocus: true,
                onChanged: (val){
                  setState(() {
                    title=val;
                  });
                },
                maxLength: 140,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Task Title',
                    contentPadding: EdgeInsets.all(12),
                  fillColor: Colors.red
                ),

              ),
            ),
            SizedBox(height: size.height/18),
            Text("Description",style: TextStyle(
                color: HexColor("#0C0D0D"),
                fontWeight: FontWeight.bold,
                fontSize: 16)),
            SizedBox(height: 5),
            Container(
              color: HexColor("#F4F5F6"),
              child: TextField(
                textInputAction: TextInputAction.next,
                autofocus: true,
                onChanged: (val){
                  setState(() {
                    description=val;
                  });
                },
                maxLength: 240,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Description",
                    contentPadding: EdgeInsets.all(12)
                ),

              ),
            ),
            SizedBox(height: size.height/18),
            Text("Priority",style: TextStyle(
                color: HexColor("#0C0D0D"),
                fontWeight: FontWeight.bold,
                fontSize: 16)),
            SizedBox(height: 5),
            Container(
              color: HexColor("#F4F5F6"),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton<String>(
                    value: prioritys,
                    iconSize: 30,
                    icon: (null),
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                    hint: Text('Select Priority'),
                    onChanged: (String? newValue) {
                      setState(() {
                        prioritys=newValue!;
                      });

                    },
                    items: priorityList.map((item) {
                      // items: [
                      return  DropdownMenuItem(
                        child: Text(item['name']),
                        value: item['id'].toString(),
                      );
                    }).toList(),
                    //  value: _myState,
                    // ],
                  ),
                ),
              ),
            ),

            SizedBox(height: size.height/18),
            Center(
              child: Text(errorMsg,style: TextStyle(
                color: Colors.red,
                fontSize: 16,

              ),),
            ),
            FlatButton(
                height: 50,
                color: HexColor("#0C0D0D"),
                onPressed: () {
                 // TodoDatabase.instance.insert();
                //  print(title);
                //  print(todo[todo.length-1].title);
                     if(title!="" && description!=""){

                       setState(() {
                         errorMsg="";
                       });
                       newTodo1=Todo(id: 0, title: "$title", decription: "$description", Priority: "$prioritys",createdAt: "",updateAt: "",status: "no");
                       makeOperation(newTodo1);

                     }else{
                       setState(() {
                         errorMsg="all field must be filled";
                       });

                     }

            }, child: Text(
              isLoading ? "Loading..." : "Create Task",
              style: TextStyle(
                color: Colors.white
              ),
            ))

          ],
        ),
      ),
    );
  }

  void makeOperation(Todo newTodo1) async{
    setState(() {
      isLoading=true;
    });
    // print(title);

      await TodoDatabase.instance.insert(newTodo1);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("SuccessFully"),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              setState(() {
                title="";
                description="";
              });
              Navigator.of(ctx).pop();
            },
            child: Text("close"),
          ),
        ],
      ),
    );
    setState(() {
      isLoading=false;
    });


  }}


