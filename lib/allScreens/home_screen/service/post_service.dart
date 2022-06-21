import '../../../model/api_model.dart';
import 'package:http/http.dart' as http;

class GetPostService {
  Future<List<Data>> fetchData() async {
    var response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    List<Data> postApiList =
        dataFromJson(response.body);
    return postApiList;
  }
}
