import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sigma_digital_solution/controller/movie_controller.dart';
import 'package:sigma_digital_solution/controller/movie_detail_controller.dart';
import 'package:sigma_digital_solution/controller/my_google_map_controller.dart';
import 'package:sigma_digital_solution/view/my_google_map.dart';
import 'package:sigma_digital_solution/view/popular_movie_tab.dart';
import 'package:sigma_digital_solution/view/upcoming_movie_tab.dart';

class MovieScreenTabs extends StatelessWidget {
  MovieDetailController movieDetailController = Get.put(MovieDetailController());
  MovieController movieController = Get.find();
  MyGoogleMapController myGoogleMapController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DefaultTabController(
        initialIndex: movieController.currentTabIndex.value,
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(icon: const Icon(Icons.arrow_back, size: 0, color: Colors.white), onPressed: () {},),
            leadingWidth: 0,
            title: Obx(
              () => GestureDetector(
                onTap: () {Get.to(() => CurrentLocationScreen());},
                child: myGoogleMapController.userAddress.value == ''
                  ? const Icon(Icons.location_on, color: Colors.white)
                  : Container(width: 70.w, child: Text(myGoogleMapController.userAddress.value, style: TextStyle(fontSize: 15.sp),)),
              ),
            ),
            actions: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Get.to(() => CurrentLocationScreen());
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 15.sp, right: 15.sp),
                      child: const Icon(Icons.notifications, color: Colors.white,),
                    )
                  ),
                ]
              )
            ],
            bottom: TabBar(
              onTap: (index) {
                movieController.currentTabIndex.value = index;
              },
              isScrollable: true,
              indicatorColor: Colors.white,
              indicatorWeight: 3.0,
              tabs: movieController.movieCategory.map(
                (movieCategory) => Tab(
                  child: Text(
                    movieCategory,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ).toList(),
            ),
          ),
          body: TabBarView(
            children: getTabBarViews(movieController.movieCategory),
          ),
        ),
      ),
    );
  }

  List<Widget> getTabBarViews(List movieCategory) {
    List<Widget> tab_bar_views = [];
    if (movieCategory.contains("Popular Movie")) {
      tab_bar_views.add(PopularMovieTab());
    }
    if (movieCategory.contains("Upcoming Movie")) {
      tab_bar_views.add(UpcomingMovieTab());
    }

    return tab_bar_views;
  }

}
