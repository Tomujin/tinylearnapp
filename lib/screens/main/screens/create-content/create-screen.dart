import 'package:flutter/material.dart';
import 'package:tiny/components/grey100-appbar.dart';
import 'package:tiny/screens/main/screens/create-content/topic-chooser-screen.dart';
import 'package:tiny/screens/main/screens/create-content/uploader-screen.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key key}) : super(key: key);

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

const topic = 0;
const subTopic = 1;

class _CreateScreenState extends State<CreateScreen> {
  int counter = 0;
  String topicName = '';
  String subTopicName = '';
  List<Map<String, dynamic>> levels = [
    {"id": null, 'name': null, "selectedIndex": 0},
    {"id": null, 'name': null, "selectedIndex": 0},
  ];

  final topicIds =
      "[\"c2651d18-57d4-11eb-99bc-0ad59f11d076\",\"ec5e3efd-57d4-11eb-99bc-0ad59f11d076\",\"f8391c6a-57d4-11eb-99bc-0ad59f11d076\"]";

  void stateChanger({int type, int value, String name, String id}) {
    setState(() {
      levels[type]["selectedIndex"] = value;
      levels[type]["name"] = name;
      levels[type]["id"] = id;
      if (type == topic)
        topicName = name;
      else
        subTopicName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: grey100AppBar(
        title: 'Create content',
      ),
      body: Container(
        child: Center(
          child: Column(children: [
            Expanded(child: Text('')),
            Container(
              decoration: BoxDecoration(
                  //color: Colors.white,
                  border: Border.all(color: Colors.grey[400], width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Image(
                        image: AssetImage('assets/images/createPicOne.png')),
                  ),
                  Container(),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Select topic",
                    style: TextStyle(
                      color: Color(0xff8c8c8c),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  OutlineButton(
                    child:
                        new Text(topicName == '' ? "Tap to choose" : topicName),
                    onPressed: () {
                      pushToTopicChooserScreen(
                          context, topicIds, topic, stateChanger);
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    padding: EdgeInsets.only(left: 70, right: 70),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Select subtopic",
                    style: TextStyle(
                      color: Color(0xff8c8c8c),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  OutlineButton(
                    child: new Text(
                        subTopicName == '' ? "Tap to choose" : subTopicName),
                    onPressed: topicName == ''
                        ? null
                        : () {
                            String id = "[\"" + levels[topic]['id'] + "\"]";
                            pushToTopicChooserScreen(
                                context, id, subTopic, stateChanger);
                          },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    padding: EdgeInsets.only(left: 70, right: 70),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 150,
                    child: RaisedButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30)),
                      onPressed: () {
                        pushToUploadScreen(context);
                      },
                      child: Text('Go to Upload'),
                    ),
                  )
                ],
              ),
            ),
            Expanded(child: Text('')),
          ]),
        ),
      ),
    );
  }

  pushToTopicChooserScreen(
      BuildContext context, String ids, int type, Function stateChanger) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) => TopicChooser(
              ids: ids,
              type: type,
              stateChanger: stateChanger,
              initialValue: levels[type]["selectedIndex"])),
    );
  }

  pushToUploadScreen(
    BuildContext context,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => UploaderScreen()),
    );
  }
}
