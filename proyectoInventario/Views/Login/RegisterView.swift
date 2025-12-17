import SwiftUI

struct RegisterView: View {

    @State private var nombre = ""
    @State private var apellido = ""
    @State private var correo = ""
    @State private var password = ""
    @State private var repeatPassword = ""

    @State private var showPassword = false
    @State private var showRepeatPassword = false
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            // FONDO
            Image("fondologin")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            ScrollView {
                VStack{

                    Spacer(minLength: 130)

                    VStack {
                        Text("Registro de Usuarios")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.black)
                            .padding(16)
                            .frame(maxWidth: .infinity)
                    }
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 6)
                    .padding(.horizontal, 15)

                    VStack(spacing: 12) {

                        CustomTextField(
                            icon: "ic_person",
                            placeholder: "Nombre",
                            text: $nombre,
                            isSecure: false
                        )

                        CustomTextField(
                            icon: "ic_person",
                            placeholder: "Apellido",
                            text: $apellido,
                            isSecure: false
                        )

                        CustomTextField(
                            icon: "email",
                            placeholder: "Correo electrónico",
                            text: $correo,
                            isSecure: false
                        )

                        CustomTextField(
                            icon: "lock",
                            placeholder: "Contraseña",
                            text: $password,
                            isSecure: true,
                            showToggle: true,
                            mostrarPassword: $showPassword
                        )

                        CustomTextField(
                            icon: "lock",
                            placeholder: "Repetir contraseña",
                            text: $repeatPassword,
                            isSecure: true,
                            showToggle: true,
                            mostrarPassword: $showRepeatPassword
                        )

                        HStack(spacing: 12) {
                            /*
                            Button(action: {
                                dismiss()
                            }) {
                                Text("Cancelar")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 45)
                                    .background(Color.red)
                                    .cornerRadius(12)
                                    .shadow(radius: 3)
                            }
                             */
                             
                            Button(action: {}) {
                                Text("Registrarse")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 45)
                                    .background(Color.blue)
                                    .cornerRadius(12)
                                    .shadow(radius: 3)
                            }
                        }
                        .padding(.top, 8)
                    }
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 6)
                    .padding(.horizontal, 16)

                    Spacer(minLength: 30)
                }
                .frame(maxWidth: 370)
            }
        }
    }
}
struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

