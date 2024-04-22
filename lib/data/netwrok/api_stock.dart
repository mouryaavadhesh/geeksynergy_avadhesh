
import 'dart:convert';

import 'package:geeksynergy_avadhesh/data/netwrok/dio_client.dart';
import 'package:geeksynergy_avadhesh/domain/entites/movie_req_model.dart';
import 'package:geeksynergy_avadhesh/utils/utils.dart';


extension ApiCall on DioClient {
  Future<dynamic> getMovieList({required RequestMovieModel requestMovieModel}) async {
   var response = await dio.post('movieList',data: jsonEncode(requestMovieModel.toMap()));
    switch (response.statusCode) {
      case 200:
        return response.data;
      default:
        Utils.normalPrint("$response");
    }
    return null;
  }
}
