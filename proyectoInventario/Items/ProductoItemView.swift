import SwiftUI

struct ProductoItemView: View {

    let nombre: String
    let cantidad: Int
    let precio: Double
    let categoria: String

    var mostrarAcciones: Bool = false
    var onEditar: () -> Void

    var body: some View {
        ZStack(alignment: .bottomTrailing) {

            VStack(alignment: .leading, spacing: 4) {

                Text("Nombre: \(nombre)")
                Text("Cantidad: \(cantidad)")
                Text("Precio: S/ \(String(format: "%.2f", precio))")
                Text("Categoría: \(categoria)")
            }
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.white)
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)

            if mostrarAcciones {
                HStack(spacing: 12) {

                    Button {
                        onEditar()
                    } label: {
                        Image(systemName: "pencil")
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                    }

                    Button {
                        // eliminar
                    } label: {
                        Image(systemName: "trash")
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                    }
                }
                .padding(8)
            }
        }
        .background(Color.AzulOscuro)
        .cornerRadius(12)
        .shadow(radius: 5)
        .padding(.bottom, 10)
    }
}
