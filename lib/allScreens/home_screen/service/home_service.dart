import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled9/allProvider/state_provider.dart';
import 'package:untitled9/allScreens/home_screen/service/post_service.dart';
import 'package:untitled9/model/api_model.dart';

class HomeNotifier extends StateNotifier<List<Data>>{
  HomeNotifier():super([]);
  loadData()async{

    state=await GetPostService().fetchData();
  }
}
final homeState=StateNotifierProvider<HomeNotifier,List<Data>>((ref) {
  return HomeNotifier();
} );