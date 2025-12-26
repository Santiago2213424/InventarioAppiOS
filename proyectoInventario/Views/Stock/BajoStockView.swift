import SwiftUI

struct BajoStockView: View {

    @StateObject private var productoVM = ProductoViewModel()
    @StateObject private var categoriaVM = CategoriaViewModel()

    @State private var destino: ProductoNavegacion?

    @State private var mostrarAlertaEliminar = false
    @State private var productoAEliminar: Producto?

    private var productosBajoStock: [Producto] {
        productoVM.productos.filter { $0.cantidad <= 5 }
    }

    private func nombreCategoria(for categoriaId: String) -> String {
        categoriaVM.categorias.first { $0.id == categoriaId }?.nombre ?? "Sin categoría"
    }

    private func editarProducto(_ producto: Producto) {
        guard let categoria = categoriaVM.categorias.first(
            where: { $0.id == producto.categoriaId }
        ) else { return }

        destino = ProductoNavegacion(
            producto: producto,
            categoria: categoria
        )
    }

    var body: some View {
        ZStack {
            Image("fondologin")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 12) {

                Text("📉 BAJO STOCK")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.vertical, 14)
                    .frame(maxWidth: .infinity)
                    .background(Color.AzulOscuro)
                    .cornerRadius(12)
                    .padding()

                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(productosBajoStock) { producto in
                            ProductoItemView(
                                nombre: producto.nombre,
                                cantidad: producto.cantidad,
                                precio: producto.precio,
                                categoria: nombreCategoria(for: producto.categoriaId),
                                mostrarAcciones: true,
                                onEditar: {
                                    editarProducto(producto)
                                },
                                onEliminar: {
                                    productoAEliminar = producto
                                    mostrarAlertaEliminar = true
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 8)
                }
            }
            .frame(maxWidth: 370)
        }
        .navigationDestination(item: $destino) { nav in
            EditarProductoView(
                producto: nav.producto,
                categoria: nav.categoria,
                viewModel: productoVM
            )
        }
        .onAppear {
            productoVM.cargarProductos()
            categoriaVM.cargarCategorias()
        }
        .navigationBarTitleDisplayMode(.inline)

        .alert(
            "Eliminar producto",
            isPresented: $mostrarAlertaEliminar,
            presenting: productoAEliminar
        ) { producto in

            Button("Eliminar", role: .destructive) {
                productoVM.eliminarProducto(id: producto.id)
            }

            Button("Cancelar", role: .cancel) { }

        } message: { producto in
            Text("¿Seguro que deseas eliminar el producto \"\(producto.nombre)\"?")
        }
    }
}
