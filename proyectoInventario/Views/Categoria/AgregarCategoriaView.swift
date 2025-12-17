import SwiftUI

struct AgregarCategoriaView: View {

    @State private var nombreCategoria = ""
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {

            Image("fondologin")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 16) {

                VStack {
                    Text("AGREGAR CATEGORÍA")
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
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(12)
                                    .background(Color.red)
                                    .cornerRadius(10)
                            }

                            Button {
                                // guardar
                                dismiss()
                            } label: {
                                Text("Guardar")
                                    .font(.system(size: 16, weight: .semibold))
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
            }
            .padding(20)
            .frame(maxWidth: 370)
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}
struct AgregarCategoriaView_Previews: PreviewProvider {
    static var previews: some View {
        AgregarCategoriaView()
    }
}
