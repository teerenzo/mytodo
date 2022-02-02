import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mytodo/models/Todo.dart';
import 'package:mytodo/redux/AppState.dart';
import 'package:mytodo/redux/reduces.dart';
import 'package:mytodo/screens/AddTask.dart';
import 'package:mytodo/screens/TaskDetails.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../DbHelper.dart';
class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Todo newTodo1;
  late String filterBy;
  late bool isSelected;
  late List<Todo> newTodo;
  bool isEmpty=true;
  bool isLoading=false;
  late String? all,all1='';
  List<Todo> todo=[];
  @override
  void initState() {
    // TODO: implement initState
    filterBy='';
    refreshTodo();
isSelected=false;
    super.initState();
  }


  void refreshTodo() async{
    all=await TodoDatabase.instance.countAll();
    all1=all;
    isEmpty=false;
    isLoading=true;

    newTodo=(await TodoDatabase.instance.readAll())!;
    isLoading=false;
    newTodo.length<=0 ? isEmpty=true : isEmpty=false;
    print(newTodo.length);
    setState(() {
      todo=newTodo;
    });

  }


  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return Scaffold(
      body:  ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
              children: [
                Container(
                  height: size.height * .4,
                  decoration: BoxDecoration(
                    color: HexColor("#1C2834")
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: size.height/13),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(onPressed: (){}, icon: Image.asset("images/IW_logo.png")),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(onPressed: (){
                                    showMenu(context: context, position: RelativeRect.fromLTRB(25, 25, 0, 0), items:
                                    [
                                      const PopupMenuItem(child: Text(
                                          "Filter By Priority"
                                      )),
                                      PopupMenuItem(child: TextButton(onPressed: () {
                                        setState(() {
                                          filterBy='1';
                                        });
                                        getList(filterBy);
                                      },
                                        child: Text("Low Priority"),

                                      ))
                                      ,
                                      PopupMenuItem(child: TextButton(onPressed: () {
                                        setState(() {

                                          filterBy='3';
                                        });
                                        getList(filterBy);
                                      },
                                        child: Text("Medium Priority"),

                                      ))
                                      ,
                                      PopupMenuItem(child: TextButton(onPressed: () {
                                        setState(() {
                                          filterBy='2';
                                        });
                                        getList(filterBy);
                                      },
                                        child: Text("High Priority"),

                                      ))
                                    ]);


                                  },
                                    icon: Icon(Icons.search ,color: Colors.white,size: 30,)),
                                  // IconButton(onPressed: (){}, icon: Icon(Icons.search ,color: Colors.white,size: 50,))
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height/14,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Colors.white,
                          ),
                          height: size.height,
                          padding: EdgeInsets.all(25),
                          child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Welcome",style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),),
                              GridView(
                                shrinkWrap: true,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 2.0,mainAxisSpacing: 10,crossAxisSpacing: 10,crossAxisCount: 2),

                                children: [
                                  Card(
                                    child: ListTile(
                                      title: Text(todo.length.toString(),style: TextStyle(
                                          color: HexColor("#C1CF16"),
                                          fontFamily: "Montserrat Bold",
                                        fontWeight: FontWeight.bold
                                      ),
                                      ),
                                      subtitle: Text("total Task(s)"),
                                    ),
                                  ), Card(
                                    child: ListTile(
                                      title: Text("0",style: TextStyle(
                                          color: HexColor("#C1CF16"),
                                          fontFamily: "Montserrat Bold"
                                      ),
                                      ),
                                      subtitle: Text("Active Task"),
                                    ),
                                  ), Card(
                                    child: ListTile(
                                      title: Text("0",style: TextStyle(
                                          color: HexColor("#C1CF16"),
                                          fontFamily: "Montserrat Bold"
                                      ),
                                      ),
                                      subtitle: Text("Task Done"),
                                    ),
                                  ), Card(
                                    child: ListTile(
                                      title: Text("0",style: TextStyle(
                                          color: HexColor("#C1CF16"),
                                          fontFamily: "Montserrat Bold"
                                      ),
                                      ),
                                      subtitle: Text("Active High Priority"),
                                    ),
                                  )

                                         ],
                                    ),
                              SizedBox(
                                height: size.height/14,
                              ),
                         isLoading? Center(child: Text("Loading...",style: TextStyle(
                           color: Colors.blue
                         ),)):  isEmpty ?  Center(
                                child:  Container(
                                  child: Column(
                                   children: [
                                      Text("Nothing Here",style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      ),),
                                     Text("Just like Your Crush's Replies",style: TextStyle(
                                         fontWeight: FontWeight.bold
                                     ),),
                                     RaisedButton(onPressed: () {
                                       Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                         return AddTask();
                                       }));
                                     },
                                     child: Text(
                                       "start with a new Task",
                                       style: TextStyle(
                                         color: Colors.white,
                                         backgroundColor: HexColor("#0C0D0D")
                                       ),
                                     ))


                                    ],
                                  ) ,
                                )
                              ) : Expanded(
          child: ListView.builder(
          shrinkWrap: true,
          itemCount: todo.length,
          itemBuilder: (BuildContext context, int index) {
          return Container(

            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
            ),
            child: Column(
              children: [
                Card(
                  child: ListTile(
                    onTap:(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return TaskDetail(todo[index].id, todo[index].title, todo[index].decription, todo[index].Priority,todo[index].createdAt,todo[index].updateAt);
                      }));
                    },
                    title: Text(todo[index].title),
                    leading: Checkbox(
                      value: todo[index].status=='no'?false:true,
                      onChanged: (bool? value) {
                       updateStatus(todo[index].id.toString());
                      },

                    ),
                    subtitle:Text(todo[index].decription.toString()) ,
     trailing: IconButton(icon: Icon(Icons.more_vert), onPressed: () {  },


     ),
                  ),
                ),
                // Divider(
                //   color: Colors.black,
                // )
              ],
            ),
          );
          }
          ),
          ),

                            ],
                          ),

                          ),

                      ],
                    ),
                  ),
                ),


              ],

          );}
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: HexColor("#0C0D0D"),
        onPressed: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
            return AddTask();
          }));
        },
        tooltip: 'add Task',
        child: const Icon(Icons.add),
      ),
      );

  }

  void getList(String priority) async{

  List<Todo>? newTodo3 =  await TodoDatabase.instance.readOne(priority);
  setState(() {
  todo=newTodo3!;
  });
  }

  void updateStatus(String id) async {
       await TodoDatabase.instance.updateStatus(id);
       List<Todo>? newTodo3 =  await TodoDatabase.instance.readAll();
       setState(() {
         todo=newTodo3!;
       });
  }
}
