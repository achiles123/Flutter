import 'package:flutter/material.dart';
import 'package:flutter_app/Model/Cinema.dart';
import 'package:geolocator/geolocator.dart';

class GlobalData{
  static Position locationPosition;
  static int locationId = -1;
  static final Map<int,String> locations = {
    0: "Hồ Chí Minh",
    1: "Hà Nội",
    2: "Đà Nẵng",
    3: "Hải Phòng",
    4: "Biên Hoà",
    5: "Nha Trang",
    6: "Bình Dương",
    7: "Phan Thiết",
    8: "Hạ Long",
    9: "Cần Thơ",
    10: "Vũng Tàu",
    11: "Quy Nhơn",
    12: "Huế",
    13: "Long Xuyên",
    14: "Thái Nguyên",
    15: "Buôn Ma Thuột",
    16: "Bắc Giang",
    17: "Bến Tre",
    18: "Việt Trì",
    19: "Ninh Bình",
    20: "Thái Bình",
    21: "Vinh",
    22: "Bảo Lộc",
    23: "Đà Lạt",
    24: "Trà Vinh",
    25: "Yên Bái",
    26: "Kiên Giang",
    27: "Vĩnh Long",
    28: "Cà Mau",
    29: "Hậu Giang",
    30: "Tây Ninh",
    31: "Tuyên Quang",
    32: "Thanh Hóa",
    33: "Nam Định",
    34: "Hải Dương",
    35: "Gia Lai",
    36: "Hà Tĩnh",
    37: "Phú Yên",
    38: "Bạc Liêu",
    39: "Long An",
    40: "Đồng Hới",
    41: "Hà Nam",
    42: "Bắc Ninh",
    43: "Quảng Trị",
    44: "Kon Tum",
  };

/*  static final Map<String,String> parentCinema = {
    "4":"BHD Star Cineplex",
    "2":"Galaxy Cinema",
    "16":"CineStar",
    "6":"DDC - Đống Đa",
    "17":"Mega GS",
    "1":"Lotte Cinema",
  };*/
  static final List<Cinema> parentCinema = [
    new Cinema(id: "4",name: "BHD Star Cineplex",shortName: "BHD",fetchName: "bhd",logo: "https://s3img.vcdn.vn/123phim/2018/09/f32670fd0eb083c9c4c804f0f3a252ed.png",color: Colors.green),
    new Cinema(id: "2",name: "Galaxy Cinema",shortName: "GLX",fetchName: "galaxy",logo: "https://s3img.vcdn.vn/123phim/2018/09/e520781386bd5436e94d6e15e193a005.png",color: Colors.orange),
    new Cinema(id: "16",name: "CineStar",shortName: "CNS",logo: "https://s3img.vcdn.vn/123phim/2018/09/1721cfa98768f300c03792e25ceb0191.png",color: Colors.purple),
    new Cinema(id: "6",name: "DDC - Đống Đa",shortName: "DDC",fetchName: "ddc",logo: "https://s3img.vcdn.vn/123phim/2018/09/9b240f96a233bb43203ee514a21a6004.png",color: Colors.grey),
    new Cinema(id: "17",name: "Mega GS",shortName: "MegaGS",fetchName: "megags",logo: "https://s3img.vcdn.vn/123phim/2018/09/7b078639bd8fdb09dd83652d207c7b90.png",color: Colors.amberAccent),
    new Cinema(id: "1",name: "Lotte Cinema",shortName: "Lotte",logo: "https://s3img.vcdn.vn/123phim/2018/09/404b8c4b80d77732e7426cdb7e24be20.png",color: Colors.red),
  ];

  static final Map<int,Color> seatColor = {
    0:Color(0xffcecece),
    3:Colors.black54,
    1:Colors.orangeAccent,
    12:Colors.transparent,
    11:Colors.transparent,
  };
}