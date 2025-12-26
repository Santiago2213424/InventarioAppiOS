import SwiftUI

struct AgregarProveedorView: View {

    @ObservedObject var viewModel: ProveedorViewModel

    @State private var nombreProveedor = ""
    @State private var numeroProveedor = ""

    @State private var mostrarAlerta = false
    @State private var mensajeAlerta = ""

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {

            Image("fondologin")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 16) {

                // HEADER
                Text("AGREGAR PROVEEDOR")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background(Color.AzulOscuro)
                    .cornerRadius(12)
                    .shadow(radius: 6)

                Image("imageninicio")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 180)
                    .clipped()
                    .cornerRadius(12)
                    .shadow(radius: 4)

                ScrollView {
                    VStack(spacing: 20) {

                        Text("Nuevo Proveedor")
                            .font(.system(size: 19, weight: .bold))
                            .foregroundColor(Color.AzulOscuro)

                        TextField("Nombre del proveedor", text: $nombreProveedor)
                            .padding(14)
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.AzulOscuro, lineWidth: 1)
                            )

                        TextField("Número de contacto", text: $numeroProveedor)
                            .keyboardType(.phonePad)
                            .padding(14)
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.AzulOscuro, lineWidth: 1)
                            )

                        HStack(spacing: 12) {

                            Button("Cancelar") {
                                dismiss()
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(12)
                            .background(Color.red)
                            .cornerRadius(10)

                            Button("Guardar") {
                                guardarProveedor()
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(12)
                            .background(Color.AzulOscuro)
                            .cornerRadius(10)
                        }
                    }
                    .padding(24)
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(radius: 8)
                }
            }
            .padding(20)
            .frame(maxWidth: 370)
        }
        .alert("Error", isPresented: $mostrarAlerta) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(mensajeAlerta)
        }
    }

    private func guardarProveedor() {

        let nombre = nombreProveedor.trimmingCharacters(in: .whitespacesAndNewlines)
        let telefono = numeroProveedor.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !nombre.isEmpty else {
            mensajeAlerta = "El nombre no puede estar vacío"
            mostrarAlerta = true
            return
        }

        guard !telefono.isEmpty else {
            mensajeAlerta = "El teléfono no puede estar vacío"
            mostrarAlerta = true
            return
        }

        let nuevoProveedor = Proveedor(
            nombre: nombre,
            telefono: telefono
        )

        viewModel.agregarProveedor(nuevoProveedor)
        dismiss()
    }
}
