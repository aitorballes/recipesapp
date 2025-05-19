import Foundation
import AVFoundation

@Observable
final class TimerViewModel {
    var minutes = 0
    var secondsRemaining = 0
    var isRunning = false
    var timer: Timer? = nil
    var isAlarmPlaying = false
    
    private var audioPlayer: AVAudioPlayer?
    
    func startTimer() {
        if secondsRemaining == 0 {
            secondsRemaining = minutes * 60
        }
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.secondsRemaining > 0 {
                self.secondsRemaining -= 1
            } else {
                self.isRunning = false
                self.timer?.invalidate()
                self.playAlarm()
            }
        }
    }
    
    func pauseTimer() {
        timer?.invalidate()
    }
    
    func resetTimer() {
        timer?.invalidate()
        isRunning = false
        secondsRemaining = 0
        stopAlarm()
    }

    func timeString(from seconds: Int) -> String {
        let minutesPart = seconds / 60
        let secondsPart = seconds % 60
        return String(format: "%02d:%02d", minutesPart, secondsPart)
    }
    
    private func playAlarm(){
        guard let url = Bundle.main.url(forResource: "alarm", withExtension: "mp3") else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
            isAlarmPlaying = true
        } catch {
            print("Error: \(error.localizedDescription)")
            isAlarmPlaying = false
        }
    }
    
    private func stopAlarm() {
        audioPlayer?.stop()
        isAlarmPlaying = false
    }
}
