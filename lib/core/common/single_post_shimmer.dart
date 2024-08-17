import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SinglePostShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final baseColor = Colors.grey[800]!;
    final highlightColor = Colors.grey[600]!;

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(47.0),
          child: AppBar(
            title: Shimmer.fromColors(
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: Container(
                height: 20,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Theme.of(context).canvasColor,
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    color: Theme.of(context).canvasColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 7),
                          child: Row(
                            children: [
                              Shimmer.fromColors(
                                baseColor: baseColor,
                                highlightColor: highlightColor,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: baseColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Shimmer.fromColors(
                                      baseColor: baseColor,
                                      highlightColor: highlightColor,
                                      child: Container(
                                        width: double.infinity,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          color: baseColor,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Shimmer.fromColors(
                                      baseColor: baseColor,
                                      highlightColor: highlightColor,
                                      child: Container(
                                        width: 100,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          color: baseColor,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Shimmer.fromColors(
                            baseColor: baseColor,
                            highlightColor: highlightColor,
                            child: Container(
                              width: double.infinity,
                              height: 20,
                              decoration: BoxDecoration(
                                color: baseColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Shimmer.fromColors(
                          baseColor: baseColor,
                          highlightColor: highlightColor,
                          child: Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              color: baseColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Shimmer.fromColors(
                                    baseColor: baseColor,
                                    highlightColor: highlightColor,
                                    child: Container(
                                      width: 50,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: baseColor,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Shimmer.fromColors(
                                    baseColor: baseColor,
                                    highlightColor: highlightColor,
                                    child: Container(
                                      width: 50,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: baseColor,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Shimmer.fromColors(
                                    baseColor: baseColor,
                                    highlightColor: highlightColor,
                                    child: Container(
                                      width: 70,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: baseColor,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 1,
                          color: Colors.white54,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Shimmer.fromColors(
                            baseColor: baseColor,
                            highlightColor: highlightColor,
                            child: Container(
                              width: 150,
                              height: 20,
                              decoration: BoxDecoration(
                                color: baseColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Divider(
                          height: 1,
                          color: Colors.white54,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                baseColor: baseColor,
                                highlightColor: highlightColor,
                                child: ListTile(
                                  title: Container(
                                    height: 15,
                                    decoration: BoxDecoration(
                                      color: baseColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  subtitle: Container(
                                    height: 10,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: baseColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  trailing: Container(
                                    height: 12,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: baseColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
