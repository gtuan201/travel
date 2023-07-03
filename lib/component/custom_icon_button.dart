import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIconButton extends StatelessWidget {
  final String iconPath,title;
  final Color color;

  const CustomIconButton(
      {super.key, required this.iconPath, required this.color, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 86,
      height: 90,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Center(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.2,
                        blurRadius: 4,
                      )
                    ]),
                child: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    iconPath,
                    color: color,
                    width: 24.0,
                    height: 24.0,
                  ),
                ),
              ),
              const SizedBox(height: 6,),
              Text(
                title,
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}
