import SwiftUI

struct HistorialReportesDiaView: View {

    @ObservedObject var viewModel: ReporteViewModel

    // reportes SOLO de hoy
    private var reportesHoy: [Reporte] {
        let hoy = Calendar.current.startOfDay(for: Date())
        return viewModel.reportes.filter {
            Calendar.current.isDate($0.fecha, inSameDayAs: hoy)
        }
    }

    private var totalGanancias: Double {
        reportesHoy.filter { $0.monto > 0 }.map { $0.monto }.reduce(0, +)
    }

    private var totalGastos: Double {
        reportesHoy.filter { $0.monto < 0 }.map { abs($0.monto) }.reduce(0, +)
    }

    var body: some View {
        ZStack {

            Image("fondologin")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 0) {

                VStack {
                    Text("📋 REPORTE DEL DÍA")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding(16)
                        .frame(maxWidth: .infinity)
                }
                .background(Color.AzulOscuro)
                .cornerRadius(12)
                .shadow(radius: 6)
                .padding(16)

                ScrollView {
                    VStack {
                        if reportesHoy.isEmpty {
                            Text("No hay reportes hoy")
                                .foregroundColor(.gray)
                                .padding()
                        } else {
                            ForEach(reportesHoy) { reporte in
                                ReporteItemView(reporte: reporte)
                            }
                        }
                    }
                }

                Text("Ganancias: S/\(totalGanancias, specifier: "%.2f")  |  Gastos: S/\(totalGastos, specifier: "%.2f")")
                    .font(.system(size: 16, weight: .bold))
                    .padding(12)

                Spacer(minLength: 8)
            }
            .frame(maxWidth: 370)
        }
        .onAppear {
            viewModel.cargarReportes()
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}
