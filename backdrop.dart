import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'login.dart';
import 'model/product.dart';

// TODO: Add velocity constant (104)
const double _kFlingVelocity = 2.0;
class Backdrop extends StatefulWidget {

  final Category currentCategory;

  final Widget frontLayer;

  final Widget backLayer;

  final Widget frontTitle;

  final Widget backTitle;

  const Backdrop({

    required this.currentCategory,

    required this.frontLayer,

    required this.backLayer,

    required this.frontTitle,

    required this.backTitle,

    Key? key,

  }) : super(key: key);

  @override

  _BackdropState createState() => _BackdropState();

}

// TODO: Add _FrontLayer class (104)

// TODO: Add _BackdropTitle class (104)

// TODO: Add _BackdropState class (104)
class _BackdropState extends State<Backdrop> with SingleTickerProviderStateMixin {

  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');

// TODO: Add AnimationController widget (104)
  late AnimationController _controller;
// TODO: Add BuildContext and BoxConstraints parameters to _buildStack (104)
  @override
  bool get _frontLayerVisible {

    final AnimationStatus status = _controller.status;

    return status == AnimationStatus.completed ||

        status == AnimationStatus.forward;

  }

  void _toggleBackdropLayerVisibility() {

    _controller.fling(

        velocity: _frontLayerVisible ? -_kFlingVelocity : _kFlingVelocity

    );

  }
  void initState() {

    super.initState();

    _controller = AnimationController(

      duration: Duration(milliseconds: 300),

      value: 1.0,

      vsync: this,

    );

  }

// TODO: Add override for didUpdateWidget (104)

  @override

  void dispose() {

    _controller.dispose();

    super.dispose();

  }
  @override

  void didUpdateWidget(Backdrop old) {

    super.didUpdateWidget(old);

    if (widget.currentCategory != old.currentCategory) {

      _toggleBackdropLayerVisibility();

    } else if (! _frontLayerVisible) {

      _controller.fling(velocity: _kFlingVelocity);

    }

  }

// TODO: Add functions to get and change front layer visibility (104)
  Widget _buildStack(BuildContext context, BoxConstraints constraints) {

    const double layerTitleHeight = 48.0;

    final Size layerSize = constraints.biggest;

    final double layerTop = layerSize.height - layerTitleHeight;

// TODO: Create a RelativeRectTween Animation (104)

    Animation<RelativeRect> layerAnimation = RelativeRectTween(

      begin: RelativeRect.fromLTRB(

          0.0, layerTop, 0.0, layerTop - layerSize.height),

      end: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),

    ).animate(_controller.view);

    return Stack(

      key: _backdropKey,

      children: <Widget>[

// TODO: Wrap backLayer in an ExcludeSemantics widget (104)

        ExcludeSemantics(

          child: widget.backLayer,

          excluding: _frontLayerVisible,

        ),

// TODO: Add a PositionedTransition (104)

        PositionedTransition(

          rect: layerAnimation,

            child: _FrontLayer(
              key: UniqueKey(),
            // TODO: Implement onTap property on _BackdropState (104)
              onTap: _toggleBackdropLayerVisibility,
              child: widget.frontLayer,

            ),
          ),



      ],

    );

  }

  @override

  Widget build(BuildContext context) {

    var appBar = AppBar(

      elevation: 0.0,

      titleSpacing: 0.0,

// TODO: Replace leading menu icon with IconButton (104)


// TODO: Remove leading property (104)

// TODO: Create title with _BackdropTitle parameter (104)
      title: _BackdropTitle(

        listenable: _controller.view,

        onPress: _toggleBackdropLayerVisibility,

        frontTitle: widget.frontTitle,

        backTitle: widget.backTitle,

      ),



      actions: <Widget>[

// TODO: Add shortcut to login screen from trailing icons (104)

        IconButton(

          icon: Icon(

            Icons.search,

            semanticLabel: 'login',

          ),

          onPressed: () {
    Navigator.push(

    context,

    MaterialPageRoute(builder: (BuildContext context) => LoginPage()),

    );

// TODO: Add open login (104)

          },

        ),

        IconButton(

          icon: Icon(

            Icons.tune,

            semanticLabel: 'login',

          ),

          onPressed: () {
            Navigator.push(

              context,

              MaterialPageRoute(builder: (BuildContext context) => LoginPage()),

            );
// TODO: Add open login (104)

          },

        ),

      ],

    );

    return Scaffold(

      appBar: appBar,

// TODO: Return a LayoutBuilder widget (104)

      body: LayoutBuilder(builder: _buildStack),

    );

  }

}


class _FrontLayer extends StatelessWidget {

// TODO: Add on-tap callback (104)

  const _FrontLayer({

    required Key key,

    required this.onTap, // New code

    required this.child,

  }) : super(key: key);

      final VoidCallback onTap; // New code

      final Widget child;
  @override

  Widget build(BuildContext context) {

    return Material(

      elevation: 16.0,

      shape: const BeveledRectangleBorder(

        borderRadius: BorderRadius.only(topLeft: Radius.circular(46.0)),

      ),

              child: Column(

              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: <Widget>[

              // TODO: Add a GestureDetector (104)

              GestureDetector(

              behavior: HitTestBehavior.opaque,

              onTap: onTap,

              child: Container(

              height: 40.0,

              alignment: AlignmentDirectional.centerStart,

              ),

              ),

              Expanded(

              child: child,

              ),

              ],

              ),

    );

  }

}
class _BackdropTitle extends AnimatedWidget {
  final Function onPress;
  final Widget frontTitle;
  final Widget backTitle;

  const _BackdropTitle({
    Key? key,
    required Listenable listenable,
    required this.onPress,
    required this.frontTitle,
    required this.backTitle,
  }) : super(key: key, listenable: listenable);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;


    return DefaultTextStyle(
      style: Theme.of(context).primaryTextTheme.headline6!,

      softWrap: false,
      overflow: TextOverflow.ellipsis,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 72.0,
            child: IconButton(
              padding: const EdgeInsets.only(right: 8.0),
              onPressed: () => onPress(),
              icon: Stack(
                children: <Widget>[
                  Opacity(
                    opacity: animation.value,
                    child: ImageIcon(AssetImage('assets/slanted_menu.png')),
                  ),
                  FractionalTranslation(
                    translation: Tween<Offset>(
                      begin: Offset.zero,
                      end: const Offset(1.0, 0.0),
                    ).evaluate(animation),
                    child: ImageIcon(AssetImage('assets/diamond.png')),
                  ),
                ],
              ),
            ),
          ),
          Stack(
            children: <Widget>[
              Opacity(
                opacity: CurvedAnimation(
                  parent: ReverseAnimation(animation),
                  curve: const Interval(0.5, 1.0),
                ).value,
                child: FractionalTranslation(
                  translation: Tween<Offset>(
                    begin: Offset.zero,
                    end: const Offset(0.5, 0.0),
                  ).evaluate(animation),
                  child: backTitle,
                ),
              ),
              Opacity(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: const Interval(0.5, 1.0),
                ).value,
                child: FractionalTranslation(
                  translation: Tween<Offset>(
                    begin: const Offset(-0.25, 0.0),
                    end: Offset.zero,
                  ).evaluate(animation),
                  child: frontTitle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
