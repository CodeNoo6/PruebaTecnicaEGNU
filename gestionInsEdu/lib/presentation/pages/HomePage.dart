import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../domain/entities/Municipality.dart';
import '../../domain/entities/Institution.dart';
import '../../domain/entities/Campus.dart';
import '../../domain/services/CampusService.dart';
import '../../domain/services/InstitutionsService.dart';
import '../../domain/services/MunicipalitiesService.dart';
import 'GroupDetailsPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Municipality>? municipios;
  List<Institution>? institutions;
  List<Campus>? sedes;
  Municipality? selectedMunicipality;
  Institution? selectedInstitution;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final result =
        await MunicipalityRepository.postMunicipalities('user', 'password');
    setState(() {
      municipios = result;
    });
  }

  void fetchInstitutions(String codMun) async {
    setState(() {
      institutions = null;
      selectedInstitution = null;
    });
    final result = await InstitutionsRepository.postInstitutions(codMun);
    setState(() {
      institutions = result;
    });
  }

  void fetchCampus(String CodInst) async {
    final result = await CampusRepository.postCampus(CodInst);
    setState(() {
      sedes = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 230, 244, 253),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Center(
              child: Text(
                "¡Bienvenido/a!",
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15,),
            Center(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Selecciona los datos a consultar",
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            DropdownSearch<Municipality>(
              mode: Mode.MENU,
              showSelectedItems: false,
              items: municipios ?? [],
              dropdownSearchDecoration: InputDecoration(
                labelText: "Municipios",
                labelStyle: GoogleFonts.aBeeZee(
                  fontWeight: FontWeight.bold,
                  textStyle: TextStyle(
                    color: HexColor("213D52"),
                    fontSize: 16,
                  ),
                ),
                hintText: "Selecciona el municipio",
                hintStyle: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              ),
              popupItemDisabled: (Municipality municipality) => isItemDisabled(municipality.name),
              onChanged: (Municipality? municipality) {
                setState(() {
                  selectedMunicipality = municipality;
                  institutions = null;
                  sedes = null;
                });
                if (municipality != null) {
                  fetchInstitutions(municipality.dane);
                }
              },
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                cursorColor: Colors.blue,
              ),
              itemAsString: (Municipality? mun) => mun!.name,
            ),
            SizedBox(height: 20),
            DropdownSearch<Institution>(
              key: UniqueKey(),
              mode: Mode.MENU,
              showSelectedItems: false,
              items: institutions ?? [],
              dropdownSearchDecoration: InputDecoration(
                labelText: "Instituciones",
                labelStyle: GoogleFonts.aBeeZee(
                  fontWeight: FontWeight.bold,
                  textStyle: TextStyle(
                    color: HexColor("213D52"),
                    fontSize: 16,
                  ),
                ),
                hintText: "Selecciona la institución",
                hintStyle: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              ),
              onChanged: (Institution? institution) {
                setState(() {
                  selectedInstitution = institution;
                  sedes = null;
                });
                if (institution != null) {
                  fetchCampus(institution.dane);
                }
              },
              selectedItem: selectedInstitution,
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                cursorColor: Colors.blue,
              ),
              itemAsString: (Institution? inst) => inst!.name,
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "Sedes asociadas",
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
            if (sedes != null)
              Column(
                children:
                    sedes!.map((sede) => buildSedeCard(context, sede)).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildSedeCard(BuildContext context, Campus sede) {
    return Card(
      child: ListTile(
        title: Text(sede.name, style: GoogleFonts.aBeeZee(
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),),
        trailing: Icon(Icons.arrow_forward, color: HexColor("213D52"),),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SedeDetailPage(sede: sede)),
          );
        },
      ),
    );
  }

  bool isItemDisabled(String name) {
    if (name.startsWith('I')) {
      return true;
    } else {
      return false;
    }
  }
}