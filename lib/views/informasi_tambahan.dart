import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

TextStyle titleFont =
    const TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0);

TextStyle infoFont =
    const TextStyle(fontWeight: FontWeight.w400, fontSize: 18.0);

Widget informasiTambahan(
    String angin, String tekananUdara, String kelembaban, String dirasakan) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(18.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Angin",
                  style: titleFont,
                ),
                SizedBox(
                  height: 18.0,
                ),
                Text(
                  "Tekanan Udara",
                  style: titleFont,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$angin",
                  style: infoFont,
                ),
                SizedBox(
                  height: 18.0,
                ),
                Text(
                  "$tekananUdara",
                  style: infoFont,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Kelembaban",
                  style: titleFont,
                ),
                SizedBox(
                  height: 18.0,
                ),
                Text(
                  "Dirasakan",
                  style: titleFont,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$kelembaban",
                  style: infoFont,
                ),
                SizedBox(
                  height: 18.0,
                ),
                Text(
                  "$dirasakan",
                  style: infoFont,
                ),
              ],
            ),
          ],
        )
      ],
    ),
  );
}
