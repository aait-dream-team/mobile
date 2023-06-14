import 'package:bus_navigation/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Shimmer.fromColors(
            baseColor: AppColors.shimmerColor,
            highlightColor: AppColors.shimmerColor,
            enabled: true,
            child: one_shimmer(width: width),
          ),
        ),
      ],
    );
  }
}

class one_shimmer extends StatelessWidget {
  const one_shimmer({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, __) => Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   width: 48.0,
            //   height: 48.0,
            //   color: AppColors.white,
            // ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    child: Container(
                      width: width * 0.95,
                      height: 80.0,
                      color: AppColors.white,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                  ),
                  Container(
                    width: width * 0.5,
                    height: 8.0,
                    color: AppColors.white,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                  ),
                  Container(
                    width: 40.0,
                    height: 8.0,
                    color: AppColors.white,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      itemCount: 10,
    );
  }
}
