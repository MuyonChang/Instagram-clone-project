import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/colors.dart';

class PostCard extends StatelessWidget {
  final snap;
  const PostCard({
    Key? key,
    required this.snap,
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),

            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    snap['profImage'],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      snap['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => Dialog(
                            child: ListView(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shrinkWrap: true,
                              children:
                                  ['Delete']
                                      .map(
                                        (e) => InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 12,
                                              horizontal: 16,
                                            ),
                                            child: Text(e),
                                          ),
                                        ),
                                      )
                                      .toList(),
                            ),
                          ),
                    );
                  },
                  icon: Icon(Icons.more_vert),
                ),
              ],
            ),
          ),
          SizedBox(height: 32),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
              snap['postUrl'],
              fit: BoxFit.cover,
            ),
          ),

          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite, color: Colors.red),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.comment_outlined)),
              IconButton(onPressed: () {}, icon: Icon(Icons.share)),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.bookmark_border),
                  ),
                ),
              ),
            ],
          ),

          //description and number of comments
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w800),
                  child: Text(
                    '${snap['likes'].length}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: primaryColor),
                      children: [
                        TextSpan(
                          text: snap['username']   ,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                        TextSpan(
                          text: snap['description'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              

                InkWell(
                  onTap: (){},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      'View all comments',
                      style: TextStyle(fontSize: 16, color: secondColor),
                    ),
                  ),
                ),
                Container(
                    child: Text(
                      '15/05/2025',
                      style: TextStyle(fontSize: 16, color: secondColor),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
