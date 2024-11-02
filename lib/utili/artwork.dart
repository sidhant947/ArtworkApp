// class Artwork {
//   final String title;
//   final String artistDisplayName;
//   final String dateDisplay;
//   final String imageUrl;
//   final String? description;

//   Artwork({
//     required this.title,
//     required this.artistDisplayName,
//     required this.dateDisplay,
//     required this.imageUrl,
//     this.description,
//   });

//   factory Artwork.fromJson(Map<String, dynamic> json) {
//     return Artwork(
//       title: json['title'] ?? 'No title available',
//       artistDisplayName: json['artist_display'] ?? 'Unknown Artist',
//       dateDisplay: json['date_display'] ?? 'Unknown Date',
//       imageUrl: json['image_id'] != null
//           ? 'https://www.artic.edu/iiif/2/${json['image_id']}/full/843,/0/default.jpg' // Adjust this URL based on the API
//           : '',
//       description: json['description'] ?? 'No description available.',
//     );
//   }
// }
class Artwork {
  final String title;
  final String artistDisplayName;
  final String imageUrl;

  Artwork({
    required this.title,
    required this.artistDisplayName,
    required this.imageUrl,
  });

  factory Artwork.fromJson(Map<String, dynamic> json) {
    return Artwork(
      title: json['title'] ?? 'No Title',
      artistDisplayName: json['artist_display'] ?? 'Unknown Artist',
      imageUrl: json['image_id'] != null
          ? 'https://www.artic.edu/iiif/2/${json['image_id']}/full/843,/0/default.jpg'
          : '',
    );
  }
}
