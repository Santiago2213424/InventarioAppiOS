import SwiftUI

struct EditarProveedorView: View {

    let proveedor: Proveedor
    @ObservedObject var viewModel: ProveedorViewModel

    @State private var nombreProveedor: String
    @State private var numeroProveedor: String

    @Environment(\.dismiss) private var dismiss

    init(proveedor: Proveedor, viewModel: ProveedorViewModel) {
        self.proveedor = proveedor
        self.viewModel = viewModel
        _nombreProveedor = State(initialValue: proveedor.nombre)
        _numeroProveedor = State(initialValue: proveedor.telefono)
    }

    var body: some View {
        ZStack {

            Image("fondologin")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 16) {

                // HEADER
                Text("EDITAR PROVEEDOR")
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

                        Text("Editar Proveedor")
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
                                guardarCambios()
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
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func guardarCambios() {
        let proveedorEditado = Proveedor(
            id: proveedor.id,
            nombre: nombreProveedor,
            telefono: numeroProveedor
        )

        viewModel.actualizarProveedor(proveedorEditado)
        dismiss()
    }
}
