import SwiftUI

struct CategoriaView: View {

    let categorias = [
        "Bebidas",
        "Lácteos",
        "Abarrotes",
        "Limpieza",
        "Snacks"
    ]

    @State private var categoriaSeleccionada: String? = nil
    @State private var categoriaActiva: String? = nil

    var body: some View {
        ZStack {

            Image("fondologin")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 0) {

                VStack {
                    Text("CATEGORÍAS")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .background(Color.AzulOscuro)
                }
                .cornerRadius(12)
                .shadow(radius: 6)
                .padding(16)

                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(categorias, id: \.self) { categoria in
                            CategoriaItemView(
                                nombre: categoria,
                                mostrarAcciones: categoriaActiva == categoria,
                                onLongPress: {
                                    withAnimation { categoriaActiva = categoria }
                                },
                                onEditar: {
                                    categoriaSeleccionada = categoria
                                },
                                onEliminar: {
                                    print("Eliminar \(categoria)")
                                    categoriaActiva = nil
                                }
                            )
                        }

                        Spacer(minLength: 80)
                    }
                    .padding(.horizontal, 12)
                }
            }
            .frame(maxWidth: 370)
        }
        .toolbar {
            NavigationLink {
                AgregarCategoriaView()
            } label: {
                Image(systemName: "plus")
            }
        }

        .navigationDestination(item: $categoriaSeleccionada) { categoria in
            EditarCategoriaView(nombreCategoria: categoria)
        }
    }
}

struct CategoriaView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriaView()
    }
}
