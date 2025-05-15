import SwiftUI

enum AppStorageKeys {
    static let showContenTabView = "showContentTabView"
}

struct WelcomeView: View {
    @AppStorage(AppStorageKeys.showContenTabView) private var showContentTabView = false

    var body: some View {

        if showContentTabView {
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
                    showContentTabView = true
                }
                .buttonStyle(StrokedButtonStyle())
                .padding(.top)
            }
        }

    }
}

#Preview {
    WelcomeView()
        .testEnvironment()
}
