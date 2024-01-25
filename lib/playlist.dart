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
  List musiclist = [
    <String, String>{
      'title': 'leg over',
      'singer': 'Hanse Manfred',
      'url':
          'https://soundcloud.com/alexanderkowalski/alexander-kowalski-rising-tides-link-audio-previews?utm_source=clipboard&utm_medium=text&utm_campaign=social_sharing',
      'coverUrl':
          'https://frenchly.us/wp-content/uploads/2017/10/billboard-e1507642142421.jpg'
    },
    {
      'title': 'papa',
      'singer': 'Dadju',
      'url':
          'https://assets.mixkit.co/music/preview/mixkit-sun-and-his-daughter-580.json',
      'coverUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEl9YAlqY_qGHZikf2lIfqnv1h4R0skV9W8Btk2SemI_fHOOa-1KCvPHAMSCmyE_atMUs&usqp=CAU'
    },
    {
      'title': 'son_and_his_daughter',
      'singer': 'Williams Dav',
      'url':
          'https://assets.mixkit.co/music/preview/mixkit-sun-and-his-daughter-580.json',
      'coverUrl':
          'https://www.worcestermag.com/gcdn/presto/2023/03/17/NTEG/4e906c76-fae9-4a78-8440-203ae83f27f0-SarahFrench.jpg?crop=659,371,x0,y309&width=659&height=371&format=pjpg&auto=webp'
    },
    {
      'title': 'son_and_his_daughter',
      'singer': 'Williams Dav',
      'url':
          'https://assets.mixkit.co/music/preview/mixkit-sun-and-his-daughter-580.json',
      'coverUrl':
          'data:image/jpeg;base64,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'
    },
    {
      'title': 'son_and_his_daughter',
      'singer': 'Williams Dav',
      'url':
          'https://assets.mixkit.co/music/preview/mixkit-sun-and-his-daughter-580.json',
      'coverUrl':
          'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.gettyimages.com%2Fphotos%2Fmusian&psig=AOvVaw0r_KbY0R0w_qWDMpNP6Wi1&ust=1706086874041000&source=images&cd=vfe&opi=89978449&ved=0CBMQjRxqFwoTCPCwiouT84MDFQAAAAAdAAAAABAQ'
    },
    {
      'title': 'son_and_his_daughter',
      'singer': 'Williams Dav',
      'url':
          'https://assets.mixkit.co/music/preview/mixkit-sun-and-his-daughter-580.json',
      'coverUrl':
          'https://evasion.bf/wp-content/uploads/2022/10/Armel-Bent-Dadju.jpg'
    },
    {
      'title': 'son_and_his_daughter',
      'singer': 'Williams Dav',
      'url':
          'https://assets.mixkit.co/music/preview/mixkit-sun-and-his-daughter-580.json',
      'coverUrl': 'https://i.ytimg.com/vi/IkRpPTrVuAw/sddefault.jpg'
    },
    {
      'title': 'son_and_his_daughter',
      'singer': 'Williams Dav',
      'url':
          'https://assets.mixkit.co/music/preview/mixkit-sun-and-his-daughter-580.json',
      'coverUrl':
          'data:image/jpeg;base64,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'
    },
    {
      'title': 'son_and_his_daughter',
      'singer': 'Williams Dav',
      'url':
          'https://assets.mixkit.co/music/preview/mixkit-sun-and-his-daughter-580.json',
      'coverUrl':
          'https://c8.alamy.com/comp/AYC4B0/musican-palermo-sicily-AYC4B0.jpg'
    },
    {
      'title': 'son_and_his_daughter',
      'singer': 'Williams Dav',
      'url':
          'https://assets.mixkit.co/music/preview/mixkit-sun-and-his-daughter-580.json',
      'coverUrl':
          'https://frenchcrazy.com/wp-content/uploads/2016/03/frenchmusic.jpg'
    },
    {
      'title': 'son_and_his_daughter',
      'singer': 'Williams Dav',
      'url':
          'https://assets.mixkit.co/music/preview/mixkit-sun-and-his-daughter-580.json',
      'coverUrl':
          'https://img.freepik.com/premium-photo/musian-with-bands-hd-8k-wallpaper-background-stock-photographic-image_915071-59681.jpg'
    },
    {
      'title': 'son_and_his_daughter',
      'singer': 'Williams Dav',
      'url':
          'https://assets.mixkit.co/music/preview/mixkit-sun-and-his-daughter-580.json',
      'coverUrl':
          'https://media.gettyimages.com/id/73054407/photo/friedrichshafen-germany-musian-peter-maffay-performs-during-the-live-broadcast-of-wetten-dass.jpg?s=612x612&w=gi&k=20&c=9_31e1E9qQkMI525pFTB_JKS9EkqnCtlBpHRAZo7STg='
    },
  ];

  String currentCover = "";
  String currentSinger = "";
  String currentTitle = "";

  Duration duration = new Duration();
  Duration position = new Duration();

  IconData btnIcon = Icons.play_arrow;
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String currentSong = "";

  void playMusic(String url) async {
    if (isPlaying && currentSong != url) {
      audioPlayer.pause();
      await audioPlayer.play(url as Source);

      if (audioPlayer.play(url as Source) == PlayerState.playing) {
        setState(() {
          currentSong = url;
        });
      } else if (!isPlaying) {
        await audioPlayer.play(url as Source);
        if (audioPlayer.play(url as Source) == PlayerState.playing) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'My Playlist',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: musiclist.length,
                itemBuilder: (context, index) => customListTile(
                    onTap: () {
                      setState(() {
                        currentCover = musiclist[index]['coverUrl'];
                        currentSinger = musiclist[index]['singer'];
                        currentTitle = musiclist[index]['title'];
                      });
                    },
                    title: musiclist[index]['title'],
                    singer: musiclist[index]['singer'],
                    cover: musiclist[index]['coverUrl'])),
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
