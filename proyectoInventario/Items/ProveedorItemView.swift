import SwiftUI

struct ProveedorItemView: View {

    let nombre: String
    let numero: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            Text("Proveedor: \(nombre)")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)

            Text("Número: \(numero)")
                .font(.system(size: 14))
                .foregroundColor(.white)

            HStack {
                Spacer()

                NavigationLink {
                    EditarProveedorView()
                } label: {
                    Text("Editar")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.blue)
                        .cornerRadius(6)
                }


                Button(action: {
                    // eliminar proveedor
                }) {
                    Text("Eliminar")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.red)
                        .cornerRadius(6)
                }
            }
            .padding(.top, 6)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.AzulOscuro)
        .cornerRadius(12)
        .shadow(radius: 6)
    }
}
