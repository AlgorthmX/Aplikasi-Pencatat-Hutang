import 'package:flutter/material.dart';

class ChipWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onClick;
  const ChipWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onClick,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            // color: Colors.grey.withOpacity(.2),
            color: color.withOpacity(.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.black.withOpacity(.5),
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
