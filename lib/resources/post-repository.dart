import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tiny/models/models.dart';
import 'package:tiny/screens/main/screens/home/components/postComponent.dart';

class PostRepository {
  final GraphQLClient _client;
  PostRepository(GraphQLClient client)
      : assert(client != null),
        _client = client;

  Future<List<Post>> getPosts(String userId, String lastId) async {
    var afterValue = "";

    if (lastId != null) afterValue = "after:{id:\"${lastId}\"},";
    final result = await _client.query(QueryOptions(
      documentNode: gql("""
    query {
      posts(first: 5,$afterValue orderBy: [{postType: desc}],
) {
        id
        postType
        title
        publishedDate
        Passage {
          id
          mediaType
          text
        }
        User {
          id
          firstName
          profilePic
        }
        Contents {
          id
          orderNum
          mediaType
          contentText
          sourcePath
          voiceOverPath
          answerType
          Answers {
            id
            mediaType
            Point
            answer
          }
        }
        isReacted(userId:"$userId")
        userSavedPostId(userId:"$userId") 
        PostReactions(first:1){
          id
          User{
            id
            firstName
            profilePic
          }
          ReactionType{
            id
          }
        }
        PostCurriculum{
          Curriculum{
            id,
            name,
            ParentCurriculum{
              name
            }
          }
        }
        reactionCount
        totalCount
        PostComments (first:1){
          id
          User{
            id
            firstName
            profilePic
          }
          comment
          updatedAt
        }
       
      }
    }
      """),
      // variables: {"userId": userId},
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    ));
    //print(jsonEncode(result.data['posts']));

    if (result.hasException) {
      print("exp:${result.exception.toString()}");
      throw Exception(result.exception.toString());
    }

    final posts = result.data['posts'];

    final returningValue = posts.map<Post>((x) => Post.fromJson(x)).toList();
    return returningValue;
  }

  Future<bool> postUserAnswer(
      String contentId, String answerId, String answerText) async {
    String _answerId = answerId == null ? null : """\"$answerId\"""";
    String _answerText = answerText == null ? null : """\"$answerText\"""";

    final result = await _client.mutate(MutationOptions(
      documentNode: gql("""
      mutation{
  createOneUserAnswersOnContents(data:{
    Content:{connect:{id:"$contentId"}}
    Answer:{connect:{id:$_answerId}}
    answerText:$_answerText
  	User:{connect:{id:"aaa"}}
  }
  ){
    id
  }
}
      """),
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    ));
    if (result.hasException) {
      throw Exception(result.exception.toString());
    } else {
      return true;
    }
  }

  Future<String> postUserSavedPost(
      String contentId, bool isPublic, String userId) async {
    final result = await _client.mutate(MutationOptions(
      documentNode: gql("""
mutation {
  createOneUserSavedPosts(data:{
    Post:{connect:{id:"$contentId"}}
    isPublic: $isPublic
    User:{connect:{id:"$userId"}}
  }){
    id
  }
}
      """),
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    ));
    if (result.hasException) {
      throw Exception(result.exception.toString());
    } else {
      // print("sdfdsfdsf${result.data["createOneUserSavedPosts"]['id']}");
      return result.data["createOneUserSavedPosts"]['id'];
    }
  }

  Future<bool> postCommentSaved(
      {String userId, String postId, String comment}) async {
    final result = await _client.mutate(MutationOptions(
      documentNode: gql("""
      mutation {
        createOnePostComments(data:{
          Post:{connect:{id:"$postId"}}
          User:{connect:{id:"$userId"}}
          comment:"$comment"
        }){
            id
          }}
      """),
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    ));
    if (result.hasException) throw Exception(result.exception.toString());
    //return result.data["createOnePostComment"]["id"];
    return true;
  }

  Future<List<Comment>> getPostComments(String postId) async {
    print("postId $postId");
    final result = await _client.mutate(MutationOptions(
      documentNode: gql("""   query{
      postComments(where:{postId:{equals:"$postId"}} 
      ){
        User{id,userName, profilePic}
        comment
      }
    }     
    """),
      // variables: {"userId": userId},
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    ));
    //print(jsonEncode(result.data['posts']));

    if (result.hasException) {
      print("exp:${result.exception.toString()}");
      throw Exception(result.exception.toString());
    }

    final comments = result.data['postComments'];

    final returningValue =
        comments.map<Comment>((x) => Comment.fromJson(x)).toList();
    return returningValue;
  }

  Future<bool> postReactionSaved(
      String userId, String postId, int reactionTypes) async {
    final result = await _client.mutate(MutationOptions(
      documentNode: gql("""
      mutation {
         createOnePostReactions(data:{
          Post:{connect:{id:"$postId"}}
          User:{connect:{id:"$userId"}}
         ReactionTypes:{connect:{id:"1"}}
        }){
            id
          }}
      """),
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    ));
    if (result.hasException) throw Exception(result.exception.toString());
    //return result.data["createOnePostComment"]["id"];
    return true;
  }

  Future<bool> deletePostReaction(String id) async {
    final result = await _client.mutate(MutationOptions(
      documentNode: gql("""
mutation {
  deleteOnePostReactions (where: {id: "$id"}){
    id
  }
}
      """),
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    ));
    if (result.hasException) {
      throw Exception(result.exception.toString());
    } else {
      return true;
    }
  }

  Future<bool> deleteUserSavedPost(String id) async {
    print(id);
    final result = await _client.mutate(MutationOptions(
      documentNode: gql("""
mutation {
  deleteOneUserSavedPosts (where: {id: "$id"}){
    id
  }
}
      """),
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    ));
    if (result.hasException) {
      throw Exception(result.exception.toString());
    } else {
      return true;
    }
  }

  Future<bool> postView(String userId) async {
//     final result = await _client.mutate(MutationOptions(
//       documentNode: gql("""
// mutation {
//   deleteOneUserSavedPosts (where: {id: "$userId"}){
//     id
//   }
// }
//       """),
//       fetchPolicy: FetchPolicy.cacheAndNetwork,
//     ));
//     if (result.hasException) {
//       throw Exception(result.exception.toString());
//     } else {
//       return true;
//     }
  }
}
