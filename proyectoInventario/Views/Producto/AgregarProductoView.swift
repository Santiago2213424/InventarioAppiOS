import SwiftUI

struct AgregarProductoView: View {

    let categoria: Categoria
    @ObservedObject var viewModel: ProductoViewModel

    @State private var nombre = ""
    @State private var cantidad = ""
    @State private var precio = ""

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {

            Image("fondologin")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 16) {

                    Text("AGREGAR PRODUCTO")
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

                    VStack(spacing: 16) {

                        Text("Nuevo Producto")
                            .font(.system(size: 19, weight: .bold))
                            .foregroundColor(Color.AzulOscuro)

                        TextField("Nombre del Producto", text: $nombre)
                            .padding(14)
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.AzulOscuro, lineWidth: 1)
                            )

                        TextField("Cantidad", text: $cantidad)
                            .keyboardType(.numberPad)
                            .padding(14)
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.AzulOscuro, lineWidth: 1)
                            )

                        TextField("Precio", text: $precio)
                            .keyboardType(.decimalPad)
                            .padding(14)
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.AzulOscuro, lineWidth: 1)
                            )
                        
                        // btns
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
                                guardarProducto()
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
                .padding(20)
                .frame(maxWidth: 370)
            }
        }
    }

    private func guardarProducto() {
        guard
            let cantidadInt = Int(cantidad),
            let precioDouble = Double(precio),
            !nombre.isEmpty
        else {
            return
        }

        let nuevoProducto = Producto(
            nombre: nombre,
            cantidad: cantidadInt,
            precio: precioDouble,
            categoriaId: categoria.id
        )

        viewModel.agregarProducto(nuevoProducto)
        dismiss()
    }
}
