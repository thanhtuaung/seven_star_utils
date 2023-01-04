part of seven_star_utils;

class ActionResultDialog extends StatefulWidget {
  const ActionResultDialog({
    Key? key,
    required this.dialogType,
    this.label,
    this.onPressed,
  }) : super(key: key);

  final DialogType dialogType;
  final String? label;
  final VoidCallback? onPressed;

  @override
  State<ActionResultDialog> createState() => _ActionResultDialogState();
}

class _ActionResultDialogState extends State<ActionResultDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late String label;
  int dialogTypeNumber = 1;

  @override
  void initState() {
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 350), vsync: this)
      ..forward();

    label = widget.label ??
        (widget.dialogType == DialogType.success
            ? 'Success!!'
            : widget.dialogType == DialogType.warning
                ? "Warning!!"
                : 'Fail!!');

    dialogTypeNumber = widget.dialogType == DialogType.success
        ? 1
        : widget.dialogType == DialogType.fail
            ? 2
            : 3;

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0, end: 1).animate(_animationController),
      child: Center(
        child: Card(
          color: Colors.white,
          child: Container(
            width: ConstantDimensions.deviceWidth * 0.7,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Expanded(
                  // flex: 4,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: (dialogTypeNumber == 1
                              ? Colors.greenAccent
                              : dialogTypeNumber == 2
                                  ? Colors.red
                                  : Colors.yellow)
                          .withOpacity(0.8),
                    ),
                    child: dialogTypeNumber == 1
                        ? successWidget()
                        : dialogTypeNumber == 2
                            ? errorIconWidget()
                            : warningWidget(),
                  ),
                ),
                Expanded(
                  // flex: 3,
                  child: Container(
                    // decoration: BoxDecoration(
                    //   color: Colors.red.withOpacity(0.4),
                    // ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          label,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _animationController.reverse();
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: dialogTypeNumber == 1
                                ? Colors.greenAccent
                                : dialogTypeNumber == 2
                                    ? Colors.redAccent
                                    : Colors.yellowAccent,
                          ),
                          child: Text('Ok'),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget successWidget() {
    return const CircleAvatar(
      radius: 45,
      backgroundColor: Colors.white,
      child: Icon(
        Icons.done,
        color: Colors.green,
        size: 50,
      ),
    );
  }

  Widget errorIconWidget() {
    return const Icon(
      Icons.error,
      size: 90,
      color: Colors.white,
    );
  }

  Widget warningWidget() {
    return const Icon(
      Icons.warning,
      size: 90,
      color: Colors.white,
    );
  }
}
