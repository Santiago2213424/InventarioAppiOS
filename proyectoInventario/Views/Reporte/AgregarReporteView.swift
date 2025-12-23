import SwiftUI

struct AgregarReporteView: View {

    @State private var nombre = ""
    @State private var monto = ""
    @State private var tipoSeleccionado = "Ingreso"

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

                    TextField("Nombre del producto o gasto", text: $nombre)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)

                    TextField("Monto", text: $monto)
                        .keyboardType(.decimalPad)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)

                    // Tipo
                    Picker("Tipo", selection: $tipoSeleccionado) {
                        ForEach(tipos, id: \.self) { tipo in
                            Text(tipo)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.top, 8)

                    Button(action: {
                        // lógica guardar (mock)
                    }) {
                        Text("Guardar")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .background(Color.AzulOscuro)
                            .cornerRadius(8)
                    }
                    .padding(.top, 8)

                    NavigationLink {
                        HistorialReportesDiaView()
                    } label: {
                        Text("📅 Ver Reportes de Hoy")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .background(Color.green)
                            .cornerRadius(8)
                    }
                    .padding(.top, 4)


                    NavigationLink {
                        HistorialReportesFechaView()
                    } label: {
                        Text("📆 Ver Historial por Fecha")
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .background(Color.yellow)
                            .cornerRadius(8)
                    }
                    .padding(.top, 4)


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
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AgregarReporteView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AgregarReporteView()
        }
    }
}
