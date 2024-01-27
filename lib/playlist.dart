import 'package:flutter/material.dart';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'Components/custom_list.dart';
import 'package:audioplayers/audioplayers.dart';

import 'Source.dart';
class playList extends StatefulWidget {
  const playList({Key? key}) : super(key: key);

  @override
  State<playList> createState() => _playListState();
}

class _playListState extends State<playList> {
  List musicList = [];
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String currentSongLink = '';

  void playMusic( String link) async{
    if(isPlaying && currentSongLink != link){
       await audioPlayer.pause();
    }else if (isPlaying){
      await audioPlayer.play(link as Source);
      setState(() {
        isPlaying= true;
      });
    }
  }
  void searchSongsBySingerOrTitle(String singer) async {
    try {
      http.Response response = await http.post(
          Uri.parse('http://localhost:4000/api/musicsearch'),
          body: {'singer': singer, 'title': ""});

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

  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
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
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.purple, fontSize: 20),
                  ),
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
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor:  Colors.deepPurple.shade800.withOpacity(0.9),
                        contentPadding: EdgeInsets.all(16),
                        content: Container(
                          width: 300, // Set the desired width for the dialog
                          height: 400, // Set the desired height for the dialog
                          child: Column(
                            children: [
                              Text(musicList[index]['title']),
                              SizedBox(height: 16),
                              Text('Artist: ${musicList[index]['artistName']}'),
                              SizedBox(height: 8),
                              Container(
                                height: 200, // Set the desired height for the image
                                child: Image.network(
                                  musicList[index]['cover'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 16),
                              Slider(
                                value: 0.5, // Set the current seek value
                                min: 0.0, // Set the minimum value
                                max: 1.0, // Set the maximum value
                                onChanged: (double value) {
                                  // Seek bar logic
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // Play button logic
                                    },
                                    child: Icon(
                                      Icons.skip_previous,
                                      size: 48,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 32),
                                  InkWell(
                                  onTap: () async {
                                    playMusic(musicList[index]['link']);
                                    },
                                    child: Icon(
                                      Icons.play_arrow,
                                      size: 48,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 32),
                                  InkWell(
                                    onTap: () {
                                      // Next button logic
                                    },
                                    child: Icon(
                                      Icons.skip_next,
                                      size: 48,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Close', style: TextStyle(color: Colors.white),),
                          ),
                        ],
                      );
                    },
                  );
                },
                title: musicList[index]['title'],
                artistName: musicList[index]['artistName'],
                cover: musicList[index]['cover'],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x55212121),
                  blurRadius: 8.0,
                ),
              ],
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Background Text',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Column(
                  children: [
                    // Add other music details or controls here.
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}