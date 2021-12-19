import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

int currentIndex = 0;

class BottomNavCanvas extends StatefulWidget {
  const BottomNavCanvas({Key? key}) : super(key: key);

  @override
  _BottomNavCanvasState createState() => _BottomNavCanvasState();
}

class _BottomNavCanvasState extends State<BottomNavCanvas> {
  Color color = Colors.greenAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: SafeArea(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.height / 3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Center(
              child: Text(
                'CUSTOM\nBOTTOM\nNAV BAR',
                style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
            ),
          ),
        ),
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            color = Colors.redAccent;
          });
        },
        child: const Icon(Icons.location_on),
      ),
      bottomNavigationBar: BottomNavWidget(
        onTap: (index) {
          setState(() {
            color = Colors.grey;
          });
        },
        items: [
          NavigationBarItem(
              icon: IconButton(
                  onPressed: () {
                    setState(() {
                      color = Colors.amberAccent;
                    });
                  },
                  icon: Icon(
                    CupertinoIcons.circle,
                    size: 28,
                  )),
              selectedIcon: CupertinoIcons.list_bullet),
          NavigationBarItem(
              icon: IconButton(
                  onPressed: () {
                    setState(() {
                      color = Colors.blueAccent;
                    });
                  },
                  icon: Icon(CupertinoIcons.app, size: 28,)),
              selectedIcon: CupertinoIcons.square_split_2x2_fill),
        ],
        currentIndex: currentIndex,
      ),
    );
  }
}

class NavigationBarItem {
  final IconButton icon;
  final IconData selectedIcon;

  NavigationBarItem({required this.icon, required this.selectedIcon});
}

class BottomNavWidget extends StatefulWidget {
  const BottomNavWidget({
    Key? key,
    required this.items,
    required this.onTap,
    this.currentIndex = 0,
  })  : assert(items.length == 2, ''),
        super(key: key);

  final List<NavigationBarItem> items;
  final ValueChanged<int> onTap;
  final int currentIndex;

  @override
  _BottomNavWidgetState createState() => _BottomNavWidgetState();
}

class _BottomNavWidgetState extends State<BottomNavWidget> {
  @override
  Widget build(BuildContext context) {
    var navPainter = _NavPainter();
    return CustomPaint(
      painter: navPainter,
      child: Container(
        height: 65,
        child: Row(
          children: List.generate(
            widget.items.length,
            (index) => Expanded(
                child: IconButton(
              onPressed: () {},
              icon: widget.items[index].icon,
              color: currentIndex == index ? Theme.of(context).primaryColor : null,
            )),
          )..insert(1, const Spacer()),
        ),
      ),
    );
  }
}

class _NavPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final h5 = h * .5;
    final w5 = w * .5;
    final h6 = h * .6;

    final path = Path()
      ..lineTo(w5 - 80, 0)
      ..cubicTo((w5 - 40), 0, (w5 - 50), h5, w5 - 3, h6)
      ..lineTo(w5, h)
      ..lineTo(w, h)
      ..lineTo(w, 0)
      ..lineTo(w5 + 80, 0)
      ..cubicTo((w5 + 40), 0, (w5 + 50), h5, w5 + 3, h6)
      ..lineTo(w5 - 3, h6)
      ..lineTo(w5, h)
      ..lineTo(0, h);

    canvas.drawShadow(path, Colors.black26, 10, false);
    canvas.drawPath(path, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
