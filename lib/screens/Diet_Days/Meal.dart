import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterexcercisesforcancerapp/screens/Recipe.dart';
import 'package:flutterexcercisesforcancerapp/constants.dart';

class Meal extends StatefulWidget {
  final int which;
  final int index;
  final int bbstart;
  Meal(this.which, this.index, this.bbstart);
  @override
  _MealState createState() => _MealState();
}

class _MealState extends State<Meal> {
  int _bb;

  suggestNew() {
    setState(() {
      if (_bb == listrecipes[widget.which].length - 1) {
        _bb = 0;
      } else {
        _bb += 1;
      }
    });
  }

  Color _colorContainer = const Color(0xFFffd4e6);

  @override
  void initState() {
    super.initState();
    // NOTE: Calling this function here would crash the app.
    setState(() {
      _bb = widget.bbstart;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Ink(
          child: InkWell(
        child: Container(
          color: _colorContainer,
          height: 75,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xFFCF268A),
              child: Text('${widget.index}'),
              foregroundColor: Colors.white,
            ),
            title: Text("${listrecipes[widget.which][_bb]['name']}",
                style: TextStyle(color: Colors.grey[850])),
            subtitle: Text("${listrecipes[widget.which][_bb]['shortdesc']}",
                style: TextStyle(color: const Color(0xFF4f4f4f))),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Details(_bb)),
          );
        },
      )),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Suggest new',
          color: Colors.black45,
          icon: Icons.more_horiz,
          onTap: () => suggestNew(),
        ),
        IconSlideAction(
          caption: 'Eaten/Uneaten',
          color: Colors.red,
          icon: Icons.swap_horiz_rounded,
          onTap: () {
            setState(() {
              _colorContainer = _colorContainer == Color(0xFFff83ad)
                  ? const Color(0xFFffd4e6)
                  : const Color(0xFFff83ad);
            });
          },
        ),
      ],
    );
  }
}