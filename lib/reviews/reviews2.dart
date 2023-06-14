import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:serves/reviews/reviewsmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/global_variable.dart';


class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  Future<ReviewsModel> fetchAllData() async{
    final response = await http.get(Uri.parse("${baseUrl}/GetAllReviews"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      print("data $data");
      return ReviewsModel.fromJson(data);
    }
    else{
      return ReviewsModel.fromJson(data);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAllData();
      print("data fadsfasdfasd");

  }
   Widget buildStarRating(int stars) {
    return Row(
      children: List.generate(
        stars,
        (index) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: fetchAllData(),
            builder: (context,AsyncSnapshot<ReviewsModel> snapshot) {
              if (snapshot.connectionState==ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData) {
                print("Error ");
              }
              return Expanded(child: ListView.builder(
              itemCount: snapshot.data!.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final reviewsData= snapshot.data!.data![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.0,
                      ),
                    ),
                    child:  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  
                                  
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                      Text(
                                        "${reviewsData.user_name}",
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4.0),
                                        Text(
  DateFormat('MMMM dd, yyyy').format(DateTime.parse(reviewsData.createdAt.toString())),
  style: const TextStyle(
    color: Colors.grey,
  ),
),
                                      // const Text(
                                      //   'March 10, 2023',
                                      //   style: TextStyle(
                                      //     color: Colors.grey,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                               buildStarRating(reviewsData.stars ?? 0),
                             
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          const Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In aliquam ultrices arcu ac feugiat. Suspendisse eget sem eget ex sodales commodo. Nullam eget dolor vel tellus tristique vehicula. Mauris iaculis sem eu quam tempor, vel luctus nibh ullamcorper. Aenean id ex risus. Morbi efficitur sed libero non consequat. Nam vitae arcu nisi. Cras facilisis tristique dolor eget auctor. Sed bibendum lobortis augue, eu lacinia magna feugiat eget. In ullamcorper purus massa, sit amet gravida nisl aliquet vitae. Mauris euismod eros ac blandit elementum. Praesent semper euismod turpis, vel iaculis dolor consectetur eget. Fusce dapibus sapien quis orci efficitur, a congue lorem laoreet.',
                            style: TextStyle(
                              fontSize: 16.0,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
     );
            },
             ),
        ],
      ),
    );
  }
}
