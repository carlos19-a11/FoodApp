import 'package:flutter/material.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  DateTime _selectedDate = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;

  // Mapa de estados y sus colores asociados
  final Map<String, Color> _statusColors = {
    'Pendiente': Colors.orange,
    'En Proceso': Colors.blue,
    'Completado': Colors.green,
  };

  @override
  Widget build(BuildContext context) {
    final restaurant = context.watch<Restaurant>();
    final orders = restaurant.orders;

    final filteredOrders = orders
        .where((order) =>
            _formatDate(order['date']) ==
            DateFormat('dd-MM-yyyy').format(_selectedDate))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Pedidos del ${DateFormat('dd-MM-yyyy').format(_selectedDate)}'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                'Pedidos: ${filteredOrders.length}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              focusedDay: _selectedDate,
              firstDay: DateTime(2024, 1, 1),
              lastDay: DateTime(2030, 12, 31),
              calendarFormat: _calendarFormat,
              availableCalendarFormats: const {
                CalendarFormat.month: 'Mes',
                CalendarFormat.twoWeeks: '2 Semanas',
                CalendarFormat.week: 'Semana'
              },
              headerStyle: const HeaderStyle(
                formatButtonVisible: true,
                titleCentered: true,
              ),
              selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDate = selectedDay;
                });
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
            ),
            const SizedBox(height: 10),
            Text(
              'Fecha seleccionada: ${DateFormat('dd-MM-yyyy').format(_selectedDate)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: filteredOrders.isEmpty
                  ? const Center(child: Text("No hay pedidos para esta fecha."))
                  : ListView.builder(
                      itemCount: filteredOrders.length,
                      itemBuilder: (context, index) {
                        final order = filteredOrders[index];

                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Pedido #${index + 1}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    DropdownButton<String>(
                                      value: order['status'],
                                      items: _statusColors.keys
                                          .map((status) => DropdownMenuItem(
                                                value: status,
                                                child: Text(
                                                  status,
                                                  style: TextStyle(
                                                    color:
                                                        _statusColors[status],
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      onChanged: order['status'] == 'Completado'
                                          ? null
                                          : (newStatus) {
                                              if (newStatus != null) {
                                                restaurant.updateOrderStatus(
                                                    order['id'], newStatus);
                                              }
                                            },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                    'Fecha del Pedido: ${_formatDateWithTime(order['date'])}'),
                                const SizedBox(height: 8),
                                // Mostrar mesa o "Ninguna" si no hay mesa seleccionada
                                Text(
                                  'Mesa: ${order['table'] == null || order['table'] == '' ? 'Ninguna' : order['table']}',
                                ),

                                const SizedBox(height: 8),
                                Text('Artículos:',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: (order['items'] as List)
                                      .map<Widget>((item) {
                                    if (item is String) {
                                      return Text('- $item');
                                    } else if (item is Map<String, dynamic>) {
                                      final name = item['name'];
                                      final description =
                                          item['description'] ?? ' descripción';
                                      final addons =
                                          item['addons'] as List? ?? [];

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              name,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(description),
                                            if (addons.isNotEmpty)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16.0),
                                                child: Text(
                                                  'Adicionales: ${addons.join(', ')}',
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                          ],
                                        ),
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  }).toList(),
                                ),
                                const SizedBox(height: 8),
                                Text('Total: ${_formatPrice(order['total'])}'),
                                if (order['status'] == 'Completado' &&
                                    order.containsKey('completedTime')) ...[
                                  const SizedBox(height: 8),
                                  Text(
                                    'Hora de Completado: ${order['completedTime']}',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateWithTime(String date) {
    final DateTime parsedDate = DateFormat('yyyy-MM-dd hh:mm a').parse(date);
    return DateFormat('dd-MM-yyyy HH:mm').format(parsedDate);
  }

  String _formatPrice(double price) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'es_CO',
      symbol: '\$',
      decimalDigits: 0,
      customPattern: '\u00A4 #,###',
    );
    return currencyFormatter.format(price);
  }

  String _formatDate(String date) {
    final DateTime parsedDate = DateFormat('yyyy-MM-dd hh:mm a').parse(date);
    return DateFormat('dd-MM-yyyy').format(parsedDate);
  }
}
