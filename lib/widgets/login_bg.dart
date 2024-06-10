import 'package:flutter/material.dart';
import 'MyCliper.dart';

class LoginBg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 5,
            right: 0,
            child: RotatedBox(
              quarterTurns: 2,
              child: ClipPath(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topRight,
                      stops: [0.0, 1.0],
                      colors: <Color>[
                        Colors.blue[100]!,
                        Colors.cyan[100]!,
                      ],
                    ),
                  ),
                  height: 210,
                  width: MediaQuery.of(context).size.width,
                ),
                clipper: MyCliper(),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: RotatedBox(
              quarterTurns: 2,
              child: ClipPath(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topRight,
                      stops: [0.0, 1.0],
                      colors: <Color>[
                        Colors.blue,
                        Colors.cyan,
                      ],
                    ),
                  ),
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                ),
                clipper: MyCliper(),
              ),
            ),
          ),
          Positioned(
            top: 5,
            child: ClipPath(
              child: Container(
                height: 210,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.topLeft,
                    stops: [0.0, 1.0],
                    colors: <Color>[
                      Colors.deepOrange[100]!,
                      Colors.orangeAccent[100]!,
                    ],
                  ),
                ),
                width: MediaQuery.of(context).size.width,
              ),
              clipper: MyCliper(),
            ),
          ),
          Positioned(
            child: ClipPath(
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.topLeft,
                    stops: [0.0, 1.0],
                    colors: <Color>[
                      Colors.deepOrange,
                      Colors.orangeAccent,
                    ],
                  ),
                ),
                width: MediaQuery.of(context).size.width,
              ),
              clipper: MyCliper(),
            ),
          ),
        ],
      ),
    );
  }
}
