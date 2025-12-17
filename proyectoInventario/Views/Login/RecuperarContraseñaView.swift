import SwiftUI

struct RecuperarContrasenaView: View {

    @State private var correo = ""

    var body: some View {
        ZStack {

            Image("fondologin")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            ScrollView {
                VStack {

                    Spacer(minLength: 200)

                    Text("Recuperar Contraseña")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)


                    Text("Ingresa tu correo y te enviaremos un enlace")
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.top, 8)


                    CustomTextField(
                        icon: "email",
                        placeholder: "Correo electrónico",
                        text: $correo,
                        isSecure: false
                    )
                    .padding(.top, 32)


                    Button {
                        // lógica futura
                    } label: {
                        Text("Enviar correo de recuperación")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.red)
                            .cornerRadius(12)
                            .shadow(radius: 3)
                    }
                    .padding(.top, 24)

                    Spacer(minLength: 30)
                }
                .frame(maxWidth: 370)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RecuperarContrasenaView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RecuperarContrasenaView()
        }
    }
}
