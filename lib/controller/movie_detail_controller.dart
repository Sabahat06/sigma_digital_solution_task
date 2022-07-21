import 'package:get/get.dart';
import 'package:sigma_digital_solution/model/movie_detail_model.dart';
import 'package:sigma_digital_solution/services/http_service.dart';

class MovieDetailController extends GetxController {
  RxBool isProgressing = false.obs;
  MovieDetailModel movieDetailModel = MovieDetailModel();

  loadMovieDetails(String movieId) async {
    isProgressing.value = true;
    movieDetailModel = (await HttpService.getMovieDetail(movieId))!;
    if(movieDetailModel.video!){print("sad asd asdf asfd asfd asdf ${movieDetailModel.id}");}
    isProgressing.value = false;
  }
}