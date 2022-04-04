import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pattern_setstate/models/post_model.dart';
import 'package:pattern_setstate/services/http_service.dart';

class UpdatePostPage extends StatefulWidget {
  UpdatePostPage({Key? key, this.post}) : super(key: key);
  static const String id = 'update_post_page';
  Post? post;

  @override
  State<UpdatePostPage> createState() => _UpdatePostPageState();
}

class _UpdatePostPageState extends State<UpdatePostPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  bool isLoading = false;

  void _updatePost() async{
    setState(() {
      isLoading = true;
    });
    String title = titleController.text.trim().toString();
    String body = bodyController.text.trim().toString();
    Post post = Post(title: title, body: body);
    if(title.isNotEmpty && body.isNotEmpty) {
      await Network.PUT(Network.API_UPDATE, Network.paramsUpdate(post)).then((value){
        _getResponse();
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
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController(text: widget.post!.title!);
    bodyController = TextEditingController(text: widget.post!.body!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: widget.post != null ? Stack(
          children: [
            Column(
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
                      hintText: 'Title',
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
                    _updatePost();
                  },
                  child: const Text('Update Post', style: TextStyle(color: Colors.white, fontSize: 17),),
                ),

              ],
            ),
            isLoading ? const Center(child: CircularProgressIndicator(),) : const SizedBox.shrink(),
          ],
        ) : const Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}