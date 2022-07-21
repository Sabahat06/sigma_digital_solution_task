import 'package:get/get.dart';
import 'package:sigma_digital_solution/model/popular_movie_model.dart';
import 'package:sigma_digital_solution/model/upcoming_movie_model.dart';
import 'package:sigma_digital_solution/services/http_service.dart';

class MovieController extends GetxController{
  RxInt currentTabIndex = 0.obs;
  RxBool popularMovieLoading = false.obs;
  RxBool upcomingMovieLoading = false.obs;
  PopularMoviesModel popularMovie = PopularMoviesModel();
  UpcomingMoviesModel upcomingMovie = UpcomingMoviesModel();
  List<String> movieCategory = ['Popular Movie', 'Upcoming Movie'];

  @override
  void onInit()  {
    loadPopularMovie();
    loadUpcomingMovie();
    super.onInit();
  }

  loadPopularMovie() async {
    popularMovieLoading.value = true;
    popularMovie = (await HttpService.getPopularMovies())!;
    popularMovieLoading.value = false;
  }

  loadUpcomingMovie() async {
    upcomingMovieLoading.value = true;
    upcomingMovie = (await HttpService.getUpcomingMovies())!;
    upcomingMovieLoading.value = false;
  }
}