import SwiftUI

struct HistorialReportesFechaView: View {

    @ObservedObject var viewModel: ReporteViewModel

    @State private var fechaSeleccionada = Date()
    @State private var aplicarFiltro = false

    var reportesFiltrados: [Reporte] {
        if !aplicarFiltro {
            return viewModel.reportes
        }

        return viewModel.reportes.filter {
            Calendar.current.isDate($0.fecha, inSameDayAs: fechaSeleccionada)
        }
    }

    var body: some View {
        ZStack {

            Image("fondologin")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 0) {

                VStack {
                    Text("📊 REPORTES POR FECHA")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .padding(12)
                        .frame(maxWidth: .infinity)
                }
                .background(Color.AzulOscuro)
                .cornerRadius(12)
                .shadow(radius: 6)
                .padding(12)

                // FILTRO CON CALENDARIO
                HStack(spacing: 12) {

                    DatePicker(
                        "",
                        selection: $fechaSeleccionada,
                        displayedComponents: .date
                    )
                    .labelsHidden()
                    .datePickerStyle(.compact)
                    .background(Color.white)
                    .cornerRadius(8)

                    Button("Filtrar") {
                        aplicarFiltro = true
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.AzulOscuro)
                    .cornerRadius(8)

                    Button("Limpiar") {
                        aplicarFiltro = false
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(Color.gray)
                    .cornerRadius(8)
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 12)

                // LISTA
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(reportesFiltrados) { reporte in
                            ReporteItemView(reporte: reporte)
                        }
                    }
                }

                // TOTALES
                Text(
                    "Ganancias: S/\(totalGanancias(), specifier: "%.2f")   |   Gastos: S/\(totalGastos(), specifier: "%.2f")"
                )
                .font(.system(size: 16, weight: .bold))
                .padding(12)
            }
            .frame(maxWidth: 370)
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if viewModel.reportes.isEmpty {
                viewModel.cargarReportes()
            }
        }
    }

    private func totalGanancias() -> Double {
        reportesFiltrados
            .filter { $0.monto > 0 }
            .map { $0.monto }
            .reduce(0, +)
    }

    private func totalGastos() -> Double {
        reportesFiltrados
            .filter { $0.monto < 0 }
            .map { abs($0.monto) }
            .reduce(0, +)
    }
}
