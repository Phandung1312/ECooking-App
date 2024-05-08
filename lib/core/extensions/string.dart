import 'dart:core';

extension StringExtension on String {
  String formatTimeAgo() {
    final date = DateTime.parse(this).toLocal();
    final now = DateTime.now();

    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} giây trước';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} phút trước';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ngày trước';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).round();
      return '$weeks tuần trước';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).round();
      return '$months tháng trước';
    } else {
      final years = (difference.inDays / 365).round();
      return '$years năm trước';
    }
  }
}
