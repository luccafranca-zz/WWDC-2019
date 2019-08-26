import UIKit
import AVKit

public class Player {
    let musicSound = URL(fileURLWithPath: Bundle.main.path(forResource: "Sounds/song", ofType: "mp3")!)
    let clickSound = URL(fileURLWithPath: Bundle.main.path(forResource: "Sounds/click", ofType: "mp3")!)
    let rightSignSound = URL(fileURLWithPath: Bundle.main.path(forResource: "Sounds/rightSign", ofType: "m4r")!)
    let rightWordSound = URL(fileURLWithPath: Bundle.main.path(forResource: "Sounds/rightWord", ofType: "m4r")!)
    var musicPlayer: AVAudioPlayer?
    var clickPlayer: AVAudioPlayer?
    var rightSignPlayer: AVAudioPlayer?
    var rightWordPlayer: AVAudioPlayer?
    let down: Float = 10.0
    let up: Float = 20.0
    static let shared = Player()
    
    private init() {
        guard let musicPlayer = try? AVAudioPlayer(contentsOf: musicSound) else { return }
        guard let clickPlayer = try? AVAudioPlayer(contentsOf: clickSound) else { return }
        guard let rightSignPlayer = try? AVAudioPlayer(contentsOf: rightSignSound) else { return }
        guard let rightWordPlayer = try? AVAudioPlayer(contentsOf: rightWordSound) else { return }
        self.musicPlayer = musicPlayer
        self.clickPlayer = clickPlayer
        self.rightSignPlayer = rightSignPlayer
        self.rightWordPlayer = rightWordPlayer
    }

    public func playMusic() {
        guard let musicPlayer = self.musicPlayer else { return }
        musicPlayer.numberOfLoops = -1
        musicPlayer.play()
    }
    
    public func stopMusic() {
        guard let musicPlayer = self.musicPlayer else { return }
        musicPlayer.stop()
    }

    public func turnDownMusic() {
        guard let musicPlayer = self.musicPlayer else { return }
        musicPlayer.setVolume(0.2, fadeDuration: 0.5)
    }

    public func click() {
        guard let clickPlayer = self.clickPlayer else { return }
        clickPlayer.setVolume(up, fadeDuration: 0.0)
        clickPlayer.play()
    }

    public func rightSign() {
        guard let rightSignPlayer = self.rightSignPlayer else { return }
        rightSignPlayer.setVolume(up, fadeDuration: 0.0)
        rightSignPlayer.play()
    }

    public func rightWord() {
        guard let rightWordPlayer = self.rightWordPlayer else { return }
        rightWordPlayer.setVolume(up, fadeDuration: 0.0)
        rightWordPlayer.play()
    }
}
