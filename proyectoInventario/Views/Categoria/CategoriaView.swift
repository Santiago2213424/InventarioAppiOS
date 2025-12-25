import SwiftUI

struct CategoriaView: View {

    @StateObject private var viewModel = CategoriaViewModel()

    @State private var categoriaSeleccionada: Categoria?
    @State private var categoriaActiva: Categoria?
    @State private var mostrarAlertaEliminar = false
    @State private var categoriaAEliminar: Categoria?

    var body: some View {
        ZStack {

            Image("fondologin")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {

                Text("CATEGORÍAS")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background(Color.AzulOscuro)
                    .cornerRadius(12)
                    .padding()

                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(viewModel.categorias) { categoria in
                            CategoriaItemView(
                                nombre: categoria.nombre,
                                mostrarAcciones: categoriaActiva?.id == categoria.id,
                                onLongPress: {
                                    categoriaActiva = categoria
                                },
                                onEditar: {
                                    categoriaSeleccionada = categoria
                                },
                                onEliminar: {
                                    categoriaAEliminar = categoria
                                    mostrarAlertaEliminar = true
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 12)
                }
            }
            .frame(maxWidth: 370)
        }
        .toolbar {
            NavigationLink {
                AgregarCategoriaView(viewModel: viewModel)
            } label: {
                Image(systemName: "plus")
            }
        }
        .navigationDestination(item: $categoriaSeleccionada) { categoria in
            EditarCategoriaView(
                categoria: categoria,
                viewModel: viewModel
            )
        }
        .onAppear {
            viewModel.cargarCategorias()
        }
        .alert("Eliminar categoría",
               isPresented: $mostrarAlertaEliminar,
               presenting: categoriaAEliminar) { categoria in

            Button("Eliminar", role: .destructive) {
                viewModel.eliminarCategoria(id: categoria.id)
                categoriaActiva = nil
            }

            Button("Cancelar", role: .cancel) { }

        } message: { categoria in
            Text("¿Seguro que deseas eliminar la categoría \"\(categoria.nombre)\"?")
        }
    }
}


struct CategoriaView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CategoriaView()
        }
    }
}
