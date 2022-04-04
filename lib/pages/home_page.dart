import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pattern_setstate/models/post_model.dart';
import 'package:pattern_setstate/services/http_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
static const String id = "home_page";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isLoading = false;
  List<Post> items = [];

  void _apiPostList()async{
    setState(() {
      isLoading = true;

    });
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
  setState(() {
    if(response != null){
      items = Network.parsePostList(response);
    }else{
      items = [];
    }
    isLoading = false;
  });

  }

  void _apiPostDelete(Post post) async {
    setState(() {
      isLoading=true;
    });

    var response = await Network.GET(Network.API_DELETE + post.id.toString(), Network.paramsEmpty());
    setState(() {
      if(response != null){
        _apiPostList();
      }
      isLoading = false;
    });

  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiPostList();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  centerTitle: true,
  title: Text("Pattern - setState"),
),

      body: Stack(
        children: [
          ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (ctx, index){
              return itemOfPost(items[index]);
            },
          ),
          isLoading ? Center(
            child: CircularProgressIndicator(),
          ):SizedBox.shrink(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: (){
          //////
        },
        child: Icon(Icons.add),
      ),

    );
  }

  Widget itemOfPost(Post post){
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context){
              _apiPostDelete(post);
            },
            flex: 3,
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: "Delete",
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.only(left: 20,right: 20,top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.title!.toUpperCase(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),

            ),
            SizedBox(height: 5,),
            Text(post.body!),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
