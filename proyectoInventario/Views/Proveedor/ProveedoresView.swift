import SwiftUI

struct ProveedoresView: View {

    @StateObject private var viewModel = ProveedorViewModel()

    var body: some View {
        ZStack {

            Image("fondologin")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 0) {

                // HEADER
                Text("🏪 PROVEEDORES")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background(Color.AzulOscuro)
                    .cornerRadius(12)
                    .shadow(radius: 6)
                    .padding(.horizontal, 25)
                    .padding(.top, 16)

                ScrollView {
                    VStack(spacing: 12) {

                        if viewModel.isLoading {
                            ProgressView()
                                .padding()
                        }

                        ForEach(viewModel.proveedores) { proveedor in
                            ProveedorRowView(
                                proveedor: proveedor,
                                viewModel: viewModel
                            )
                        }

                        Spacer(minLength: 80)
                    }
                    .padding(16)
                }
            }
            .frame(maxWidth: 370)
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            NavigationLink {
                AgregarProveedorView(viewModel: viewModel)
            } label: {
                Image(systemName: "plus")
            }
        }
        .onAppear {
            viewModel.cargarProveedores()
        }
    }
}
