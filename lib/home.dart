import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'Authentication.dart';
import 'UploadPhoto.dart';
import 'post.dart';

class Home extends StatefulWidget {
  Home({
    this.auth,
    this.onSignedOut,
  });

  final AuthenticationImplimentation auth;
  final VoidCallback onSignedOut;

  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  List<Post> postList = [];

  void logOutUser() async {
    try {
      widget.auth.signOut();
      widget.onSignedOut;
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    DatabaseReference postRef =
        FirebaseDatabase.instance.reference().child('Posts');

    postRef.once().then((DataSnapshot dataSnapShot) {
      var KEYS = dataSnapShot.value.keys;
      var DATA = dataSnapShot.value;

      postList.clear();

      for (var key in KEYS) {
        Post post = Post(DATA[key]['image'], DATA[key]['description'],
            DATA[key]['date'], DATA[key]['time']);

        postList.add(post);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Home'),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: postList.length,
          itemBuilder: (_, index){
            return postUI(postList[index].image, postList[index].description, postList[index].date, postList[index].time);
          },
        ),
      ),
      bottomNavigationBar: new BottomAppBar(
        color: Colors.blue,
        child: new Container(
          margin: const EdgeInsets.only(left: 70.0, right: 70.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new IconButton(
                icon: new Icon(Icons.remove),
                iconSize: 50,
                color: Colors.white,
                onPressed: logOutUser,
              ),
              new IconButton(
                icon: new Icon(Icons.add_a_photo),
                iconSize: 50,
                color: Colors.white,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return new UploadPhoto();
                  }));
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget postUI(String image, String description, String date, String time) {
    return new Card(
      elevation: 10.0,
      margin: EdgeInsets.all(15.0),
      child: Container(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  date,
                  style: Theme.of(context).textTheme.subtitle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  time,
                  style: Theme.of(context).textTheme.subtitle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 10.0,),
            Image.network(image, fit: BoxFit.cover,),
            Text(
                  description,
                  style: Theme.of(context).textTheme.subhead,
                  textAlign: TextAlign.center,
                ),
          ],
        ),
      ),
    );
  }
}
