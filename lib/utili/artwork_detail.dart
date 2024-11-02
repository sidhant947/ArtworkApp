// import 'package:flutter/material.dart';
// import 'artwork.dart'; // Ensure this import

// class ArtworkDetail extends StatelessWidget {
//   final Artwork artwork;

//   const ArtworkDetail({Key? key, required this.artwork}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(artwork.title),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             artwork.imageUrl.isNotEmpty
//                 ? Image.network(artwork.imageUrl)
//                 : Container(height: 200, color: Colors.grey), // Placeholder for no image
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     artwork.title.isNotEmpty ? artwork.title : 'No Title',
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Artist: ${artwork.artistDisplayName.isNotEmpty ? artwork.artistDisplayName : 'Unknown Artist'}',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Date: ${artwork.dateDisplay.isNotEmpty ? artwork.dateDisplay : 'Unknown Date'}',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     artwork.description ?? 'No description available.',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'artwork.dart';

class ArtworkDetail extends StatelessWidget {
  final Artwork artwork;

  ArtworkDetail({required this.artwork});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(artwork.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: artwork.imageUrl.isNotEmpty
                    ? Image.network(artwork.imageUrl)
                    : Icon(Icons.image_not_supported, size: 100),
              ),
              SizedBox(height: 20),
              Text(
                artwork.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                artwork.artistDisplayName,
                style: TextStyle(fontSize: 20),
              ),
              // Add more details here as needed
            ],
          ),
        ),
      ),
    );
  }
}
