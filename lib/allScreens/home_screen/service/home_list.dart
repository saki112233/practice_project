import 'package:untitled9/allScreens/home_screen/service/post_service.dart';
import 'package:untitled9/model/api_model.dart';

class Bb{
 static List<Data> postList = [];

 static loadData()async{
   postList=await GetPostService().fetchData();
 }
 static addData(Data data){
   postList.add(data);
 }
 static removeData(int i){
   postList.removeAt(i);
 }
 static upDateData(int i,Data data){
   postList[i]=data;
 }
}