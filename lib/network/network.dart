import 'package:flutter_bloc_demo/network/resource.dart';
import 'package:dio/dio.dart';

class Network<T>{
  final dio = Dio();
  final String URL = "https://dummyjson.com/";

  Future<Resource<T>> get(String endpoint, T payload) async {
    final response = await dio.get(URL+endpoint+payload.toString());
    switch(response.statusCode){
      case 200 : {
        return Future.value(Resource(Status.SUCCESS, response.statusMessage, response.data));
      }
      default : {
        return Future.error(Resource(Status.ERROR, response.statusMessage, response.data));
      }

    }
  }

  Future<Resource<T>> post(String endpoint, T payload) async {
    final response = await dio.post(URL+endpoint, data : payload);
    switch(response.statusCode){
      case 200 : {
        return Future.value(Resource(Status.SUCCESS, response.statusMessage, response.data));
      }
      default : {
        return Future.error(Resource(Status.ERROR, response.statusMessage, response.data));
      }

    }
  }

}