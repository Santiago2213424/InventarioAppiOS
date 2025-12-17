import SwiftUI

struct CategoriaItemView: View {

    let nombre: String
    let mostrarAcciones: Bool
    let onLongPress: () -> Void
    let onEditar: () -> Void
    let onEliminar: () -> Void

    var body: some View {
        ZStack(alignment: .trailing) {

            HStack {
                Text(nombre)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.leading, 16)
                Spacer()
            }
            .frame(height: 65)

            if mostrarAcciones {
                HStack(spacing: 12) {

                    Button(action: onEditar) {
                        Image(systemName: "pencil")
                            .foregroundColor(.white)
                            .frame(width: 38, height: 38)
                    }

                    Button(action: onEliminar) {
                        Image(systemName: "trash")
                            .foregroundColor(.white)
                            .frame(width: 38, height: 38)
                    }
                }
                .padding(.trailing, 8)
            }
        }
        .background(Color.AzulOscuro)
        .cornerRadius(12)
        .shadow(radius: 5)
        .padding(.bottom, 10)
        .onLongPressGesture {
            onLongPress()
        }
    }
}
