import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:napta/models/PostModel/PostModel.dart';
import 'package:napta/modules/BottomNavigation/BottomNavigationScreen.dart';
import 'package:napta/modules/Posts/PostScreens.dart';
import 'package:napta/shared/cubit/cubit.dart';
import 'package:napta/shared/cubit/states.dart';

class CreatePost extends StatelessWidget {
  String Post_image;

  var postController = TextEditingController();

  Builder buildDialogItem(
      BuildContext context, String text, IconData icon, ImageSource src) {
    return Builder(
      builder: (innerContext) => Container(
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
              leading: Icon(icon, color: Colors.white),
              title: Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Anton',
                    letterSpacing: 1.5),
              ),
              onTap: () async {
                //   setState(() async {
                //     final pickedFile = await ImagePicker().getImage(source: src);
                //
                //     if (pickedFile != null) {
                //       Post_image = File(pickedFile.path);
                //     }
                //     print(Post_image.path);
                //     Navigator.pop(innerContext);
                //   });
              })),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, AppStates state) {
        AppCubit cubit = AppCubit.get(context);
        if (state is PostImageSelectedSuccessState) {
          Post_image = AppCubit.PostImage;
        } else if (state is PostCreatedSuccessState) {
          Fluttertoast.showToast(
              msg: "Post is Created Successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          cubit.getPosts();
        } else if (state is GetPostsSuccessfullyState) {
          AppCubit.Posts = GetPostsSuccessfullyState.posts;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BottomNavigationScreen()),
          );
        }
      }, builder: (BuildContext context, AppStates state) {
        AppCubit cubit = AppCubit.get(context);
        print('current stat in builder: $state');

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            titleSpacing: 5,
            title: Text(
              "Add Post",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Lato',
                fontSize: 18,
              ),
            ),
            actions: [
              MaterialButton(
                  onPressed: () {
                    if (postController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Post Can not be empty!",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 5,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      Post post = Post(postController.text, Post_image);
                      cubit.postPost(Post: post.toJson());
                      postController.clear();
                    }
                  },
                  child: Text(
                    "Post",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontFamily: 'Lato',
                    ),
                  )),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage:
                          AssetImage("assets/images/UserImageDef.jpeg"),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Text(
                                "${AppCubit.userData.FirstName} ${AppCubit.userData.LastName} ",
                                style:
                                    TextStyle(height: 1.4, fontFamily: 'Lato'),
                              ),
                            ]),
                          ]),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: postController,
                    decoration: InputDecoration(
                      hintText: 'What is on your mind ....',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            cubit.getPostImageFromgallery();
                            // var ad = AlertDialog(
                            //   title: Text(
                            //     "Chose Picture From:",
                            //     style: TextStyle(fontFamily: 'Lato'),
                            //   ),
                            //   content: Container(
                            //     height: 150,
                            //     child: Column(
                            //       children: [
                            //         Divider(color: Colors.black),
                            //         buildDialogItem(
                            //             context,
                            //             "Camera",
                            //             Icons.add_a_photo_outlined,
                            //             ImageSource.camera),
                            //         SizedBox(height: 10),
                            //         buildDialogItem(
                            //             context,
                            //             "Gallery",
                            //             Icons.image_outlined,
                            //             ImageSource.gallery),
                            //       ],
                            //     ),
                            //   ),
                            // );
                            // showDialog(
                            //     context: context,
                            //     builder: (context) {
                            //       return ad;
                            //     });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.photo_camera_outlined,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                "add photo",
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 15,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
