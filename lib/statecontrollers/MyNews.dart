import 'dart:convert';

import 'package:frontliners/models/MyNewsModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class MyNews extends GetxController{

  bool newsLoaded = false;
  MyNewsModel myNews = new MyNewsModel();
  int page = 0;


  getNews() async{
    try {
      if(page>100){
        page = 100;
        update();
      }
      if(page<=100){
        page++;
        newsLoaded = false;
        var client = http.Client();
        final response = await client.get("http://newsapi.org/v2/everything?q=doctor&page=$page&apiKey=76dc3fcd11e246a89064157411ec33b1");
        myNews = MyNewsModel.fromJson(jsonDecode(response.body));
        newsLoaded = true;
        update();
      }
    } catch (e) {
      print(e);
    }
  }

}