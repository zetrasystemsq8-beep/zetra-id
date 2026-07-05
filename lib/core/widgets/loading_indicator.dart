import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final String? message;
  final double size;

  const LoadingIndicator({
    super.key,
    this.message,
    this.size = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: const CircularProgressIndicator(
              strokeWidth: 4,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00B894)),
            ),
          ),
          if (message != null) ...[const SizedBox(height: 16)],
          if (message != null)
            Text(
              message!,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 14,
              ),
            ),
        ],
      ),
    );
  }
}
