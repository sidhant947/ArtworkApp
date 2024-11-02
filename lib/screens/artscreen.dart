import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app/utili/artwork.dart';
import 'package:app/utili/artwork_detail.dart';

class ArtScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ArtworksList();
  }
}

class ArtworksList extends StatefulWidget {
  @override
  _ArtworksListState createState() => _ArtworksListState();
}

class _ArtworksListState extends State<ArtworksList> {
  List<Artwork> artworks = [];
  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchArtworks(); // Initial fetch
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !isLoading &&
        hasMore) {
      fetchArtworks();
    }
  }

  Future<void> fetchArtworks() async {
    if (isLoading || !hasMore) return;

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(
          'https://api.artic.edu/api/v1/artworks?page=$currentPage&limit=10'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> artworksJson = jsonResponse['data'];

        if (artworksJson.isEmpty) {
          setState(() {
            hasMore = false;
          });
        } else {
          setState(() {
            artworks.addAll(
                artworksJson.map((json) => Artwork.fromJson(json)).toList());
            currentPage++;
          });
        }
      } else {
        throw Exception('Failed to load artworks');
      }
    } catch (error) {
      print('Error fetching artworks: $error');
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> refreshArtworks() async {
    setState(() {
      currentPage = 1; // Reset to the first page
      artworks.clear(); // Clear existing artworks
      hasMore = true; // Reset hasMore
    });
    await fetchArtworks(); // Fetch artworks again
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose the ScrollController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Artwork"),
        centerTitle: true,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: refreshArtworks,
        child: ListView.builder(
          itemCount: artworks.length +
              (hasMore ? 1 : 0), // Add a loader at the end if more items
          itemBuilder: (context, index) {
            if (index == artworks.length) {
              // Loader for loading more items
              return Center(child: CircularProgressIndicator());
            }

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
                    builder: (context) => ArtworkDetail(artwork: artwork),
                  ),
                );
              },
            );
          },
          controller: _scrollController,
        ),
      ),
    );
  }
}
