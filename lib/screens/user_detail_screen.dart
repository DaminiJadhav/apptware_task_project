import 'package:apptware_task_project/model/user_detail_response.dart';
import 'package:flutter/material.dart';

class UserDetailScreen extends StatefulWidget {
  var posts ;
  Result results;


  UserDetailScreen({Key? key,required this.results}) : super(key: key);

  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Detail"),
      ),
      body: _userdetail(),
    );
  }

  _userdetail(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.network(widget.results.picture!.medium!,height: 80,width: 80,),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.results.login!.username!,style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20),),
                        Text(widget.results.name!.title!+". "+widget.results.name!.first!+" "+widget.results.name!.last!,style: TextStyle(fontSize: 20),),
                        Text(widget.results.location!.street!.number!.toString()+" "+widget.results.location!.street!.name!+" "+widget.results.location!.city!+" "+widget.results.location!.state!+" "+widget.results.location!.country!+" "+widget.results.location!.postcode!.toString(),style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  )
              )
            ],
          ),
          ListTile(
            leading: Icon(Icons.email,color:  Colors.blue,),
            title: Text(widget.results.email!,style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20),),
          ),
          ListTile(
            leading: Icon(Icons.phone,color:  Colors.blue,),
            title: Text(widget.results.cell!,style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20),),
          ),
          ListTile(
            leading: Icon(Icons.date_range,color:  Colors.blue,),
            title: Text(widget.results.dob!.date!.toString(),style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20),),
          ),

          Text(widget.results.location!.timezone!.description!,style: TextStyle(fontSize: 20),),


        ],
      ),
    );
  }
}
