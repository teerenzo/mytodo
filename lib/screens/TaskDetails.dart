import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mytodo/DbHelper.dart';
import 'package:mytodo/screens/HomePage.dart';
import 'package:mytodo/screens/UpdateTask.dart';

class TaskDetail extends StatefulWidget {
  final id;
  final title;
  final description;
  final priority;
  final createdAt;
  final updatedAt;

  TaskDetail(this.id,this.title,this.description,this.priority,this.createdAt,this.updatedAt);

  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon:
          Icon(Icons.arrow_back,color: Colors.black,), onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context){
              return HomePage();
            })
          );
        },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Image.asset("images/IB_logo.png",height: 200,width: MediaQuery.of(context).size.width,),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               FlatButton(
                 color: HexColor("#495D69"),
                 onPressed: (){}, child: Text(
                 widget.priority=="1"?"Low":widget.priority=="2"?"High":"Medium",style: TextStyle(
                 color: Colors.white
               ),
               ),


               ),
               Container(
                 color: HexColor("#F4F5F6"),
                 height: 40,
                 child: IconButton(
                     onPressed: (){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return UpdateTask(widget.id, widget.title, widget.description, widget.priority);
    }));
                     }, icon: Icon(Icons.edit)),
               ),
               Container(
                 color: HexColor("#F4F5F6"),
                 height: 40,
                 child: IconButton(
                     onPressed: (){
                       deleteTask(widget.id.toString());
                     }, icon: Icon(Icons.delete_forever)),
               ),
               FlatButton(
                 color: Colors.white,

                 onPressed: (){}, child: Text(
                   "Done"
               )),
             ],
           ),
           Padding(padding: EdgeInsets.only(left: 14,right: 5),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               SizedBox(height: 10,),
               Text(widget.title,style: TextStyle(
                   color: HexColor("#1C2834")
               ),),
               SizedBox(height: 10,),
               Text("Description",style: TextStyle(
                   color: HexColor("#1C2834")
               ),),

               SizedBox(height: 10,),
               Text(widget.description,style: TextStyle(
                   color: HexColor("#495D69")
               ),),
               SizedBox(height: 15,),
             ],
           ),),

           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               Text("Created At '${widget.createdAt}'",style: TextStyle(
                   color: HexColor("#1C2834"),fontSize: 9
               ),),
               widget.updatedAt=='no'? Text(""): Text("Modified At '${widget.updatedAt}'",style: TextStyle(
                   color: HexColor("#495D69"),fontSize: 9
               ),),
             ],
           )
         ],
       ),
      ),
    );
  }

  void deleteTask(String id) async {
   await TodoDatabase.instance.delete(id);
   Navigator.of(context).push(
     MaterialPageRoute(builder: (context){
       return HomePage();
     })
   );
   print("deleted");
  }

  void updateTask() {

  }
}
