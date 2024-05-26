import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  final String avatarUrl;
  final String userName;
  final String comment;
  final int rating;
  final DateTime commentTime;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final bool isShowUpdate;

  const CommentWidget({
    super.key,
    required this.avatarUrl,
    required this.userName,
    required this.comment,
    required this.rating,
    required this.commentTime,
    required this.onDelete,
    required this.onEdit,
    required this.isShowUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(avatarUrl),
            radius: 25.0,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    isShowUpdate == true
                        ? Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, size: 20),
                                onPressed: onEdit,
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, size: 20),
                                onPressed: onDelete,
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  comment,
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  _formatCommentTime(commentTime),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatCommentTime(DateTime dateTime) {
    final Duration difference = DateTime.now().difference(dateTime);
    if (difference.inDays > 0) {
      return '${difference.inDays} ngày trước';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} phút trước';
    } else {
      return 'Vừa xong';
    }
  }
}
