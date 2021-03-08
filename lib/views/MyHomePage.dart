import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontliners/widgets/Drawer.dart';
import 'MyNews.dart';
import 'Webview.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
        backgroundColor: Color(0xff1fbfb7),
      ),
      drawer: mainDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 30),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    new BoxShadow(
                      blurRadius: 6,
                      color: Colors.grey,
                      offset: new Offset(5.0, 5.0),
                    )
                  ],
                ),
                width: 180,
                height: 180,
                child: Image(
                  image: AssetImage('assets/images/frontliners_logo.png'),
                  alignment: Alignment.bottomCenter,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HomePageBoxElement(
                    icon:
                        Icon(Icons.update, color: Color(0xff1fbfb7), size: 50),
                    title: "Feed Updates",
                    action: () {}),
                HomePageBoxElement(
                    icon:
                        Icon(Icons.search, color: Color(0xff1fbfb7), size: 50),
                    title: "Search jobs",
                    action: () {})
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HomePageBoxElement(
                    icon: Icon(Icons.security,
                        color: Color(0xff1fbfb7), size: 50),
                    title: "My Safety",
                    action: () {}),
                HomePageBoxElement(
                    icon: Icon(Icons.description,
                        color: Color(0xff1fbfb7), size: 50),
                    title: "My news",
                    action: () {
                      var route = new MaterialPageRoute(
                        builder: (BuildContext context) => new MyNewsView(),
                      );
                      Navigator.of(context).push(route);
                    })
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xff1fbfb7),
        child: Icon(
          Icons.notifications,
          color: Colors.white,
        ),
      ),
    );
  }
}

class HomePageBoxElement extends StatelessWidget {
  final Icon icon;
  final String title;
  final Function action;

  const HomePageBoxElement({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        height: 135,
        width: 135,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              new BoxShadow(
                blurRadius: 6,
                color: Colors.grey,
                offset: new Offset(5.0, 5.0),
              )
            ]),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: icon,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title),
              )
            ],
          ),
        ),
      ),
    );
  }
}
