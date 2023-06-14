import 'package:flutter/material.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  State<MyProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<MyProfileScreen> {
  var color = 0xFF800000;
  final double coverHeight = 130;
  final double profileHeight = 124;
  bool isEnabled = false;

  TextEditingController name = TextEditingController()..text = "Suhah Amir";
  TextEditingController number = TextEditingController()..text = "030012345678";
  TextEditingController email = TextEditingController()
    ..text = "std_25956@iobm.edu.pk";
  TextEditingController password = TextEditingController()
    ..text = 'Change Password';

  @override
  Widget build(BuildContext context) {
    final top = coverHeight - profileHeight / 2;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true, // Center the title
        backgroundColor: Color(0xFF800000),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                BuildCoverImage(),
                Positioned(top: top, child: BuildProfileImage())
              ],
            ),
            SizedBox(
              height: top,
            ),

            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 15.0),
            //   child: Card(
            //   color: Color(0xff453658),
            //   elevation: 8,
            //   child: Icon(Icons.edit,color: Colors.white,)
            // ),
            // ),

            Container(
                margin: EdgeInsets.only(right: 20),
                alignment: Alignment.topRight,
                child: button(
                  Icons.edit,
                )),

            SizedBox(
              height: 20,
            ),

            //Container(child: Row(children: [Text('4.5', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0 ),),SizedBox(width: 5,), Icon(Icons.star, color: Colors.yellow[700],)],),),
            BuildUserRecord(name, Icons.person, Icons.edit),
            BuildUserRecord(email, Icons.email, Icons.edit),
            BuildUserRecord(number, Icons.call, Icons.edit),
            BuildUserRecord(password, Icons.lock, Icons.edit),

            SizedBox(
              height: 10,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      // Icon(Icons.star, color: Colors.yellow[700],),
                      // SizedBox(width: 5,),
                      // Text('4.9 Average Rating', style: TextStyle(color: Color(0xFF800000), fontWeight: FontWeight.bold, fontSize: 20.0 ),
                      // ),
                    ],
                  ),
                  // SizedBox(height: 5,),
                  // Container(
                  //     margin: EdgeInsets.only(left: 40),
                  //     child: Text('4.7 Timeliness',style: TextStyle(color: Colors.white, fontSize: 15.0 ))),
                  // SizedBox(height: 5,),
                  // Container(
                  //     margin: EdgeInsets.only(left: 40),
                  //     child: Text('4.9 Communication',style: TextStyle(color: Colors.white, fontSize: 15.0 ))),
                  // SizedBox(height: 5,),
                  // Container(
                  //     margin: EdgeInsets.only(left: 40),
                  //     child: Text('5.0 safety',style: TextStyle(color: Colors.white, fontSize: 15.0 ))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget BuildCoverImage() => Container(
        color: Color(color),
        height: coverHeight + 15,
        width: double.infinity,
      );

  Widget BuildUserRecord(TextEditingController controller, IconData leadingIcon,
          IconData trailingIcon) =>
      Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0),
        child: Card(
            color: Color(0xFF800000),
            elevation: 8,
            child: ListTile(
              title: TextField(
                enabled: isEnabled,
                controller: controller,
                style: TextStyle(color: Colors.white),
              ),
              leading: Icon(
                leadingIcon,
                color: Colors.white,
              ),
              //trailing: button(trailingIcon, title),
            )),
      );
  Widget BuildProfileImage() => CircleAvatar(
        radius: 65,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          backgroundImage: AssetImage('images/avatar.png'),
          radius: profileHeight / 2,
        ),
      );

  Widget button(IconData icon) => ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(color)),
            elevation: MaterialStateProperty.all(10),
            padding:
                MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10))),
        onPressed: () {
          setState(() {
            isEnabled = true;
          });
        },
        child: Icon(icon, color: Colors.white),
      );

  openDialog(String title) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit'),
          content: TextField(
            onChanged: (value) {},
            decoration: InputDecoration(hintText: title),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () {
                setState(() {
                  name = name;
                  Navigator.pop(context);
                });
              },
              child: Text('OK'),
            ),
          ],
        );
      });
}
