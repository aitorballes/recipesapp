import SwiftUI

struct WelcomeView: View {
    @AppStorage(AppStorageKeys.hasCompletedWelcome) private var hasCompletedWelcome = false

    var body: some View {

        if hasCompletedWelcome {
            ContentTabView()
        } else {
            VStack(spacing: 20) {
                Text("Hi, Chef!👨🏽‍🍳")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Looking for new recipes?\nYou're in the right place!")
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .padding(.bottom)

                Button("Press to continue") {
                    hasCompletedWelcome = true
                }
                .buttonStyle(StrokedButtonStyle())
                .padding(.top)
            }
        }

    }
}

#Preview {
    WelcomeView()
}
