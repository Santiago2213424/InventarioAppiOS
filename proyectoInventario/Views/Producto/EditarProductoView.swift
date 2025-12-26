import SwiftUI

struct EditarProductoView: View {

    let producto: Producto
    let categoria: Categoria
    @ObservedObject var viewModel: ProductoViewModel

    @State private var nombre: String
    @State private var cantidad: String
    @State private var precio: String

    @Environment(\.dismiss) private var dismiss

    init(
        producto: Producto,
        categoria: Categoria,
        viewModel: ProductoViewModel
    ) {
        self.producto = producto
        self.categoria = categoria
        self.viewModel = viewModel

        _nombre = State(initialValue: producto.nombre)
        _cantidad = State(initialValue: String(producto.cantidad))
        _precio = State(initialValue: String(format: "%.2f", producto.precio))
    }

    var body: some View {
        ZStack {

            Image("fondologin")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 16) {

                // HEADER
                VStack {
                    Text("EDITAR PRODUCTO")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding(16)
                        .frame(maxWidth: .infinity)
                }
                .background(Color.AzulOscuro)
                .cornerRadius(12)
                .shadow(radius: 6)

                // IMAGEN
                Image("imageninicio")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 180)
                    .clipped()
                    .cornerRadius(12)
                    .shadow(radius: 4)

                ScrollView {
                    VStack(spacing: 20) {

                        Text("Editar Producto")
                            .font(.system(size: 19, weight: .bold))
                            .foregroundColor(Color.AzulOscuro)

                        TextField("Nombre del producto", text: $nombre)
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
        guard
            let cantidadInt = Int(cantidad),
            let precioDouble = Double(precio)
        else {
            return
        }

        let productoEditado = Producto(
            id: producto.id,
            nombre: nombre,
            cantidad: cantidadInt,
            precio: precioDouble,
            categoriaId: categoria.id
        )

        viewModel.actualizarProducto(productoEditado)
        dismiss()
    }
}

