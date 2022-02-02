
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mytodo/DbHelper.dart';
import 'package:mytodo/models/Todo.dart';

import 'HomePage.dart';

class UpdateTask extends StatefulWidget {
  final id;
  final title;
  final description;
  final priority;

  const UpdateTask(this.id,this.title,this.description,this.priority);

  @override
  _UpdateTaskState createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  late String errorMsg;
  late String title,description,priority1;
  late int id;
  late Todo newTodo1;
  late String prioritys;
  final now =DateTime.now();
  @override
  void initState() {
    errorMsg="";
    // TODO: implement initState
    widget.priority=='High' ? prioritys="2" : widget.priority=='Low' ? prioritys="1" : prioritys="3";

    id=widget.id;
    title=widget.title;
    description=widget.description;

    priority1=widget.priority;
    super.initState();
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
            Text("Update Task",style: TextStyle(
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
              child: TextFormField(
                initialValue: title,
                onChanged: (val){
                  setState(() {
                    title=val;
                  });
                },
                maxLength: 140,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: title,
                    contentPadding: EdgeInsets.all(12),
                    fillColor: Colors.red,

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
              child: TextFormField(
                initialValue: description,
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
                    value:prioritys,
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
                    newTodo1=Todo(id: widget.id, title: "$title", decription: "$description", Priority: "$prioritys",createdAt: "",updateAt: now.toString(),status: "no" );
                    makeOperation(newTodo1);

                  }else{
                    setState(() {
                      errorMsg="all field must be filled";
                    });

                  }
                }, child: Text(
              "Update Task",
              style: TextStyle(
                  color: Colors.white
              ),
            ))

          ],
        ),
      ),
    );
  }

  void makeOperation(Todo newTodo1) async {
   int? res= await TodoDatabase.instance.update(newTodo1);
 if(res==1){
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
 }

  }
}
