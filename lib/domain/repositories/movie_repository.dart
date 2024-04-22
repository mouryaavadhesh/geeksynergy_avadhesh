


import 'package:geeksynergy_avadhesh/data/netwrok/api_stock.dart';
import 'package:geeksynergy_avadhesh/domain/entites/movie_req_model.dart';
import 'package:geeksynergy_avadhesh/domain/entites/movie_response_model.dart';
import 'package:geeksynergy_avadhesh/utils/base/app_instance.dart';
import 'package:geeksynergy_avadhesh/utils/base/repo_response.dart';
import 'package:geeksynergy_avadhesh/utils/enums/data.dart';
import 'package:geeksynergy_avadhesh/utils/utils.dart';

class MovieRepo {
  Future<RepoResponse<MovieResponseModel>> getMovieLIst(RequestMovieModel requestMovieModel) async {
    try {
      return await AppInstance().getApiInstance.getMovieList(requestMovieModel: requestMovieModel).then((value) {
        if (value != null) {
          return SuccessResponse(MovieResponseModel.fromJson(value));
        } else {
          return FailedResponse(DataErrorState.noData);
        }
      });
    } catch (exception, stackTrace) {
      Utils.captureException(exception, stackTrace);
      return FailedResponse(DataErrorState.exception);
    }
  }

}
