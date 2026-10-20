import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../providers/giveaway_provider.dart';

import '../models/model_give_aways.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    _scroller.addListener(() {
      if (_scroller.position.pixels < 500) {
        setState(() {
          _showButton = false;
        });
      } else {
        setState(() {
          _showButton = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Game Giveaways")),
      body: _buildBody(),
      floatingActionButton: _showButton ? _buildFloating() : null,
    ); // Scaffold
  }

  Widget _buildBody() {
    final giveawayAsync = ref.watch(giveawayNotifierProvider);

    return Center(
      child: RefreshIndicator(
        onRefresh: () async {
          ref.read(giveawayNotifierProvider.notifier).refreshGiveaways();
        },
        child: giveawayAsync.when(
          data: (items) {
            return _buildGridView(items);
          },
          error: (e, s) {
            debugPrint("Error: ${e.toString()}");
            debugPrint("TrackTrace: ${s.toString()}");
            return Text("Error: ${e.toString()}");
          },
          loading: () {
            return _buildSkeleton();
          },
        ),
      ), // RefreshIndicator
    ); // Center
  }

  Widget _buildFloating() {
    return FloatingActionButton(
      shape: CircleBorder(),
      onPressed: () {
        _scroller.animateTo(
          0,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
      child: Icon(Icons.arrow_upward),
    ); // FloatingActionButton
  }

  Widget _buildSkeleton() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
        highlightColor: isDark ? Colors.grey.shade500 : Colors.grey.shade100,
      ),
      child: GridView.builder(
        itemCount: 40,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
        ), // SliverGridDelegateWithFixedCrossAxisCount
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: .circular(8),
                      child: Container(
                        color: Colors.grey.shade400,
                      ), // Container
                    ), // ClipRRect
                  ), // Padding
                ), // Expanded
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("asdsadasd sadassa", maxLines: 1, overflow: .ellipsis),
                ), // Padding
              ],
            ), // Column
          ); // Card
        },
      ), // GridView.builder
    ); // Skeletonizer
  }

  final _scroller = ScrollController();

  Widget _buildGridView(List<ModelGiveAways> items) {
    if (items.isEmpty) {
      return Text("No Items");
    }

    return GridView.builder(
      controller: _scroller,
      physics: BouncingScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
      ), // SliverGridDelegateWithFixedCrossAxisCount
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildItem(item);
      },
    ); // GridView.builder
  }

  Widget _buildItem(ModelGiveAways item) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/detail', arguments: item.id);
        },
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: .circular(8),
                  child: CachedNetworkImage(
                    imageUrl: item.thumbnail,
                    fit: .cover,
                    width: double.maxFinite,
                  ), // CachedNetworkImage
                ), // ClipRRect
              ), // Padding
            ), // Expanded
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(item.title, maxLines: 1, overflow: .ellipsis),
            ), // Padding
          ],
        ), // Column
      ), // InkWell
    ); // Card
  }
}
