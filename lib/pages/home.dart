import 'package:audio_player/controllers/player_controller.dart';
import 'package:audio_player/customs/custom_colors.dart';
import 'package:audio_player/customs/custom_text.dart';
import 'package:audio_player/pages/player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());

    return Scaffold(
      backgroundColor: bgDarkColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: bgDarkColor,
        leading: const Icon(
          Icons.sort_rounded,
          color: whiteColor,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: whiteColor,
              ))
        ],
        title: Text('Audio Player 1.0',
            style: OurStyle.ourStyle(
              size: 18,
            )),
      ),
      body: FutureBuilder<List<SongModel>>(
        future: controller.audioQuery.querySongs(
            ignoreCase: true,
            sortType: null,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL),
        builder: (BuildContext context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No Song Found...',
                style: OurStyle.ourStyle(),
              ),
            );
          } else {
            // ignore: avoid_print
            print(snapshot.data);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: Obx(
                      () => ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        tileColor: bgColor,
                        title: Text(
                          // ignore: unnecessary_string_interpolations
                          "${snapshot.data![index].displayNameWOExt}",
                          style: OurStyle.ourStyle(size: 15),
                        ),
                        subtitle: Text(
                          "${snapshot.data![index].artist}",
                          style: OurStyle2.ourStyle2(size: 12),
                        ),
                        leading: QueryArtworkWidget(
                          id: snapshot.data![index].id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: const Icon(
                            Icons.music_note,
                            color: whiteColor,
                            size: 32,
                          ),
                        ),
                        trailing: controller.playIndex.value == index &&
                                controller.isPlaying.value
                            ? const Icon(
                                Icons.play_arrow,
                                color: whiteColor,
                                size: 26,
                              )
                            : null,
                        onTap: () {
                          Get.to(Player(
                            data: snapshot.data!,
                          ));
                          controller.playSongs(
                              snapshot.data![index].uri, index);
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
