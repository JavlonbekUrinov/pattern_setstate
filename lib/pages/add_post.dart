import 'package:flutter/material.dart';
import 'package:pattern_setstate/models/post_model.dart';
import 'package:pattern_setstate/services/http_service.dart';
class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);
  static const String id = 'add_post_page';

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  bool isLoading = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  void _createPost() async{
    setState(() {
      isLoading = true;
    });
    String title = titleController.text.trim().toString();
    String body = bodyController.text.trim().toString();
    Post post = Post(title: title, body: body);
    if(title.isNotEmpty && body.isNotEmpty) {
      await Network.POST(Network.API_CREATE, Network.paramsCreate(post)).then((value) {
        _getResponse();
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _getResponse() {
    setState(() {
      isLoading = false;
    });
    Navigator.pop(context, 'done');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.white,
        foregroundColor: Colors.black,
        elevation: 2,
        title: const Text('Add Post'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      hintText: 'Title',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ),
                ),

                const SizedBox(height: 20,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: bodyController,
                    decoration: const InputDecoration(
                      hintText: 'Body',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ),
                ),

                const SizedBox(height: 30,),

                MaterialButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  minWidth: MediaQuery.of(context).size.width - 100,
                  height: 45,
                  onPressed: (){
                    _createPost();
                  },
                  child: const Text('Save', style: TextStyle(color: Colors.white, fontSize: 17),),
                ),

              ],
            ),
          ),
          isLoading ? SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: const Center(child: CircularProgressIndicator(),),
          ) : const SizedBox.shrink(),
        ],
      ),
    );
  }
}