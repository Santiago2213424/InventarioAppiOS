import SwiftUI

struct AgregarCategoriaView: View {

    @ObservedObject var viewModel: CategoriaViewModel

    @State private var nombreCategoria = ""
    @State private var mostrarAlerta = false
    @State private var mensajeAlerta = ""

    @Environment(\.dismiss) private var dismiss

    private func categoriaYaExiste(nombre: String) -> Bool {
        let nombreNormalizado = nombre
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        return viewModel.categorias.contains {
            $0.nombre.trimmingCharacters(in: .whitespacesAndNewlines)
                .lowercased() == nombreNormalizado
        }
    }

    var body: some View {
        ZStack {

            Image("fondologin")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 16) {

                Text("AGREGAR CATEGORÍA")
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

                VStack(spacing: 20) {

                    Text("Nueva Categoría")
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

                        Button {
                            dismiss()
                        } label: {
                            Text("Cancelar")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(12)
                                .background(Color.red)
                                .cornerRadius(10)
                        }

                        Button {
                            let nombreLimpio = nombreCategoria
                                .trimmingCharacters(in: .whitespacesAndNewlines)

                            guard !nombreLimpio.isEmpty else {
                                mensajeAlerta = "El nombre de la categoría no puede estar vacío."
                                mostrarAlerta = true
                                return
                            }

                            guard !categoriaYaExiste(nombre: nombreLimpio) else {
                                mensajeAlerta = "La categoría \"\(nombreLimpio)\" ya existe."
                                mostrarAlerta = true
                                return
                            }

                            viewModel.agregarCategoria(nombre: nombreLimpio)
                            dismiss()

                        } label: {
                            Text("Guardar")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(12)
                                .background(Color.AzulOscuro)
                                .cornerRadius(10)
                        }
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
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Error", isPresented: $mostrarAlerta) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(mensajeAlerta)
        }
        .onAppear {
            if viewModel.categorias.isEmpty {
                viewModel.cargarCategorias()
            }
        }
    }
}
