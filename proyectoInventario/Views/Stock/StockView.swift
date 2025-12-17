import SwiftUI

struct StockView: View {

    var body: some View {
        ZStack {

            Image("fondologin")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 16) {

                Text("STOCK")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background(Color.AzulOscuro)
                    .cornerRadius(12)
                    .shadow(radius: 6)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)

                HStack(spacing: 16) {

                    NavigationLink {
                        BajoStockView()
                    } label: {
                        StockCard(
                            emoji: "📉",
                            title: "Bajo Stock"
                        )
                    }

                    NavigationLink {
                        AltoStockView()
                    } label: {
                        StockCard(
                            emoji: "📈",
                            title: "Alto Stock"
                        )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)

                Spacer()
            }
            .frame(maxWidth: 370)
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct StockView_Previews: PreviewProvider {
    static var previews: some View {
        StockView()
    }
}
