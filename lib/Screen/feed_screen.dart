import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widgets/post_card.dart';

import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_svg/svg.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset(
          'lib/assets/ic_instagram.svg',
          color: primaryColor,
          height: 32,
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.message_outlined)),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);

          }

          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context,index)=>PostCard(snap: snapshot.data!.docs[index].data(),),
            );
              
        

        }
      ),
    );
  }
}
