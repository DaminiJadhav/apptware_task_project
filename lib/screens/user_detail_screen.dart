import 'package:flutter/material.dart';

class UserDetailScreen extends StatefulWidget {
  var posts ;

  UserDetailScreen({Key? key,required this.posts}) : super(key: key);

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
              Image.network(widget.posts['picture']['medium'],height: 80,width: 80,),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.posts['login']['username'],style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20),),
                        Text(widget.posts['name']['title']+". "+widget.posts['name']['first']+" "+widget.posts['name']['last'],style: TextStyle(fontSize: 20),),
                        Text(widget.posts['location']['street']['number'].toString()+" "+widget.posts['location']['street']['name']+" "+widget.posts['location']['city']+" "+widget.posts['location']['state']+" "+widget.posts['location']['country']+" "+widget.posts['location']['postcode'].toString(),style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  )
              )
            ],
          ),
          ListTile(
            leading: Icon(Icons.email,color:  Colors.blue,),
            title: Text(widget.posts['email'],style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20),),
            // subtitle: Text(_posts[index]['name']['first'],style: TextStyle(fontSize: 16)),
          ),
          ListTile(
            leading: Icon(Icons.phone,color:  Colors.blue,),
            title: Text(widget.posts['cell'],style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20),),
            // subtitle: Text(_posts[index]['name']['first'],style: TextStyle(fontSize: 16)),
          ),
          ListTile(
            leading: Icon(Icons.date_range,color:  Colors.blue,),
            title: Text(widget.posts['dob']['date'],style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20),),
            // subtitle: Text(_posts[index]['name']['first'],style: TextStyle(fontSize: 16)),
          ),


          Text(widget.posts['location']['timezone']['description'],style: TextStyle(fontSize: 20),),

        ],
      ),
    );
  }
}
