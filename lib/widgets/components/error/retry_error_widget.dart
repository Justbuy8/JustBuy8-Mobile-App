import 'package:flutter/material.dart';
import 'package:justbuyeight/constants/app_images.dart';
import 'package:lottie/lottie.dart';

class RetryErrorWidget extends StatefulWidget {
  final String errorMessage;
  final VoidCallback? onRetry;

  const RetryErrorWidget({
    Key? key,
    required this.errorMessage,
    this.onRetry,
  }) : super(key: key);

  @override
  State<RetryErrorWidget> createState() => _RetryErrorWidgetState();
}

class _RetryErrorWidgetState extends State<RetryErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(LottieAssets.error),
          const SizedBox(height: 16),
          Text(
            widget.errorMessage,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: widget.onRetry ?? () {},
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
