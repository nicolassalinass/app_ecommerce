import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraficLinear extends StatefulWidget {
  const GraficLinear({super.key});

  @override
  State<GraficLinear> createState() => _GraficLinearState();
}

class _GraficLinearState extends State<GraficLinear> {
  // Datos de ejemplo: ingresos mensuales en millones de Guaraníes
  List<FlSpot> get ingresosData => [
    const FlSpot(0, 1.2),   // Enero - 1.5 M
    const FlSpot(1, 2.3),   // Febrero - 2.3 M
    const FlSpot(2, 1.8),   // Marzo - 1.8 M
    const FlSpot(3, 2.8),   // Abril - 2.8 M
    const FlSpot(4, 5.3),   // Mayo - 3.2 M
    const FlSpot(5, 2.9),   // Junio - 2.9 M
    const FlSpot(6, 3.5),   // Julio - 3.5 M
    const FlSpot(7, 4.0),   // Agosto - 4.0 M
    const FlSpot(8, 1.2),   // Septiembre - 3.8 M
    const FlSpot(9, 4.2),   // Octubre - 4.2 M
    const FlSpot(10, 4.5),  // Noviembre - 4.5 M
    const FlSpot(11, 5.0),  // Diciembre - 5.0 M
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 350,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              horizontalInterval: 1,
              verticalInterval: 1,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey.withValues(alpha: 0.3),
                  strokeWidth: 1,
                );
              },
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Colors.grey.withValues(alpha: 0.3),
                  strokeWidth: 1,
                );
              },
            ),
            titlesData: FlTitlesData(
              show: true,
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  interval: 1,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    const style = TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    );
                    String text;
                    switch (value.toInt()) {
                      case 0:
                        text = 'Ene';
                        break;
                      case 1:
                        text = 'Feb';
                        break;
                      case 2:
                        text = 'Mar';
                        break;
                      case 3:
                        text = 'Abr';
                        break;
                      case 4:
                        text = 'May';
                        break;
                      case 5:
                        text = 'Jun';
                        break;
                      case 6:
                        text = 'Jul';
                        break;
                      case 7:
                        text = 'Ago';
                        break;
                      case 8:
                        text = 'Sep';
                        break;
                      case 9:
                        text = 'Oct';
                        break;
                      case 10:
                        text = 'Nov';
                        break;
                      case 11:
                        text = 'Dic';
                        break;
                      default:
                        text = '';
                        break;
                    }
                    return Text(text, style: style);
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  reservedSize: 60,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    const style = TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    );
                    return Text('Gs. ${value.toStringAsFixed(0)} M',
                        style: style,
                        textAlign: TextAlign.left);
                  },
                ),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: Colors.grey.withValues(alpha: 0.5)),
            ),
            minX: 0,
            maxX: 11,
            minY: 0,
            maxY: 6,
            lineBarsData: [
              LineChartBarData(
                spots: ingresosData,
                isCurved: true,
                gradient: LinearGradient(
                  colors: [
                    Colors.blue,
                    Colors.lightBlueAccent,
                  ],
                ),
                barWidth: 4,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 4,
                      color: Colors.blue,
                      strokeWidth: 2,
                      strokeColor: Colors.white,
                    );
                  },
                ),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.withValues(alpha: 0.3),
                      Colors.lightBlueAccent.withValues(alpha: 0.1),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ],
            lineTouchData: LineTouchData(
              enabled: true,
              touchTooltipData: LineTouchTooltipData(
                getTooltipColor: (touchedSpot) => Colors.blueAccent.withValues(alpha: 0.8),
                getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                  return touchedBarSpots.map((barSpot) {
                    final flSpot = barSpot;
                    const months = [
                      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
                      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
                    ];
                    return LineTooltipItem(
                      '${months[flSpot.x.toInt()]}\nGs. ${flSpot.y.toStringAsFixed(1)} M',
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }).toList();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
