import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tiny/models/curriculum.dart';

class TopicChooser extends StatefulWidget {
  final String ids;
  final int type;
  final Function stateChanger;
  final int initialValue;

  TopicChooser({this.ids, this.type, this.stateChanger, this.initialValue});

  @override
  _TopicChooserState createState() => _TopicChooserState();
}

class _TopicChooserState extends State<TopicChooser> {
  List<Curriculum> topics = [];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    String ids = widget.ids;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('Choose topic'),
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.black54,
                displayColor: Colors.black54,
              ),
        ),
        body: Container(
          child: Column(children: [
            Expanded(
                child: Query(
              options: QueryOptions(
                documentNode: gql("""
                  query {
                    curricula(where:{parentId:{ in: $ids}})
                    {
                      id,
                      name,
                    }
                  }
                  """),
                fetchPolicy: FetchPolicy.cacheAndNetwork,
              ),
              builder: (QueryResult result,
                  {VoidCallback refetch, FetchMore fetchMore}) {
                if (result.hasException) {
                  return Text(result.exception.toString());
                }

                if (result.loading) {
                  return Center(child: Text('Loading'));
                }
                // it can be either Map or List
                List repositories = result.data['curricula'];

                var data = repositories
                    .map<Curriculum>((x) => Curriculum.fromJson(x))
                    .toList();
                topics = data;
                var listItems =
                    data.map((x) => Center(child: Text(x.name))).toList();

                return CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                      initialItem: widget.initialValue),
                  magnification: 1.5,
                  children: <Widget>[...listItems],
                  itemExtent: 30, //height of each item
                  looping: false,
                  onSelectedItemChanged: (int index) {
                    if (index != 0)
                      widget.stateChanger(
                          type: widget.type,
                          value: index,
                          name: topics[index].name,
                          id: topics[index].id);
                    selectedIndex = index;
                  },
                );
              },
            )),
            SizedBox(
              width: 150, // <-- Your width
              child: RaisedButton(
                child: Center(child: Text("Choose")),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30)),
                onPressed: () {
                  if (selectedIndex == 0)
                    widget.stateChanger(
                        type: widget.type,
                        value: 0,
                        name: topics[0].name,
                        id: topics[0].id);
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(
              height: 30,
            )
          ]),
        ));
  }
}
