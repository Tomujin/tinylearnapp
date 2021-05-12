import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tiny/models/career.dart';
import 'package:tiny/models/curriculum.dart';
import 'package:tiny/models/curriculum_school.dart';
import 'package:tiny/models/user.dart';
import 'package:tiny/models/userCurriculum.dart';

class SelectGoalRepository {
  final GraphQLClient _client;
  SelectGoalRepository(GraphQLClient client)
      : assert(client != null),
        _client = client;

  Future<Map<dynamic, dynamic>> getCurriculums(
      String parentid, String userId) async {
    final result = await _client.query(QueryOptions(
      documentNode: gql("""
        query {
          curricula(where:{parentId:{ equals: $parentid}}) {
            id,
            name,
            point,
            parentId,
            ParentCurriculum{
              id
              name
            }
            CurriculumSchools {
              id,
              name
            }
            ChildCurriculums{
              id
              parentId
              subjectId
              name
            }
          }

          userCurricula(where:{userId:{equals:"b159e64d-6dfa-4fb7-87c7-0a34b5f4dd51"}}){
            id
            userId
            curriculumId
            applyingDate
            point
            UserCurriculumRate{
              id
              userCurriculumId
              curriculumId
              rate
            }
          }
        }
      """),
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    ));
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    final curriculums = result.data['curricula'];
    final userCurriculums = result.data['userCurricula'];
    final curriculumState = {
      "curriculums":
          curriculums.map<Curriculum>((x) => Curriculum.fromJson(x)).toList(),
      "userCurriculums": userCurriculums
          .map<UserCurriculum>((x) => UserCurriculum.fromJson(x))
          .toList()
    };
    return curriculumState;
  }

  Future<String> saveUserCurriculum(
      List<UserCurriculum> userCurriculums) async {
    var a = 1;
    final result = await _client.query(QueryOptions(
      documentNode: gql("""
        mutation SaveUserCurriculum(\$inputUserCurriculums:[InputUserCurriculum]){
          saveUserCurriculum (inputUserCurriculums:\$inputUserCurriculums)
        }
      """),
      variables: {"inputUserCurriculums": userCurriculums},
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    ));
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    return 'saved';
  }

  Future<List<CurriculumSchool>> getCurriculumSchools() async {
    final result = await _client.query(QueryOptions(
      documentNode: gql("""
        query {
          curriculumSchools(where:{curriculumId :{
            equals:"bb35079d-57d3-11eb-99bc-0ad59f11d076"
          }}){
            id,
            name,
            Curriculum{
              name
            }
          }
        }
      """),
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    ));
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    final curriculums = result.data['curriculumSchools'];
    return curriculums
        .map<CurriculumSchool>((x) => CurriculumSchool.fromJson(x))
        .toList();
  }

  Future<void> saveChosenCurriculum(curriculumId, userId) async {
    final result = await _client.query(QueryOptions(
      documentNode: gql("""
        mutation{
          createOneUserCurriculum(data:{
            Curriculum:{connect:{id:"$curriculumId"}}
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
    }
    final userCurriculum = result.data['createOneUserCurriculum'];
    return userCurriculum;
  }

  Future<void> updateCurriculum(field, value) async {
    final result = await _client.query(QueryOptions(
      documentNode: gql("""
  mutation {
  updateOneUserCurriculum(where: { id: "6cd2d3e8-d332-4ed0-a711-e31ab95789ba" }, 
    data: { $field: {set:$value} }) {
  id
  }  
  
}
}
      """),
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    ));
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    final userCurriculum = result.data['updateOneUserCurriculum'];
    // return userCurriculum;
  }

  Future<void> UpdateUserConfig(field, value) async {
    final result = await _client.query(QueryOptions(
      documentNode: gql("""
  mutation {
  updateOneUserConfig(where: { id: "77d438af-5e3e-11eb-99bc-0ad59f11d076" }, 
    data: { $field: {set:$value} }) {
  id
  }  
  
}
}
      """),
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    ));
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    final userCurriculum = result.data['updateOneUserCurriculum'];
    // return userCurriculum;
  }

  Future<List<Career>> getCareers() async {
    final result = await _client.query(QueryOptions(
      documentNode: gql("""
       query {
 careers
   {
    id,
    name
  }
}
      """),
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    ));
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    final datas = result.data['careers'];
    return datas.map<Career>((x) => Career.fromJson(x)).toList();
  }

  Future<List<User>> getUsers() async {
    final result = await _client.query(QueryOptions(
      documentNode: gql("""
      query {
          users
          {
            id,
            email,
            firstName,
            lastName,
            profilePic,
            bio
          
          }
        }
      """),
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    ));
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    final datas = result.data['users'];
    return datas.map<User>((x) => User.fromJson(x)).toList();
  }
}
