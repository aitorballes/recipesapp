import SwiftUI

struct TimerView: View {
    @Environment(TimerViewModel.self) private var viewModel: TimerViewModel
    
    var body: some View {
        @Bindable var viewModelBindable: TimerViewModel = viewModel
        VStack(spacing: 20) {
            Text("Cooking timer")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(viewModel.timeString(from: viewModel.secondsRemaining))
                .font(.system(size: 48, weight: .semibold, design: .monospaced))
                .padding()

            HStack {
                Text("Minutes: \(viewModel.minutes)")
                    .font(.title3)
                    
                Stepper(value: $viewModelBindable.minutes, in: 0...120, step: 1) {
                    Text("")
                }
                .disabled(viewModel.isRunning)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            HStack (spacing: 20) {
                Button {
                    withAnimation {
                        viewModel.isRunning.toggle()
                        if viewModel.isRunning {
                            viewModel.startTimer()
                        } else {
                            viewModel.pauseTimer()
                        }
                    }
                } label: {
                    Label(viewModel.isRunning ? "Pause" : "Play", systemImage: viewModel.isRunning ? "pause.fill" : "play.fill")
                }
                .selectableButton(color: .orange, secondaryColor: .green, isSelected: viewModel.isRunning)
                
                Button {
                    viewModel.resetTimer()
                } label: {
                    Label(viewModel.isAlarmPlaying ? "Cancel" : "Reset", systemImage: viewModel.isAlarmPlaying ? "xmark.circle.fill" : "arrow.clockwise")
                }
                .selectableButton(color: .red, secondaryColor: .blue, isSelected: viewModel.isAlarmPlaying)
            }
        }
        .onDisappear {
            viewModel.timer?.invalidate()
        }
    }
}

#Preview {
    TimerView()
        .environment(TimerViewModel())
}
