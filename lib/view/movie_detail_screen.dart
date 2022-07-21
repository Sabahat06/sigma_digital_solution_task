import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sigma_digital_solution/controller/movie_detail_controller.dart';
import 'package:sigma_digital_solution/view/movie_video.dart';

class MovieDetailScreen extends StatelessWidget {
  MovieDetailScreen();
  MovieDetailController movieDetailController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1f1c2f),
      appBar: AppBar(title: Text('Movie Detail', style: TextStyle(fontSize: 18.sp, color: Colors.white, fontWeight: FontWeight.w500),),),
      body: Obx(
        () => movieDetailController.isProgressing.value
          ? const Center(child: CircularProgressIndicator(),)
          : Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 25.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('https://image.tmdb.org/t/p/w500/${movieDetailController.movieDetailModel.posterPath}'),
                            fit: BoxFit.cover
                          )
                        ),
                      ),
                      Positioned(
                        top: 20.sp,
                        left: 20.sp,
                        child: Container(
                          height: 18.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.sp),
                            image: DecorationImage(
                              image: NetworkImage('https://image.tmdb.org/t/p/w500/${movieDetailController.movieDetailModel.backdropPath}'),
                              fit: BoxFit.cover
                            )
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20.sp,),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${movieDetailController.movieDetailModel.title!} ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp, color: Colors.white),),
                        Text("(${movieDetailController.movieDetailModel.releaseDate!.substring(0, 4)})", style: TextStyle(fontSize: 16.sp, color: Colors.white54),)
                      ],
                    ),
                  ),
                  SizedBox(height: 25.sp,),
                  Row(
                    children: [
                      Container(
                        width: 45.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                CircularProgressIndicator(
                                  value: 0.7,
                                  strokeWidth: 5,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                                ),
                                Text("70%", style: TextStyle(fontSize: 15.sp, color: Colors.white),),
                              ],
                            ),
                            SizedBox(width: 15.sp,),
                            Text("User Score", style: TextStyle(fontSize: 16.sp, color: Colors.white),),
                          ],
                        ),
                      ),
                      Container(width: 0.5.w, color: Colors.white, height: 3.5.h,),
                      GestureDetector(
                        onTap: () {Get.to(() => MovieVideo());},
                        child: Container(
                          width: 45.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.play_arrow_sharp, size: 22.sp, color: Colors.white,),
                              SizedBox(width: 15.sp,),
                              Text("Play Trailer", style: TextStyle(fontSize: 16.sp, color: Colors.white),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.sp,),
                  Container(
                    width: double.infinity,
                    color: Color(0xff1d1c31),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(movieDetailController.movieDetailModel.releaseDate!, style: TextStyle(fontSize: 16.sp, color: Colors.white, ),),
                        SizedBox(height: 10.sp,),
                        Container(
                          width: 90.w,
                          height: 5.h,
                          child: Center(
                            child: ListView.separated(
                              itemCount: movieDetailController.movieDetailModel.genres!.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Text(movieDetailController.movieDetailModel.genres![index].name!, style: TextStyle(fontSize: 16.sp, color: Colors.white,), textAlign: TextAlign.center,);
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return Text(', ', style: TextStyle(fontSize: 16.sp, color: Colors.white,),);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.sp,),
                  Text(movieDetailController.movieDetailModel.tagline!, style: TextStyle(color: Colors.white54, fontSize: 16.sp),),
                  SizedBox(height: 10.sp,),
                  Text("Overview", style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),),
                  SizedBox(height: 10.sp,),
                  Text(movieDetailController.movieDetailModel.overview!, style: TextStyle(color: Colors.white, fontSize: 16.sp), textAlign: TextAlign.justify,),
                ],
              ),
            ),
          )
      ),
    );
  }
}
