import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../shared/shared.dart';
import '../../../home.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = InjectionContainer.instance.get<HomeController>();
  final Completer<GoogleMapController> _mapsController = Completer<GoogleMapController>();

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(-25.460093853672447, -49.27537864691069),
    zoom: 14.4746,
  );
  @override
  void initState() {
    super.initState();
    controller.fetchContacts();
  }

  void _focusOnContactMarker(LatLng latLng) async {
    final mapsFuture = await _mapsController.future;
    mapsFuture.animateCamera(CameraUpdate.newLatLng(latLng));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        appBar: AppBar(
          title: const Text(
            'Gerenciamento de contatos',
            style: AppTextTheme.subtitle1,
          ),
          centerTitle: true,
          backgroundColor: AppColors.blue,
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: controller.logout,
                child: const Text('Sair'))
          ],
        ),
        body: ValueListenableBuilder<HomeState>(
          valueListenable: controller,
          builder: (_, state, __) {
            if (state is LoadingState) {
              return const CircularProgressIndicator();
            } else if (state is SuccessState) {
              final contacts = state.contacts;
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Visibility(
                      visible: contacts.isNotEmpty,
                      replacement: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Align(alignment: Alignment.topCenter, child: Text('Cadastre um contato.')),
                      ),
                      child: ListView.builder(
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          final contact = contacts[index];
                          return ContactCard(
                            contact: contact,
                            markerCallback: () => _focusOnContactMarker(LatLng(
                              contact.addressEntity.latitude ?? _initialPosition.target.latitude,
                              contact.addressEntity.longitude ?? _initialPosition.target.longitude,
                            )),
                          );
                        },
                      ),
                    ),
                  ),
                  const VerticalDivider(
                    width: 20,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Expanded(
                    flex: 3,
                    child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: _initialPosition,
                        markers: contacts
                            .map((contact) => Marker(
                                markerId: MarkerId(contact.cpf),
                                position: LatLng(contact.addressEntity.latitude ?? _initialPosition.target.latitude,
                                    contact.addressEntity.longitude ?? _initialPosition.target.longitude)))
                            .toSet(),
                        onMapCreated: (GoogleMapController controller) {
                          _mapsController.complete(controller);
                        }),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.openCreateContactDialog,
          tooltip: 'Criar contato',
          child: const Icon(Icons.add),
        ),
      );
}
