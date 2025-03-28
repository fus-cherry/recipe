import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ListContainer extends StatefulWidget {
  const ListContainer({super.key});

  @override
  State<ListContainer> createState() => _ListContainerState();
}

class _ListContainerState extends State<ListContainer>
    with TickerProviderStateMixin {
  // 定义一个列表，存储要加载的图片索引
  final List<int> _imageIndices =
      List.generate(20, (index) => Random().nextInt(20));

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: MasonryGridView.count(
        crossAxisCount: 2, // 每行显示两列
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemCount: _imageIndices.length,
        itemBuilder: (context, index) {
          // 使用 CachedNetworkImage 加载图片
          return _buildBox(
              "https://picsum.photos/1080/0?random=${_imageIndices[index]}");
        },
      ),
    );
  }

  Widget _buildBox(String imageUrl) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (context, url) => SpinKitSquareCircle(
            color: Colors.white,
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
