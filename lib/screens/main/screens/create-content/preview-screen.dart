import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import './asset_image.dart';

class PreviewPage extends StatelessWidget {
  final List<AssetEntity> list;

  const PreviewPage({Key key, this.list = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: list.length == 0 ? 1 : list.length,
        onPageChanged: (currentIndex) {
          // setState(() {
          //   this.pageViewActiveIndex = currentIndex;
          // });
        },
        itemBuilder: (BuildContext context, int index) {
          if (list.length == 0)
            return Center(
                child: Text(
              'Open gallery for select items',
              style: TextStyle(fontSize: 18),
            ));
          else
            return Container(
                padding: EdgeInsets.only(top: 20),
                child: AssetImageWidget(
                  assetEntity: list[index],
                  width: 300,
                  height: 200,
                  boxFit: BoxFit.cover,
                ));
        },
      ),
    );
  }
}
