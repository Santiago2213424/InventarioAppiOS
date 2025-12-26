import SwiftUI

struct ProductoView: View {

    let categoria: Categoria

    @StateObject private var viewModel = ProductoViewModel()
    @State private var productoSeleccionado: Producto?

    var body: some View {
        ZStack {

            Image("fondologin")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 12) {

                Text("📦 \(categoria.nombre)")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.vertical, 14)
                    .frame(maxWidth: .infinity)
                    .background(Color.AzulOscuro)
                    .cornerRadius(12)
                    .padding(.horizontal, 12)
                    .padding(.top, 12)

                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(viewModel.productos.filter {
                            $0.categoriaId == categoria.id
                        }) { producto in
                            ProductoItemView(
                                nombre: producto.nombre,
                                cantidad: producto.cantidad,
                                precio: producto.precio,
                                categoria: categoria.nombre,
                                mostrarAcciones: true,
                                onEditar: {
                                    productoSeleccionado = producto
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 8)
                }
            }
            .frame(maxWidth: 370)
        }
        .onAppear {
            viewModel.cargarProductos()
        }
    }
}
