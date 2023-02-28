// ignore_for_file: use_build_context_synchronously
import 'package:firebase_demo_app/app/services/api_service.dart';
import 'package:flutter/material.dart';

import '../../model/Post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Post>? posts;
  bool isLoaded=false;
  @override
  void initState() {
    super.initState();
    getData();
  }
  getData()async{
    posts=await APIservice.getPosts();
    if(posts!=null){
      setState(() {
        isLoaded=true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Visibility(
          visible: isLoaded,
          replacement: const Center(
            child: CircularProgressIndicator(
              
            ),
          ),
          child: ListView.builder(itemCount: posts?.length,itemBuilder: (context,index){
            return Container(
              decoration: const BoxDecoration(
                
              ),
              child:  Text(posts![index].title),

            );
          }),
        ));
  }
}
