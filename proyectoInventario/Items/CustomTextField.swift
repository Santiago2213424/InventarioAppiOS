import SwiftUI

struct CustomTextField: View {

    let icon: String
    let placeholder: String
    @Binding var text: String
    let isSecure: Bool

    var showToggle: Bool = false
    @Binding var mostrarPassword: Bool

    init(
        icon: String,
        placeholder: String,
        text: Binding<String>,
        isSecure: Bool,
        showToggle: Bool = false,
        mostrarPassword: Binding<Bool> = .constant(false)
    ) {
        self.icon = icon
        self.placeholder = placeholder
        self._text = text
        self.isSecure = isSecure
        self.showToggle = showToggle
        self._mostrarPassword = mostrarPassword
    }

    var body: some View {
        HStack {
            Image(icon)
                .resizable()
                .frame(width: 20, height: 20)
                .padding(.leading, 12)

            if isSecure && !mostrarPassword {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }

            if showToggle {
                Button {
                    mostrarPassword.toggle()
                } label: {
                    Image(systemName: mostrarPassword ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 12)
            }
        }
        .frame(height: 52)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.blue, lineWidth: 1.5)
        )
        .cornerRadius(12)
    }
}
