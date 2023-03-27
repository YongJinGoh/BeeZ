import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';

class BottomBar extends StatelessWidget {

  BottomBar();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(25),
        color: Colors.red,
        child: Column(
          children: [
            Text(
              "Test",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildIconText(
                  Icons.access_time_outlined,
                  Colors.blue,
                  "10",
                ),
                _buildIconText(
                  Icons.star_outlined,
                  Colors.amber,
                  "10",
                ),
                _buildIconText(
                  Icons.local_fire_department_outlined,
                  Colors.red,
                  "10",
                ),
              ],
            ),
            SizedBox(
              height: 39,
            ),
            SizedBox(
              height: 39,
            ),
            Row(
              children: [
                Text(
                  'Ingredienta',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                )
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: 100,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Column(
                      children: [
                        Image.asset("10",
                            width: 52),
                        Text("10"),
                      ],
                    ),
                  ),
                  separatorBuilder: (_, index) => SizedBox(
                    width: 15,
                  ),
                  itemCount: 1),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Text(
                  'About',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "10",
              style: TextStyle(fontSize: 16, wordSpacing: 1.2, height: 1.5),
            ),
            SizedBox(height: 20),
          ],
        ));
  }

  _buildIconText(IconData icon, Color color, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
