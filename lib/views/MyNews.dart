import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontliners/models/MyNewsModel.dart';
import 'package:frontliners/statecontrollers/MyNews.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'Webview.dart';

class MyNewsView extends StatefulWidget {
  @override
  _MyNewsViewState createState() => _MyNewsViewState();
}

class _MyNewsViewState extends State<MyNewsView> {

  MyNews MyNewscontroller = Get.put(MyNews());

  @override
  Widget build(BuildContext context) {
    MyNewscontroller.getNews();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Headlines"),
        backgroundColor: Color(0xff1fbfb7),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GetBuilder<MyNews>(
          builder: (newsController){
            return newsController.newsLoaded ? LazyLoadScrollView(
              onEndOfPage: () => MyNewscontroller.getNews(),
              child: ListView.builder(
                 itemCount: newsController.myNews.articles.length,
                 itemBuilder: (context, index){
                  return HeadLineElement(article : newsController.myNews.articles[index]);
                 },
              ),
            ) : Center(
              child: Text("Loading..."),
            );
          },
        ),
      ),
    );
  }
}

class HeadLineElement extends StatelessWidget {

  final Article article;

  const HeadLineElement({
    Key key,@required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        onTap: (){
          var route = new MaterialPageRoute(
            builder: (BuildContext context) => new Webview(link: article.url),
          );
          Navigator.of(context).push(route);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.withOpacity(0.1)
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(article.title, style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15
                ),),
                SizedBox(
                  height: 15,
                ),
                CachedNetworkImage(
                    imageUrl: article.urlToImage.toString(),
                    errorWidget: (context, url, error) => SpinKitThreeBounce(
                      color: Color(0xff1fbfb7),
                      size: 60.0,
                    )
                ),
                SizedBox(
                  height: 10,
                ),
                Text(article.description),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
