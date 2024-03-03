import 'package:event_management/ViewModel/AppStrings/image_path.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';

class CustomStreamBuilder extends StatelessWidget {
  final Stream<QuerySnapshot<Object?>>? stream;
  final Widget Function(QuerySnapshot) builder;
  const CustomStreamBuilder({
    super.key,
    required this.builder,
    this.stream,
  });
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Lottie.asset(ImagePathUtils
              .shimmer); // Show loading indicator while fetching data
        } else if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
        }
        if (snapshot.data!.docs.isEmpty) {
          return Lottie.asset(ImagePathUtils.empty);
        }

        return builder(snapshot.data!);
      },
    );
  }
}
