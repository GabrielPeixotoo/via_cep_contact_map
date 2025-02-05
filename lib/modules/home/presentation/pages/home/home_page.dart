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
    mapsFuture.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(target: latLng, zoom: 16)),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        appBar: HomePageAppBar(homeController: controller),
        body: ValueListenableBuilder<HomeState>(
          valueListenable: controller,
          builder: (_, state, __) {
            if (state is LoadingState) {
              return const CircularProgressIndicator();
            } else if (state is SuccessState) {
              final contacts = controller.isFiltering() ? state.filteredContacts : state.contacts;
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _SearchWidget(
                              controller: controller,
                              callback: () => setState(() {}),
                            )),
                        Visibility(
                          visible: contacts.isNotEmpty,
                          replacement: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(alignment: Alignment.topCenter, child: Text(controller.emptyStateString())),
                          ),
                          child: Expanded(
                            child: ListView.builder(
                              itemCount: contacts.length,
                              itemBuilder: (context, index) {
                                final contact = contacts[index];
                                return ContactCard(
                                  homeController: controller,
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
                      ],
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

class _SearchWidget extends StatelessWidget {
  final HomeController controller;
  final VoidCallback callback;
  const _SearchWidget({required this.controller, required this.callback});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: CustomTextField(
              label: 'Filtro por nome ou CPF',
              controller: controller.queryTextController,
              onChanged: (_) => controller.onChangedSearch(),
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.clear,
                  color: AppColors.black,
                ),
                onPressed: () {
                  controller.clearInput();
                  callback();
                },
              ),
            ),
          ),
          IconButton(
              onPressed: controller.changeFilter,
              icon: const Icon(
                Icons.filter_list_outlined,
                size: 48,
                color: AppColors.black,
              ))
        ],
      );
}
