import SwiftUI

struct ProductoView: View {

    let categoria: Categoria

    @StateObject private var viewModel = ProductoViewModel()
    @State private var productoSeleccionado: Producto?
    @State private var mostrarAgregarProducto = false

    @State private var mostrarAlertaEliminar = false
    @State private var productoAEliminar: Producto?

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
                        ForEach(
                            viewModel.productos.filter {
                                $0.categoriaId == categoria.id
                            }
                        ) { producto in
                            ProductoItemView(
                                nombre: producto.nombre,
                                cantidad: producto.cantidad,
                                precio: producto.precio,
                                categoria: categoria.nombre,
                                mostrarAcciones: true,
                                onEditar: {
                                    productoSeleccionado = producto
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
        .toolbar {
            Button {
                mostrarAgregarProducto = true
            } label: {
                Image(systemName: "plus")
            }
        }

        // agregar
        .navigationDestination(isPresented: $mostrarAgregarProducto) {
            AgregarProductoView(
                categoria: categoria,
                viewModel: viewModel
            )
        }

        // editar
        .navigationDestination(item: $productoSeleccionado) { producto in
            EditarProductoView(
                producto: producto,
                categoria: categoria,
                viewModel: viewModel
            )
        }

        .onAppear {
            viewModel.cargarProductos()
        }

        .alert(
            "Eliminar producto",
            isPresented: $mostrarAlertaEliminar,
            presenting: productoAEliminar
        ) { producto in

            Button("Eliminar", role: .destructive) {
                viewModel.eliminarProducto(id: producto.id)
            }

            Button("Cancelar", role: .cancel) { }

        } message: { producto in
            Text("¿Seguro que deseas eliminar el producto \"\(producto.nombre)\"?")
        }
    }
}
