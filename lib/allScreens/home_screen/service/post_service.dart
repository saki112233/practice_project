import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/api_model.dart';
import 'package:http/http.dart' as http;

class GetPostService {
  Future<List<Data>> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    List<Data> postList;
    try{
      var response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
      await prefs.setString("Data", response.body);
      String? data=prefs.getString("Data");
       postList = dataFromJson(data!);
    }catch(e){

      String? data=prefs.getString("Data");
      postList = dataFromJson(data!);
    }

    // var aa= dataFromJson(response.body);
    return postList;
  }
}
