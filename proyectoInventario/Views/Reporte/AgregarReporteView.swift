import SwiftUI

struct AgregarReporteView: View {

    @ObservedObject var viewModel: ReporteViewModel

    @State private var detalle = ""
    @State private var monto = ""
    @State private var tipoSeleccionado = "Ingreso"

    @State private var mostrarAlerta = false
    @State private var mensajeAlerta = ""

    // navegación
    @State private var irReporteDia = false
    @State private var irReporteFecha = false

    let tipos = ["Ingreso", "Gasto"]

    var body: some View {
        ZStack {

            Image("fondologin")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 0) {

                VStack {
                    Text("📝 AGREGAR REPORTE")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding(16)
                        .frame(maxWidth: .infinity)
                }
                .background(Color.AzulOscuro)
                .cornerRadius(12)
                .shadow(radius: 6)
                .padding(16)

                VStack(spacing: 12) {

                    TextField("Detalle", text: $detalle)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)

                    TextField("Monto", text: $monto)
                        .keyboardType(.decimalPad)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)

                    Picker("Tipo", selection: $tipoSeleccionado) {
                        ForEach(tipos, id: \.self) { tipo in
                            Text(tipo)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.top, 8)

                    // GUARDAR
                    Button("Guardar") {
                        guardarReporte()
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .background(Color.AzulOscuro)
                    .cornerRadius(8)
                    .padding(.top, 8)

                    // BOTONES REPORTES
                    Button {
                        irReporteDia = true
                    } label: {
                        Text("📅 Ver Reportes de Hoy")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .background(Color.green)
                            .cornerRadius(8)
                    }

                    Button {
                        irReporteFecha = true
                    } label: {
                        Text("📆 Ver Historial por Fecha")
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .background(Color.yellow)
                            .cornerRadius(8)
                    }
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(radius: 4)
                .padding(.horizontal, 16)

                Spacer()
            }
            .frame(maxWidth: 370)
        }
        // navegacion
        .navigationDestination(isPresented: $irReporteDia) {
            HistorialReportesDiaView(viewModel: viewModel)
        }
        .navigationDestination(isPresented: $irReporteFecha) {
            HistorialReportesFechaView(viewModel: viewModel)
        }
        .alert("Error", isPresented: $mostrarAlerta) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(mensajeAlerta)
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func guardarReporte() {

        let detalleLimpio = detalle.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !detalleLimpio.isEmpty else {
            mensajeAlerta = "El detalle no puede estar vacío."
            mostrarAlerta = true
            return
        }

        guard let montoDouble = Double(monto), montoDouble > 0 else {
            mensajeAlerta = "El monto debe ser un número válido."
            mostrarAlerta = true
            return
        }

        let montoFinal = tipoSeleccionado == "Gasto"
            ? -montoDouble
            : montoDouble

        let nuevoReporte = Reporte(
            detalle: detalleLimpio,
            fecha: Date(),
            monto: montoFinal
        )

        viewModel.agregarReporte(nuevoReporte)

        irReporteDia = true
    }
}
