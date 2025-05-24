import 'dart:convert';

import 'package:bazaartech/core/service/media_query.dart';
import 'package:flutter/material.dart';

Widget buildReviewImage(String profilePhoto) {
  return CircleAvatar(
    backgroundImage: isBase64(profilePhoto)
        ? MemoryImage(base64Decode(profilePhoto))
        : AssetImage(profilePhoto) as ImageProvider,
    radius: MediaQueryUtil.screenWidth / 20.6,
  );
}

bool isBase64(String str) {
  return str.length > 100 && !str.contains('assets/');
}
