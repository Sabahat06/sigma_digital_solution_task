import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma_digital_solution/model/video_data.dart';
import 'package:sigma_digital_solution/services/http_service.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';


class MovieVideo extends StatefulWidget {
  String movieID;
  MovieVideo({required this.movieID});
  @override
  _MovieVideoState createState() => _MovieVideoState();
}

class _MovieVideoState extends State<MovieVideo> {
  late YoutubePlayerController _controller;
  VideoDataModel? videoData;
  RxBool isProgressing = false.obs;

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void initState() {
    super.initState();
    getVideoData();
  }

  getVideoData() async {
    isProgressing.value = true;
    videoData = await HttpService.playVideo(widget.movieID);
    isProgressing.value = false;
    _controller = YoutubePlayerController(
      initialVideoId: videoData!.results!.first.key!,
      params: const YoutubePlayerParams(
        loop: true,
        color: 'transparent',
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => isProgressing.value ? const Center(child: CircularProgressIndicator(),) : YoutubePlayerControllerProvider(
          controller: _controller,
          child: YoutubePlayerIFrame(
            controller: _controller,
          )
        ),
      ),
    );
  }
}