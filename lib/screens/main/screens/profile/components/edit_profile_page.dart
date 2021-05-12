import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiny/models/user.dart';
import 'package:tiny/screens/main/screens/profile/bloc/profile_bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'main.dart'; //for currentuser & google signin instance
// import 'models/user.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({Key key, this.user}) : super(key: key);
  final User user;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  changeProfilePhoto(BuildContext parentContext) {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Photo'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Changing your profile photo has not been implemented yet'),
              ],
            ),
          ),
        );
      },
    );
  }

  applyChanges() {
    // Firestore.instance
    //     .collection('insta_users')
    //     .document(currentUserModel.id)
    //     .updateData({
    //   "userName": nameController.text,
    //   "bio": bioController.text,
    // });
  }

  Widget buildTextField({String name, TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 12.0, left: 12),
          child: Text(
            name,
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0, left: 12),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: name,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print(user.firstName);
    ProfileBloc pBloc = BlocProvider.of<ProfileBloc>(context);
    nameController.text = this.user.firstName;
    lastNameController.text = this.user.lastName;
    userNameController.text = this.user.userName;
    bioController.text = this.user.bio;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFf5f5f9),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Profile Edit", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Expanded(
            child: Center(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                      child: Container(
                        height: 80.0,
                        width: 80.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          border: Border.all(
                            color: Color.fromRGBO(120, 81, 162, 1),
                            style: BorderStyle.solid,
                            width: 2,
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            // image: AssetImage(
                            //   'assets/images/icon.png',
                            // ),

                            image: (this.user.profilePic == null)
                                ? AssetImage('assets/images/icon.png')
                                : NetworkImage(this.user.profilePic),
                          ),
                        ),
                      ),
                    ),
                    FlatButton(
                        onPressed: () {
                          changeProfilePhoto(context);
                        },
                        child: Text(
                          "Change Photo",
                          style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        )),
                    buildTextField(
                        name: "Display Name", controller: userNameController),
                    buildTextField(
                        name: "First name", controller: nameController),
                    buildTextField(
                        name: "Last Name", controller: lastNameController),
                    buildTextField(name: "Bio", controller: bioController),
                    RaisedButton(
                      child: Text("Save"),
                      onPressed: () => {
                        print(user.id),
                        pBloc.add(ProfileSaveEvent(new User(
                            id: user.id,
                            firstName: nameController.text,
                            lastName: lastNameController.text,
                            bio: bioController.text))),
                        // pBloc.add(LoadProfileEvent()),
                        Navigator.pop(context)
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    // });
  }

  void _logout(BuildContext context) async {
    print("logout");
    // await auth.signOut();
    // await googleSignIn.signOut();

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.clear();

    // currentUserModel = null;

    Navigator.pop(context);
  }
}
