import 'package:flutter/material.dart';
import 'package:tiny/components/grey100-appbar.dart';
import 'package:tiny/functions/pushToScreen.dart';
import 'package:tiny/screens/main/app-screen.dart';
import 'package:tiny/theme/style.dart';

class SelectTargetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: grey100AppBar(
        title: 'Set Target learners',
      ),
      body: Container(
        margin: EdgeInsets.only(left: 24, right: 24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 24,
          ),
          Text(
            'Select Tag',
            style: TextStyle(
              color: Color(0xff8c8c8c),
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(child: SelectTag()),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            width: double.infinity,
            child: OutlineButton.icon(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30)),
              onPressed: () {},
              label: Text('Add tag'),
              textTheme: ButtonTextTheme.accent,
              icon: Icon(Icons.add),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Target learners',
            style: TextStyle(
              color: Color(0xff8c8c8c),
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]),
                borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.only(top: 30, bottom: 30),
            child: Center(
              child: Text(
                '760',
                style: TextStyle(
                    color: lightPurple,
                    fontWeight: FontWeight.w800,
                    fontSize: 35),
              ),
            ),
          ),
          Expanded(
            child: Text(''),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 130,
                child: OutlineButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    pushToScreen(context, AppScreen(0));
                  },
                  child: Text(
                    'Draft',
                    style: TextStyle(color: ligtGrey),
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              SizedBox(
                width: 130,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    pushToScreen(context, AppScreen(0));
                  },
                  child: Text('Publish'),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          )
        ]),
      ),
    );
  }
}

class SelectTag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[400]),
          borderRadius: BorderRadius.circular(12)),
      constraints: BoxConstraints(minWidth: double.infinity, minHeight: 200),
      padding: EdgeInsets.all(12),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          TagItem(tag: 'Some Tag'),
          TagItem(tag: 'Some Tag'),
          TagItem(tag: 'Some Tag'),
          TagItem(tag: 'Some Tag'),
          TagItem(tag: 'Some Tag'),
          TagItem(tag: 'Some Tag'),
          TagItem(tag: 'Some Tag'),
          TagItem(tag: 'Some Tag'),
          TagItem(tag: 'Some Tag'),
          TagItem(tag: 'Some Tag'),
          TagItem(tag: 'Some Tag'),
          TagItem(tag: 'Some Tag'),
          TagItem(tag: 'Some Tag'),
        ],
      ),
    );
  }
}

class TagItem extends StatelessWidget {
  final String tag;
  TagItem({this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[400]),
          borderRadius: BorderRadius.circular(6)),
      padding: EdgeInsets.all(4),
      child: Text(
        '#$tag',
        style: TextStyle(
          color: Colors.black54,
        ),
      ),
    );
  }
}
