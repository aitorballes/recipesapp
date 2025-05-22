import SwiftUI

struct SplashScreenView: View {
    @State private var showContentTabView = false
    @State private var progress: CGFloat = 0
    var body: some View {
        if showContentTabView {
            ContentTabView()

        } else {
            VStack {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding()
                    

                Capsule()
                    .fill(Color.gray)
                    .frame(width: 200, height: 10)
                    .overlay {
                        HStack {
                            Capsule()
                                .frame(width: progress, height: 10)
                                .foregroundColor(.blue)
                            Spacer()

                        }
                    }
                    .task {
                        withAnimation(.linear(duration: 1.5)) {
                            progress = 200
                        }
                        
                        try? await Task.sleep(for: .seconds(1.5))
                        withAnimation {
                            showContentTabView = true
                        }
                    }
            }
        }

    }

}

#Preview {
    SplashScreenView()
}
