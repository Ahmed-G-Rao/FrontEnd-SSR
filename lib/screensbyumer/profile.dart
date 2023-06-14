// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class DrawerProfileScreen extends StatefulWidget {
//   const DrawerProfileScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _DrawerProfileScreenState createState() => _DrawerProfileScreenState();
// }

// class _DrawerProfileScreenState extends State<DrawerProfileScreen> {
//   bool _isDrawerOpen = false;
//   File? _image;
//   final ImagePicker _picker = ImagePicker();

//   Future<void> _getImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       }
//     });
//   }

//   void _toggleDrawer() {
//     setState(() {
//       _isDrawerOpen = !_isDrawerOpen;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.person),
//           onPressed: _toggleDrawer,
//         ),
//         title: const Text('Drawer Profile Screen'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const CircleAvatar(
//               radius: 50,
//               backgroundImage: NetworkImage('https://picsum.photos/200/300'),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _getImage,
//               child: const Text('Upload picture'),
//             ),
//             const SizedBox(height: 32),
//             const Text(
//               'John Doe',
//               style: TextStyle(fontSize: 24),
//             ),
//             const SizedBox(height: 8),
//             const Text(
//               'john.doe@example.com',
//               style: TextStyle(fontSize: 18),
//             ),
//             const SizedBox(height: 8),
//             const Text(
//               '+1 (555) 123-4567',
//               style: TextStyle(fontSize: 18),
//             ),
//             const SizedBox(height: 32),
//             ElevatedButton(
//               onPressed: () {},
//               child: const Text('Edit Profile'),
//             ),
//           ],
//         ),
//       ),
//       endDrawer: Drawer(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             DrawerHeader(
//               child: Column(
//                 children: [
//                   const CircleAvatar(
//                     radius: 50,
//                     backgroundImage:
//                         NetworkImage('https://picsum.photos/200/300'),
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: _getImage,
//                     child: const Text('Upload picture'),
//                   ),
//                   const SizedBox(height: 32),
//                   const Text(
//                     'John Doe',
//                     style: TextStyle(fontSize: 24),
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     'john.doe@example.com',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     '+1 (555) 123-4567',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 ],
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.edit),
//               title: const Text('Edit Profile'),
//               onTap: () {},
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
