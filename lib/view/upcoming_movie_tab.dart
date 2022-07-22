import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sigma_digital_solution/controller/movie_controller.dart';
import 'package:sigma_digital_solution/controller/movie_detail_controller.dart';
import 'package:sigma_digital_solution/model/upcoming_movie_model.dart';
import 'package:sigma_digital_solution/view/movie_detail_screen.dart';

class UpcomingMovieTab extends StatelessWidget {
  MovieController movieController = Get.find();
  MovieDetailController movieDetailController = Get.find();
  UpcomingMovieTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: Obx(
        () => movieController.upcomingMovieLoading.value
          ? const Center(child: CircularProgressIndicator(),)
          : ListView.builder(
            itemCount: movieController.upcomingMovie.results!.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return renderingMovie(movieController.upcomingMovie.results![index]);
            }
          ),
      ),
    );
  }

  renderingMovie(Results movie) {
    return GestureDetector(
      onTap: () {
        movieDetailController.loadMovieDetails(movie.id.toString());
        Get.to(() => MovieDetailScreen());
      },
      child: Container(
        height: 20.h,
        width: double.infinity,
        child: Card(
          color: Colors.white,
          elevation: 2,
          child: Row(
            children: [
              Container(
                height: 100.h,
                width: 25.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://image.tmdb.org/t/p/w500/${movie.posterPath}'),
                    fit: BoxFit.cover
                  )
                )
              ),
              SizedBox(width: 15.sp,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 60.w, child: Text(movie.title!, style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis, maxLines: 1,)),
                  SizedBox(height: 10.sp,),
                  Text(movie.releaseDate!, style: TextStyle(fontSize: 16.sp, color: Colors.black38),),
                  SizedBox(height: 12.sp,),
                  Container(
                    height: 10.h,
                    width: 60.w,
                    child: Text(movie.overview!,
                      style: TextStyle(fontSize: 16.sp),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      textAlign: TextAlign.justify,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
