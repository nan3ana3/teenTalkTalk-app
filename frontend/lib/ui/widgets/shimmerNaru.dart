part of 'widgets.dart';

class ShimmerNaru extends StatelessWidget {
  const ShimmerNaru({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: const Color(0xFFF3F3F3),
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.grey[200]),
      ),
    );
  }
}
