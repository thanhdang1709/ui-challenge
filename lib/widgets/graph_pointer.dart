import 'package:flutter/material.dart';

class GraphPainter extends CustomPainter {
  List<Offset> nodes;
  double margin;
  Color color;
  double lineWidth;
  double nodeRadius;

  GraphPainter(this.nodes,
      {this.margin = 18.0,
      this.color = Colors.black,
      this.lineWidth = 7.0,
      this.nodeRadius = 8.0});

  @override
  void paint(Canvas canvas, Size size) {
    Paint nodePaint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = nodeRadius;

    Paint linePaint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = lineWidth;

    for (int i = 0; i < nodes.length; i++) {
      if (i < nodes.length - 1) {
        // Tính toán vị trí bắt đầu và kết thúc
        Offset start = Offset(nodes[i].dx, nodes[i].dy);
        Offset end = Offset(nodes[i + 1].dx, nodes[i + 1].dy);
        // Tính toán vector từ start đến end
        Offset vector = end - start;
        // Chuẩn hóa vector để có chiều dài bằng margin
        vector = vector / vector.distance * margin;
        // Điều chỉnh vị trí bắt đầu và kết thúc
        start = start + vector;
        end = end - vector;

        canvas.drawLine(
          start,
          end,
          linePaint,
        );
      }
      canvas.drawCircle(nodes[i], nodeRadius, nodePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
