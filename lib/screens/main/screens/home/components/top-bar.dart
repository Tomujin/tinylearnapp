import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tiny/theme/style.dart';

const assetName = 'assets/svg/tiny_name_logo.svg';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Container(
        child: SvgPicture.asset(
          assetName,
        ),
        padding: EdgeInsets.only(left: mainSpace, top: 5, right: mainSpace),
      ),
      leadingWidth: 100,
      title: Container(
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Daily Goal',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  height: 1.4,
                ),
              ),
              Container(
                width: 150,
                height: 16,
                padding: EdgeInsets.only(top: 3),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: LinearProgressIndicator(
                    value: 0.7,
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(Color(0xffef508b)),
                    backgroundColor: Color(0xffD6D6D6),
                  ),
                ),
              )
            ],
          ),
        ]),
      ),
      titleSpacing: 8.0, // Spacing for title
      centerTitle: true,
      actions: [
        Container(
          padding: EdgeInsets.only(top: 17, bottom: 13),
          width: 25,
          child: CircularProgressIndicator(
            value: 0.30,
            backgroundColor: Colors.black12,
            valueColor:
                new AlwaysStoppedAnimation(Theme.of(context).primaryColor),
            strokeWidth: 10,
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: 15, top: 22, left: 12),
          child: Text(
            '1%',
            style:
                TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),
          ),
        )
      ],
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
