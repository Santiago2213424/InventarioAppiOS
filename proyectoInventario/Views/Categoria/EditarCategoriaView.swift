import SwiftUI

struct EditarCategoriaView: View {

    let categoria: Categoria
    @ObservedObject var viewModel: CategoriaViewModel

    @State private var nombreCategoria: String
    @Environment(\.dismiss) private var dismiss

    init(categoria: Categoria, viewModel: CategoriaViewModel) {
        self.categoria = categoria
        self.viewModel = viewModel
        _nombreCategoria = State(initialValue: categoria.nombre)
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
                    Text("EDITAR CATEGORÍA")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding(16)
                        .frame(maxWidth: .infinity)
                }
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

                        Text("Editar Categoría")
                            .font(.system(size: 19, weight: .bold))
                            .foregroundColor(Color.AzulOscuro)

                        TextField("Nombre de la categoría", text: $nombreCategoria)
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
        let categoriaEditada = Categoria(
            id: categoria.id,
            nombre: nombreCategoria
        )

        viewModel.actualizarCategoria(categoriaEditada)
        dismiss()
    }
}
