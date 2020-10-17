// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myfitnesstrainer/locator.dart';
import 'package:myfitnesstrainer/models/progress_photos.dart';
import 'package:myfitnesstrainer/screens/student/student_home.dart';
import 'package:myfitnesstrainer/services/firestore_services.dart';
import 'package:myfitnesstrainer/viewmodel/userviewmodel.dart';

class StudentImageUpload extends StatefulWidget {
  @override
  StudentImageUploadState createState() => StudentImageUploadState();
}

class StudentImageUploadState extends State<StudentImageUpload> {
  UserModel _userViewModel = locator<UserModel>();
  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _picker = ImagePicker();
  PickedFile frontImage;
  PickedFile sideImage;
  Future takePicture(bool front) async {
    PickedFile picture = await _picker.getImage(
        source: ImageSource.camera,
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height);
    setState(() {
      if (front)
        frontImage = picture;
      else
        sideImage = picture;
    });
  }

  Future getImage(bool front) async {
    PickedFile picture = await _picker.getImage(
        source: ImageSource.gallery,
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height);
    setState(() {
      if (front)
        frontImage = picture;
      else
        sideImage = picture;
    });
  }

  void removeImage(bool front) {
    setState(() {
      if (front)
        frontImage = null;
      else
        sideImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("Fotoğraf ekle"), actions: [
        IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
            tooltip: "Kaydet",
            onPressed: savePhotos)
      ]),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildPhotoAddingWidget(context, "Önden Çekim", true),
          buildPhotoAddingWidget(context, "Yandan Çekim", false),
        ],
      ),
    );
  }

  Padding buildPhotoAddingWidget(
      BuildContext context, String text, bool front) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Column(
        children: [
          Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
            height: 10,
          ),
          Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(Icons.add_a_photo),
                          onPressed: () {
                            takePicture(front);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.photo_library),
                          onPressed: () {
                            getImage(front);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            removeImage(front);
                          },
                        ),
                      ]),
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 2.2,
                    height: MediaQuery.of(context).size.height / 2.2,
                    child: front == true
                        ? frontImage == null
                            ? Align(
                                alignment: Alignment.center,
                                child: Text("Fotoğraf ekle"))
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return FullScreenImageShow(
                                          frontImage.path, 'front');
                                    }));
                                  },
                                  child: Hero(
                                      tag: 'front',
                                      child: Image.file(File(frontImage.path))),
                                ),
                              )
                        : sideImage == null
                            ? Align(
                                alignment: Alignment.center,
                                child: Text("Fotoğraf ekle"))
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return FullScreenImageShow(
                                          sideImage.path, 'side');
                                    }));
                                  },
                                  child: Hero(
                                      tag: 'side',
                                      child: Image.file(File(sideImage.path))),
                                ),
                              )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void savePhotos() async {
    ProgressPhotos progressPhotos = ProgressPhotos();
    var userID = _userViewModel.user.userID;
    var date = DateTime.now();
    final loadingSnackBar = SnackBar(
        content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Fotoğraflarınız yükleniyor, lütfen bekleyin'),
        CircularProgressIndicator(
          strokeWidth: 3,
        )
      ],
    ));
    final snackBar = SnackBar(
      content: Text('Lütfen fotoğrafları yüklediğinize emin olun'),
    );
    if (frontImage != null && sideImage != null) {
      _scaffoldKey.currentState.showSnackBar(loadingSnackBar);
      StorageReference storageReference =
          FirebaseStorage.instance.ref().child('users/$userID/front/$date');
      StorageUploadTask uploadTask =
          storageReference.putFile(File(frontImage.path));
      var frontResult = await uploadTask.onComplete;
      if (frontResult.error == null) {
        progressPhotos.frontUrl = await frontResult.ref.getDownloadURL();
      }
      storageReference =
          FirebaseStorage.instance.ref().child('users/$userID/side/$date');
      uploadTask = storageReference.putFile(File(sideImage.path));
      var sideResult = await uploadTask.onComplete;
      if (sideResult.error == null) {
        progressPhotos.sideUrl = await sideResult.ref.getDownloadURL();
      }
      progressPhotos.date = date;
      await _firestoreDBService.savePhotos(userID, progressPhotos);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return StudentHomePage();
      }));
    } else {
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }
}

class FullScreenImageShow extends StatelessWidget {
  final String imagePath;
  final Object tag;
  FullScreenImageShow(this.imagePath, this.tag);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Hero(
          tag: tag,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.file(
              File(imagePath),
            ),
          ),
        ));
  }
}
