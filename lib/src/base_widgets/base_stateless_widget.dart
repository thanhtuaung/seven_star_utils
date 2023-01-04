part of seven_star_utils;

abstract class BaseStatelessPage extends StatelessWidget with BaseWidget {
  BaseStatelessPage({Key? key}) : super(key: key);

  late BuildContext appContext;

  @override
  Widget build(BuildContext context) {
    // ConstantDimension(context);
    appContext = context;
    init();

    return SafeArea(
      child: Scaffold(
        appBar: appBarTitle() != null || appBarActions() != null
            ? AppBar(
                title: Text(appBarTitle() ?? ''),
                centerTitle: true,
                actions: appBarActions(),
              )
            : null,
        body: Padding(
          padding: appPadding(),
          child: body(context),
        ),
        persistentFooterButtons: persistentButtons(),
        floatingActionButton: floatingActionButton(),
        bottomNavigationBar: bottomNavigationBar(),
      ),
    );
  }
}
