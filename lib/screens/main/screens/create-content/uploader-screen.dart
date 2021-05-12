import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
// import 'package:photo/photo.dart';
import 'package:tiny/components/grey100-appbar.dart';
import 'package:tiny/functions/pushToScreen.dart';
import 'package:tiny/screens/main/screens/create-content/create-quiz-screen.dart';
import 'package:tiny/screens/main/screens/create-content/preview-screen.dart';

class UploaderScreen extends StatefulWidget {
  @override
  _UploaderScreenState createState() => _UploaderScreenState();
}

class _UploaderScreenState extends State<UploaderScreen> {
  List<AssetEntity> preview = [];
  String currentSelected = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: grey100AppBar(
          title: 'Upload content',
          doOnPress: () => pushToScreen(context, CreateQuizScreen())),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 300,
              child: Flexible(
                  child: PreviewPage(
                list: preview,
              )),
            ),
            Expanded(
              child: Text(''),
            ),
            SizedBox(
              width: 150,
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30)),
                onPressed: () => {
                  // _pickAsset(PickType.all, context)
                },
                child: Text('Open gallery'),
              ),
            ),
            Expanded(
              child: Text(''),
            ),
          ],
        ),
      ),
    );
  }

  // void _pickAsset(PickType type, BuildContext context,
  //     {List<AssetPathEntity> pathList}) async {
  //   /// context is required, other params is optional.

  //   //PhotoPicker.clearThumbMemoryCache();

  //   List<AssetEntity> imgList = await PhotoPicker.pickAsset(
  //     // BuildContext required
  //     context: context,

  //     //For picked item
  //     pickedAssetList: preview,

  //     /// The following are optional parameters.
  //     themeColor: lightPurple,
  //     // the title color and bottom color

  //     textColor: Colors.white,
  //     // text color
  //     padding: 1.0,
  //     // item padding
  //     dividerColor: Colors.grey,
  //     // divider color
  //     disableColor: Colors.grey.shade300,
  //     // the check box disable color
  //     itemRadio: 0.88,
  //     // the content item radio
  //     maxSelected: 15,
  //     // max picker image count
  //     // provider: I18nProvider.english,
  //     provider: I18nProvider.english,
  //     // i18n provider ,default is chinese. , you can custom I18nProvider or use ENProvider()
  //     rowCount: 3,
  //     // item row count

  //     thumbSize: 150,
  //     // preview thumb size , default is 64
  //     sortDelegate: SortDelegate.common,
  //     // default is common ,or you make custom delegate to sort your gallery
  //     // checkBoxBuilderDelegate: DefaultCheckBoxBuilderDelegate(
  //     //   activeColor: Colors.white,
  //     //   unselectedColor: Colors.white,
  //     //   checkColor: lightPurple,
  //     // ),
  //     // default is DefaultCheckBoxBuilderDelegate ,or you make custom delegate to create checkbox

  //     //loadingDelegate: this,
  //     // if you want to build custom loading widget,extends LoadingDelegate, [see example/lib/main.dart]

  //     badgeDelegate: const DurationBadgeDelegate(),
  //     // badgeDelegate to show badge widget

  //     pickType: type,

  //     photoPathList: pathList,
  //   );

  //   if (imgList == null || imgList.isEmpty) {
  //     //showToast("No pick item.");
  //     print('No item Here');
  //     return;
  //   } else {
  //     List<String> r = [];
  //     for (var e in imgList) {
  //       var file = await e.file;
  //       r.add(file.absolute.path);
  //     }
  //     currentSelected = r.join("\n\n");

  //     List<AssetEntity> tmpPreview = [];
  //     tmpPreview.addAll(imgList);
  //     setState(() {
  //       preview = tmpPreview;
  //     });
  //   }
  // }
}
