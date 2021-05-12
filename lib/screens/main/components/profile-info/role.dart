import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RolePhoto extends StatelessWidget {
  final String role;
  final double imageSize;
  RolePhoto({this.role, this.imageSize});
  @override
  Widget build(BuildContext context) {
    var roleSvg;
    switch (this.role) {
      case "creater":
        roleSvg = 'assets/svg/tinyCreater.svg';
        break;
      case "learner":
        roleSvg = 'assets/svg/tinyLearner.svg';
        break;
      default:
        roleSvg = 'assets/svg/tinyUser.svg';
    }
    return Positioned(
      top: this.imageSize * 0.75,
      left: this.imageSize * 0.75,
      child: Stack(
        children: [
          Container(
            width: this.imageSize * 0.20,
            height: this.imageSize * 0.20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 1,
              ),
              color: Color(0xffef508b),
            ),
            child: Container(
              width: this.imageSize * 0.22,
              height: this.imageSize * 0.22,
              margin: EdgeInsets.all(this.imageSize * 0.033),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(this.imageSize * 0.11),
              ),
              child: SvgPicture.asset(roleSvg, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
