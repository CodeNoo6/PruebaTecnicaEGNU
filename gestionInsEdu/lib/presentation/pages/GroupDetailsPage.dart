import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gestioninsedu/domain/entities/Group.dart';
import 'package:gestioninsedu/domain/responseObjects/InfoGroupResponse.dart';
import 'package:gestioninsedu/domain/services/GroupService.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../domain/entities/Campus.dart';

class SedeDetailPage extends StatefulWidget {
  final Campus sede;

  const SedeDetailPage({Key? key, required this.sede}) : super(key: key);

  @override
  _SedeDetailPageState createState() => _SedeDetailPageState();
}

class _SedeDetailPageState extends State<SedeDetailPage> {
  List<Group>? grupos;

  @override
  void initState() {
    super.initState();
    fetchGroups();
  }

  void fetchGroups() async {
    final result = await GroupRepository.postGroups(widget.sede.dane);
    setState(() {
      grupos = result;
    });
  }

  Future<void> showGroupInfo(Group group) async {
    InfoGroupResponse? info = await GroupRepository.getGroupById(group.id);
    if (info != null) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Center(
                  child: Text(
                    "Información de grupo",
                    style: GoogleFonts.aBeeZee(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    Text('Identificación: ', style: GoogleFonts.aBeeZee(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )),
                    Text('${info.id}', style: GoogleFonts.aBeeZee(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    )),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text('Nombre: ', style: GoogleFonts.aBeeZee(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: '${info.name}',
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text('Sede: ', style: GoogleFonts.aBeeZee(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: '${info.campus}',
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text('Institución: ', style: GoogleFonts.aBeeZee(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: '${info.institution}',
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text('Municipio: ', style: GoogleFonts.aBeeZee(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: '${info.municipality}',
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text('Numero de grupo: ', style: GoogleFonts.aBeeZee(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )),
                    Text('${info.numGroup}', style: GoogleFonts.aBeeZee(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    )),
                  ],
                ),
                // Agrega más información del grupo según lo necesites
              ],
            ),
          );
        },
      );
    } else {
      // Manejar el caso en el que no se pueda obtener la información del grupo
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 230, 244, 253),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "SEDE - " + widget.sede.name,
          style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black, // Color del icono de flecha hacia atrás
          ),
          onPressed: () {
            Navigator.pop(context); // Pop la página actual para volver atrás
          },
        ),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Grupos asociados",
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            if (grupos != null)
              Expanded(
                child: ListView.builder(
                  itemCount: grupos!.length,
                  itemBuilder: (context, index) {
                    return buildGroupCard(grupos![index]);
                  },
                ),
              ),
            if (grupos == null)
              CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  Widget buildGroupCard(Group group) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        child: ListTile(
          title: Text(group.name, style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          )),
          trailing: Icon(Icons.search, color: HexColor("213D52"),),
          onTap: () {
            showGroupInfo(group);
          },
        ),
      ),
    );
  }
}
