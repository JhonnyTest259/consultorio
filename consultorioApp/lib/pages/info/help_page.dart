import 'package:consultorio/models/Item.dart';
import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final List<Item> items = [
    Item("¿Qué es una tutela?",
        "La tutela es una relación legal que permite que una persona natural o jurídica se haga responsable por otra. Existen distintos tipos de tutela. Algunas son designadas por testamento mientras que otras personas son nombradas tutoras por el Tribunal."),
    Item("¿Qué es un consultorio juridico?",
        "El Consultorio Jurídico busca la defensa del interés general, su armonización con los intereses particulares y con los fines del Estado Social de Derecho, propendiendo por la justicia y la equidad en la sociedad."),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          toolbarHeight: 80.0,
          centerTitle: true,
          elevation: 14.0,
          backgroundColor: Color.fromARGB(255, 112, 6, 0),
          title: const Text(
            'CONSULTORIO',
            style: TextStyle(fontSize: 35.0),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Color(0xFFD10934), Color(0xFF7A0C29)]),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ExpansionPanelList(
          expansionCallback: (index, isExpanded) {
            setState(() {
              items[index].isExpanded = !isExpanded;
            });
          },
          children: items
              .map((item) => ExpansionPanel(
                  canTapOnHeader: true,
                  isExpanded: item.isExpanded!,
                  headerBuilder: ((context, isExpanded) => ListTile(
                        title: Text(
                          item.header!,
                          style: const TextStyle(fontSize: 20),
                        ),
                      )),
                  body: ListTile(
                    title: Text(
                      item.body!,
                      style: const TextStyle(fontSize: 15),
                    ),
                  )))
              .toList(),
        ),
      ),
    );
  }
}
