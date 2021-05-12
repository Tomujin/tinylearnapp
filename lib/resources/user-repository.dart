import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tiny/models/user.dart';

class UserRepository {
  final GraphQLClient _client;
  UserRepository(GraphQLClient client)
      : assert(client != null),
        _client = client;

  Future<User> getMe() async {
    final result = await _client.query(QueryOptions(
      documentNode: gql("""
        query GetMe{
          getMe{
            id,
            sub,
            email,
            userName,
            profilePic,
            firstName,
            lastName,
            bio, 
             
            AcceptedByUser{
              firstName,
              userName,
              profilePic
            }
            UserFollow{
  		        followerCount,
            buddyCount,
      			followingCount
            }
          }
        }
      """),
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    ));
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    return User.fromDictionary(result.data['getMe']);
  }

  Future<bool> checkIfUserExists(String sub) async {
    final result = await _client.query(QueryOptions(documentNode: gql("""
        query CheckUser(\$sub: String!){
          user(sub: \$sub){
            sub
          }
        }
      """), variables: {"sub": sub}, fetchPolicy: FetchPolicy.cacheAndNetwork));
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    return result.data['user'] ? result.data['user']['sub'] != null : false;
  }

  Future<User> signUpMe(String idToken) async {
    final result = await _client.query(
      QueryOptions(
        documentNode: gql("""
        mutation SignUpMe(\$idToken: String!) {
          signUpMe(idToken: \$idToken){
            id,
            sub,
            email,
            userName,
            profilePic
          }
        }
        """),
        variables: {"idToken": idToken},
        fetchPolicy: FetchPolicy.cacheAndNetwork,
      ),
    );
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    return User.fromDictionary(result.data["signUpMe"]);
  }

  Future<bool> putUser(id, firstName, lastName, bio) async {
    final result = await _client.query(QueryOptions(
      documentNode: gql("""
      mutation {
        updateOneUser(where: { id: "$id" }, data: { 
          firstName:{set:"$firstName"},
          bio: {set:"$bio"} ,
          lastName:{set:"$lastName"}
          }) {
          id
        }
      }

      """),
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    ));
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    // final user = result.data['user'];
    return true;
  }

  Future<List<User>> getUnacceptedUsers() async {
    final result = await _client.query(QueryOptions(
      documentNode: gql("""
        query{
          users(where:{ OR:[
            {acceptedUserId:{equals:""}},
            {acceptedUserId:{equals:null}}
          ]}){
            id
            firstName
            profilePic
    	      userName
          }
        }
      """),
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    ));
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    final users = result.data['users'];

    final returningValue = users.map<User>((x) => User.fromJson(x)).toList();
    return returningValue;
  }

  Future<bool> acceptUser(userId, acceptUserId) async {
    final result = await _client.query(QueryOptions(
      documentNode: gql("""
    mutation {
      updateOneUser(where: { id: "$acceptUserId" }, 
        data: { 
          AcceptedByUser:{connect:{id:"$userId"}}   
        }) {
        id
        }  
      }
      """),
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    ));
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    // final user = result.data['user'];
    return true;
  }

  Future<bool> createFeedback(userid, feedback) async {
    final result = await _client.query(QueryOptions(
      documentNode: gql("""
          mutation{
          createOneFeedback(
            data:{
              feedback:"$feedback"
              User:{connect:{id:"$userid"}}
            }
          )
          {
            id
          }
        }
      """),
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    ));
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    return true;
  }

  Future<List<User>> getUsers() async {
    final result = await _client.query(QueryOptions(
      documentNode: gql("""
       query{
          users{
            id
            firstName
            profilePic
    	      userName
          }
        }
      """),
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    ));
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    final users = result.data['users'];

    final returningValue = users.map<User>((x) => User.fromJson(x)).toList();
    return returningValue;
  }
}
