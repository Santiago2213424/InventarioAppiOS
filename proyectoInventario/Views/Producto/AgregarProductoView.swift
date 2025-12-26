import SwiftUI

struct AgregarProductoView: View {

    let categoria: Categoria
    @ObservedObject var viewModel: ProductoViewModel

    @State private var nombre = ""
    @State private var cantidad = ""
    @State private var precio = ""

    @State private var mostrarAlerta = false
    @State private var mensajeAlerta = ""

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
        .alert("Error", isPresented: $mostrarAlerta) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(mensajeAlerta)
        }
        .onAppear {
            if viewModel.productos.isEmpty {
                viewModel.cargarProductos()
            }
        }
    }

    private func guardarProducto() {

        let nombreLimpio = nombre.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !nombreLimpio.isEmpty else {
            mensajeAlerta = "El nombre del producto no puede estar vacío."
            mostrarAlerta = true
            return
        }

        guard let cantidadInt = Int(cantidad), cantidadInt >= 0 else {
            mensajeAlerta = "La cantidad debe ser un número válido."
            mostrarAlerta = true
            return
        }

        guard let precioDouble = Double(precio), precioDouble >= 0 else {
            mensajeAlerta = "El precio debe ser un número válido."
            mostrarAlerta = true
            return
        }

        if viewModel.existeProducto(nombre: nombreLimpio, categoriaId: categoria.id) {
            mensajeAlerta = "El producto \"\(nombreLimpio)\" ya existe en esta categoría."
            mostrarAlerta = true
            return
        }

        let nuevoProducto = Producto(
            nombre: nombreLimpio,
            cantidad: cantidadInt,
            precio: precioDouble,
            categoriaId: categoria.id
        )

        viewModel.agregarProducto(nuevoProducto)
        dismiss()
    }
}
