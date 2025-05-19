import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Screen/LoginScreen.dart';
import 'package:flutter_application_1/models/models.dart';
import 'package:flutter_application_1/provider/user_provider.dart';
import 'package:flutter_application_1/resources/firestore_method.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddPost> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  bool isloading = false;
  double _progress = 0.0;

  void PostImage(String uid, String username, String profImage) async {
    setState(() {
        isloading = true;
        
    });
    try {
      String res = await FirestoreMethod().uploadPost(
        _descriptionController.text,
        uid,
        _file!,
        username,
        profImage,
      );

      if (res == "success") {
        setState(() {
        isloading = false;
    });
        showSnackBar("posted!", context);
        clearImage();
      } else {
        setState(() {
        isloading = false;
    });
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  _selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('Create a post'),
          children: [
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Text("Take a photo"),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.camera);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Text("Choose from gallery"),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.gallery);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Text("Cancel"),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void clearImage(){
    setState(() {
      _file = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;
    if (user == null) {
      return LoginScreen();// User가 null일 경우 로딩 상태 표시
}
    return _file == null
        ? Center(
          child: IconButton(  
            icon: const Icon(Icons.upload),
            onPressed: () {
              _selectImage(context);
            },
          ),
        )
        : Scaffold(
          appBar: AppBar(
            backgroundColor: mobileBackgroundColor,
            leading: IconButton(onPressed: () {clearImage();}, icon: Icon(Icons.arrow_back)),
            title: const Text('Post to'),
            centerTitle: false,
            actions: [
              TextButton(
                onPressed: () {
                  PostImage(user.uid,user.username,user.photoUrl);
                },
                child: Text(
                  'Post',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              isloading? LinearProgressIndicator():Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(backgroundImage: NetworkImage(user.photoUrl)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        hintText: 'Write a caption...',
                        border: InputBorder.none,
                      ),
                      maxLines: 10,
                    ),
                  ),
                  Container(
                    child: SizedBox(
                      height: 45,
                      width: 45,
                      child: AspectRatio(
                        aspectRatio: 1 / 15,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(_file!),
                              fit: BoxFit.fill,
                              alignment: FractionalOffset.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
  }
}
