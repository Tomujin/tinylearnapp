import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:tiny/models/story.dart';

class StoryRepository {
  final GraphQLClient _client;
  StoryRepository(GraphQLClient client)
      : assert(client != null),
        _client = client;

  Future<List<Story>> getStories() async {
    final result = await _client.query(QueryOptions(
      documentNode: gql("""
      query{
          stories{
            publishedDate,
            User{
              profilePic,
              firstName,
              userName,
              id
            }
          StoryContent{
            id,
            mediaType,
            sourcePath
          }
          }
        }
      """),
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    ));
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final datas = result.data['stories'];
    return datas.map<Story>((x) => Story.fromJson(x)).toList();
  }
}
