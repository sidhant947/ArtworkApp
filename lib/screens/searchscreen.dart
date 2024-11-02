import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app/utili/artwork.dart'; // Ensure you have this import
import 'package:app/utili/artwork_detail.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Artwork> artworks = [];
  String query = '';
  bool isLoading = false;

  Future<void> fetchArtworks(String query) async {
    if (query.isEmpty) {
      setState(() {
        artworks.clear();
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(
          'https://api.artic.edu/api/v1/artworks/search?q=$query&fields=id,title,artist_display,image_id'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> artworksJson = jsonResponse['data'];

        setState(() {
          artworks =
              artworksJson.map((json) => Artwork.fromJson(json)).toList();
        });

        if (artworks.isEmpty) {
          print('No artworks found for the query.');
        }
      } else {
        throw Exception('Failed to load artworks');
      }
    } catch (error) {
      print(error);
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Artworks'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                query = value;
                fetchArtworks(query);
              },
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : artworks.isEmpty
                    ? Center(child: Text('Search for Artworks.'))
                    : ListView.builder(
                        itemCount: artworks.length,
                        itemBuilder: (context, index) {
                          final artwork = artworks[index];
                          return ListTile(
                            title: Text(artwork.title),
                            subtitle: Text(artwork.artistDisplayName),
                            leading: artwork.imageUrl.isNotEmpty
                                ? Image.network(artwork.imageUrl,
                                    width: 50, fit: BoxFit.cover)
                                : Icon(Icons.image_not_supported),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ArtworkDetail(artwork: artwork),
                                ),
                              );
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
