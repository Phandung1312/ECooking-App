import 'dart:core';

extension StringExtension on String {
  String formatTimeAgo() {
    try{
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
    } catch(e) {
      return '';
    }
  }
  String formatTimeWithDate() {
    final date = DateTime.parse(this).toLocal();
    final now = DateTime.now();

    final difference = now.difference(date);

    if (difference.inDays > 1) {
      return '${date.day} tháng ${date.month}, ${date.year}';
    } else if (difference.inHours < 24 && difference.inHours > 0) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inMinutes < 60 && difference.inMinutes > 0) {
      return '${difference.inMinutes} phút trước';
    } else {
      return '${difference.inSeconds} giây trước';
    }
  }
  String formatDate() {
    final date = DateTime.parse(this).toLocal();
    return '${date.day}/${date.month}/${date.year}';
  }
}
