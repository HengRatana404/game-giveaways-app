import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../models/model_give_aways.dart';
import '../providers/giveaway_provider.dart';

class DetailScreen extends ConsumerStatefulWidget {
  const DetailScreen({super.key});

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as int;
    final detailAsync = ref.watch(giveawayDetailProvider(id));

    return Scaffold(
      appBar: AppBar(title: Text("Detail Screen")),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(giveawayDetailProvider);
        },
        child: Center(
          child: detailAsync.when(
            data: (item) {
              return _buildListView(item);
            },
            error: (e, s) {
              debugPrint("Error: ${e.toString()}");
              debugPrint("TrackTrace: ${s.toString()}");
              return Text("Error: ${e.toString()}");
            },
            loading: () {
              return CircularProgressIndicator();
            },
          ),
        ), // Center
      ), // RefreshIndicator
    ); // Scaffold
  }

  Widget _buildListView(ModelGiveAways item) {
    return ListView(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: .circular(8),
              child: CachedNetworkImage(
                imageUrl: item.image,
                fit: .cover,
                width: double.maxFinite,
              ), // CachedNetworkImage
            ), // ClipRRect
          ), // Padding
        ), // Card
        Card(
          child: ListTile(
            leading: Icon(Icons.title),
            title: Text(item.title),
          ), // ListTile
        ), // Card
        Card(
          child: ListTile(
            title: Text(item.description),
          ), // ListTile
        ), // Card
        Card(
          child: ListTile(
            title: Text(item.instructions),
          ), // ListTile
        ), // Card
        Card(
          child: ListTile(
            leading: Icon(Icons.attach_money),
            title: Text(item.worth),
          ), // ListTile
        ), // Card
        Card(
          child: ListTile(
            leading: Icon(Icons.category),
            title: Text(item.type),
          ), // ListTile
        ), // Card
        Card(
          child: ListTile(
            leading: Icon(Icons.devices),
            title: Text(item.platforms),
          ), // ListTile
        ), // Card
        Card(
          child: ListTile(
            leading: Icon(Icons.people),
            title: Text("${item.users} users"),
          ), // ListTile
        ), // Card
        Card(
          child: ListTile(
            leading: Icon(Icons.event),
            title: Text("${item.publishedDate}  →  ${item.endDate}"),
          ), // ListTile
        ), // Card
      ],
    ); // ListView
  }
}
