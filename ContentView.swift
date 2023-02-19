import SwiftUI
import MediaPlayer

final class VolumeObserver: ObservableObject {
    @Published var volume: Float = AVAudioSession.sharedInstance().outputVolume

    private let session = AVAudioSession.sharedInstance()
    private var progressObserver: NSKeyValueObservation!

    func subscribe() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
            try session.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("cannot activate session")
        }

        progressObserver = session.observe(\.outputVolume) { [self] (session, value) in
            DispatchQueue.main.async {
                self.volume = session.outputVolume
            }
        }
    }

    func unsubscribe() {
        self.progressObserver.invalidate()
    }

    init() {
        subscribe()
    }
}

extension MPVolumeView {
    static func setVolume(_ volume: Float) {
        let volumeView = MPVolumeView()
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            slider?.value = volume
        }
    }
}

struct ContentView: View {
    @ObservedObject private var volObserver = VolumeObserver()
    @Environment(\.scenePhase) var scenePhase
    private var volume_percentage = VolumeObserver().volume

    func relaunchObserver() {
        volObserver.unsubscribe()
        volObserver.subscribe()
    }

    func increment(volume: Float) {
        MPVolumeView.setVolume(volume + 0.05)
    }

    func decrement(volume: Float) {
        MPVolumeView.setVolume(volume - 0.05)
    }

    var body: some View {
        ZStack {
            VStack {
                Text("\(Int(volObserver.volume * 100))%")
                    .font(.system(size: 65))
                    .onChange(of: scenePhase) { newPhase in
                        if newPhase == .active {
                            relaunchObserver()
                            volObserver.volume = AVAudioSession.sharedInstance().outputVolume
                        }
                    }

                Spacer()
                    .frame(height: 200)
            }

            VStack {
                Spacer()
                    .frame(height: 50)
                HStack(spacing: 0) {
                    Button(action: {decrement(volume: volObserver.volume)}) {
                        Text("-")
                            .font(.system(size: 50))
                            .foregroundColor(Color(UIColor.lightGray))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    Button(action: {increment(volume: volObserver.volume)}) {
                        Text("+")
                            .font(.system(size: 50))
                            .foregroundColor(Color(UIColor.lightGray))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
        }
    }
}
