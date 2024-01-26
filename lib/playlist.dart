import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'Components/custom_list.dart';

class playList extends StatefulWidget {
  const playList({Key? key}) : super(key: key);

  @override
  State<playList> createState() => _playListState();
}

class _playListState extends State<playList> {
  List musicList = [];
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  void searchSongsBySingerOrTitle(String singer) async {
    try {
      http.Response response = await http.post(
        Uri.parse('http://localhost:4000/api/musicsearch'),
        body: {'singer': singer, 'title':""}
      );

      if (response.statusCode == 200) {
        List songs = jsonDecode(response.body);
        setState(() {
          musicList = songs;
        });
      } else {
        print('Failed to search songs. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred while searching songs: $e');
    }
  }

  String currentCover = "";
  String currentSinger = "";
  String currentTitle = "";

  Duration duration = new Duration();
  Duration position = new Duration();

  IconData btnIcon = Icons.play_arrow;
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String currentSong = "";

  void playMusic(String link) async {
    if (isPlaying && currentSong != link) {
      audioPlayer.pause();
      await audioPlayer.play(link as Source);

      if (audioPlayer.play(link as Source) == PlayerState.playing) {
        setState(() {
          currentSong = link;
        });
      } else if (!isPlaying) {
        await audioPlayer.play(link as Source);
        if (audioPlayer.play(link as Source) == PlayerState.playing) {
          setState(() {
            isPlaying = true;
            btnIcon = Icons.play_arrow;
          });
        }
      }
      audioPlayer.onDurationChanged.listen((event) {
        setState(() {
          duration = event;
        });
      });
      audioPlayer.onPositionChanged.listen((event) {
        setState(() {
          position = event;
        });
      });
    }
  }

  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade800.withOpacity(0.9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          color: Colors.white,
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Row(
              children: [
                Text("Music Library"),
                IconButton(
                  icon: Icon(Icons.search, color: Colors.black),
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                ),
                Expanded(
                  child: isSearching
                      ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      controller: _searchController,
                      style: TextStyle(color: Colors.black),
                      onChanged: (value) {
                        String input = value;
                        debugPrint(input);
                        print(input);
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter artistName or song title',
                        border: InputBorder.none,
                      ),
                    ),
                  )
                      : Container(),
                ),
                if (isSearching)
                  IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      setState(() {
                        isSearching = false;
                        _searchController.clear();
                      });
                    },
                  ),
                ElevatedButton(
                  onPressed: () {
                    String input = _searchController.text;
                    print('hello $input');
                    searchSongsBySingerOrTitle(input);
                  },
                  child: Text('Submit', style: TextStyle(color: Colors.purple, fontSize: 20),),
                ),
              ],
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: musicList.length,
                itemBuilder: (context, index) => customListTile(
                    onTap: () {
                      setState(() {
                        currentCover = musicList[index]['cover'];
                        print(musicList[index]['cover']);
                        currentSinger = musicList[index]['artistName'];
                        currentTitle = musicList[index]['title'];
                      });
                    },
                    title: musicList[index]['title'],
                    artistName: musicList[index]['artistName'],
                    cover: musicList[index]['cover'])),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Color(0x55212121),
                blurRadius: 8.0,
              ),
            ]),
            child: Column(
              children: [
                Slider.adaptive(
                    value: position.inSeconds.toDouble(),
                    min: 0.0,
                    max: duration.inSeconds.toDouble(),
                    onChanged: (value) {}),
                Padding(
                    padding:
                        EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.only(bottom: 6.0, right: 6.0, left: 6.0),
                      height: 90.0,
                      width: 90.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          image: DecorationImage(
                            image: NetworkImage(currentCover),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentTitle,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black12,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                currentSinger,
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              )
            ],
          ),
          IconButton(
            onPressed: () {
              if (isPlaying) {
                audioPlayer.pause();
                setState(() {
                  btnIcon = Icons.pause;
                  isPlaying = false;
                });
              } else {
                audioPlayer.resume();
                setState(() {
                  btnIcon = Icons.play_arrow;
                  isPlaying = true;
                });
              }
            },
            iconSize: 50.0,
            icon: Icon(btnIcon),
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
