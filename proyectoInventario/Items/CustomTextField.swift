import SwiftUI

struct CustomTextField: View {
    
    enum CustomFieldType {
        case normal
        case email
        case password
    }

    let icon: String
    let placeholder: String
    @Binding var text: String
    let fieldType: CustomFieldType

    var showToggle: Bool = false
    @Binding var mostrarPassword: Bool

    init(
        icon: String,
        placeholder: String,
        text: Binding<String>,
        fieldType: CustomFieldType = .normal,
        showToggle: Bool = false,
        mostrarPassword: Binding<Bool> = .constant(false)
    ) {
        self.icon = icon
        self.placeholder = placeholder
        self._text = text
        self.fieldType = fieldType
        self.showToggle = showToggle
        self._mostrarPassword = mostrarPassword
    }

    var body: some View {
        HStack {
            Image(icon)
                .resizable()
                .frame(width: 20, height: 20)
                .padding(.leading, 12)

            fieldView

            if showToggle && fieldType == .password {
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
    
    @ViewBuilder
    private var fieldView: some View {
        switch fieldType {

        case .password:
            if mostrarPassword {
                TextField(placeholder, text: $text)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
            } else {
                SecureField(placeholder, text: $text)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
            }

        case .email:
            TextField(placeholder, text: $text)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)

        case .normal:
            TextField(placeholder, text: $text)
                .textInputAutocapitalization(.words)
        }
    }
}
