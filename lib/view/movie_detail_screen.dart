import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sigma_digital_solution/controller/movie_detail_controller.dart';
import 'package:sigma_digital_solution/model/video_data.dart';
import 'package:sigma_digital_solution/services/http_service.dart';
import 'package:sigma_digital_solution/view/movie_video.dart';

class MovieDetailScreen extends StatelessWidget {
  MovieDetailScreen();
  MovieDetailController movieDetailController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff1f1c2f),
        body: Obx(() => movieDetailController.isProgressing.value
          ? const Center(child: CircularProgressIndicator(),)
          : CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: false,
                snap: false,
                floating: false,
                expandedHeight: 60.h,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    height: 60.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://image.tmdb.org/t/p/w500/${movieDetailController.movieDetailModel.posterPath}'),
                        fit: BoxFit.cover
                      )
                    ),
                  )
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15.sp,),
                            Container(
                              child: Center(
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp, color: Colors.white),
                                    children: [
                                      TextSpan(text: "${movieDetailController.movieDetailModel.title!} "),
                                      TextSpan(text: "(${movieDetailController.movieDetailModel.releaseDate!.substring(0, 4)})", style: TextStyle(fontSize: 16.sp, color: Colors.white54),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 25.sp,),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 42.w,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              CircularProgressIndicator(
                                                value: movieDetailController.movieDetailModel.voteAverage!/10,
                                                strokeWidth: 4,
                                                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                                              ),
                                              Text("${(movieDetailController.movieDetailModel.voteAverage!*10).toStringAsFixed(0)}", style: TextStyle(fontSize: 15.sp, color: Colors.white),),
                                            ],
                                          ),
                                          SizedBox(width: 15.sp,),
                                          Text("User Score", style: TextStyle(fontSize: 16.sp, color: Colors.white),),
                                        ],
                                      ),
                                    ),
                                    Container(width: 0.5.w, color: Colors.white, height: 3.5.h,),
                                    GestureDetector(
                                      onTap: () async {
                                        Get.to(() => MovieVideo(movieID: movieDetailController.movieDetailModel.id!.toString(),));
                                      },
                                      child: Container(
                                        width: 42.w,
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
                              ),
                            ),
                            SizedBox(height: 20.sp,),
                            Container(
                              width: double.infinity,
                              color: Color(0xff1d1c31),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("${movieDetailController.movieDetailModel.releaseDate!} (${movieDetailController.movieDetailModel.originalLanguage!})", style: TextStyle(fontSize: 16.sp, color: Colors.white, ),),
                                      Text(' . ', style: TextStyle(fontSize: 16.sp, color: Colors.white, ),),
                                      Text("${movieDetailController.movieDetailModel.runtime!} minutes", style: TextStyle(fontSize: 16.sp, color: Colors.white, ),),
                                    ],
                                  ),
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
                            Text(movieDetailController.movieDetailModel.tagline!, style: TextStyle(color: Colors.white54, fontSize: 17.sp),),
                            SizedBox(height: 10.sp,),
                            Text("Overview", style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),),
                            SizedBox(height: 10.sp,),
                            Text(movieDetailController.movieDetailModel.overview!, style: TextStyle(color: Colors.white, fontSize: 16.sp), textAlign: TextAlign.justify,),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: 1,
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
