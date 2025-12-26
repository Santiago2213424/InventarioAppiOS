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
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.AzulOscuro)
        .cornerRadius(12)
        .shadow(radius: 6)
    }
}
