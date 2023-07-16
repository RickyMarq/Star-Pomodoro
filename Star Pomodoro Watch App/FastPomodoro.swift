//
//  ContentView.swift
//  Star Pomodoro Watch App
//
//  Created by Henrique Marques on 07/07/23.
//

import SwiftUI
import UserNotifications
import AVFoundation


struct FastPomodoro: View {
    
    @State var timeRemaining = 30
    @State var breakTime = 300
    @State var timer: Timer?
    @State var giveUp = false
    @State var ButtonTitle = "Start"
    @State var TimerHasStarted = false
    @State var timerEnd: Date?
    @State var imageName = "play"
    @State var audioSelected: String?
    @State var customPhrase: String?
    @State var customPersonalitySelected: String?
    @State var homeTitle: String?
    @State var phrasesModel = PhrasesModelToPopulate().populateModel()
    @State var showNewView = false
    @State var timeFocused: Int?
    @State var tagSelected: String?
    @State var getPhrase: [StarPomodoroPhrases] = []
    
    
    var body: some View {
        if #available(watchOS 8.0, *) {
            NavigationView {
                ScrollView {
                    VStack(alignment: .center, spacing: 10) {
                        HStack {
                            Text(tagSelected ?? "Read")
                                .padding(3)
                                .font(Font.system(size: 12))
                            NavigationLink(destination: TagsScreen(), isActive: $showNewView) {
                                Button {
                                    print("Change label")
                                    showNewView = true
                                } label: {
                                    Image(systemName: "checkmark")
                                        .padding(3)
                                }
                            }
                            .clipShape(Circle())
                            .foregroundColor(Color.secondary)
                            .frame(maxWidth: 15, maxHeight: 15)
                            
                        }
                        .padding(3)
                        .background(Color.accentColor.opacity(0.5))
                        .cornerRadius(10)
                        
                        
                        ZStack {
                            Circle()
                                .foregroundColor(Color.secondary)
                                .padding(.top, 5)
                            VStack {
                                Text(timeString(timeRemaining))
                                    .bold()
                                    .font(.title)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .shadow(color: .gray ,radius: 1, x: -1, y: 0)
                                VStack {
                                    Button {
                                        if giveUp == false {
                                            homeTitle = "Get focused"
                                            //                                        AudioController.sharedObjc.playSelectedAudio(audio: audioSelected ?? "")
                                            startTimer()
                                            NotificationController.sharedObjc.getNotification(title: "Time to rest", body: "Your timer ended", timeInterval: Double(timeRemaining), identifier: "")
                                            ButtonTitle = "Give up?"
                                            imageName = "xmark.circle"
                                            giveUp = true
                                            TimerHasStarted = true
                                            let date = Date()
                                            timerEnd = date.addingTimeInterval(TimeInterval(timeRemaining))
                                        } else if giveUp == true {
                                            homeTitle = "Break"
                                            stopTimer()
                                            timeRemaining = 1500
                                            ButtonTitle = "Start"
                                            imageName = "play"
                                            giveUp = false
                                            TimerHasStarted = false
                                        }
                                    } label: {
                                        Image(systemName: imageName)
                                    }
                                    
                                    
                                }
                                //         .padding()
                                .clipShape(Circle())
                                //   .background(Color.accentColor)
                                .foregroundColor(Color.black)
                                //   .background(Color.accentColor)
                                
                                //   .clipped()
                                .shadow(color: .black, radius: 0.5, x: 1, y: 1)
                                //    .cornerRadius(10)
                                //.frame(width: 50, height: 30)
                                
                                
                            }
                        }
                        
                        HStack {
                            ForEach(getPhrase, id: \.id) { phrase in
                                Text(phrase.phrase ?? "")
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity, alignment: .center)
//                                    .cornerRadius(15)
//                                    .clipShape(Capsule())
                            }
                        }
                        .cornerRadius(10)
                        .padding()
//                        .clipShape(Capsule())
                        .background(Color.init(hex: "#F97A7A"))
                    }
                    .padding()
                    .cornerRadius(10)
                    
 //                   .background(Color.init(hex: "#F97A7A"))
//                        ForEach(phrasesModel) { model in
//                            if customPersonalitySelected == model.personalityName {
//                                VStack {
//                                    ForEach(phrasesModel) { model in
//                                        Text(model.phases[0].phrase)
//                                            .bold()
//                                            .cornerRadius(10)
//                                            .multilineTextAlignment(.center)
//                                            .frame(maxWidth: .infinity, alignment: .center)
//                                            .background(Color.init(hex: "#F97A7A"))
//                                            .padding()
//
//                                    }
//                                }
//
//                            }
//                        }
//                        .padding()
                    }
                
                
                .navigationTitle(homeTitle ?? "Pomodoro")
                .accentColor(Color.green)
                .navigationBarTitleDisplayMode(.inline)
                
                .onAppear(perform: {
                    audioSelected = UserDefaults.standard.string(forKey: "AudioSelected")  ?? "sound-effect-twinklesparkle-115095.wav"
                    customPersonalitySelected = UserDefaults.standard.string(forKey: "PersonalitySelected") ?? "Motivational"
                    
                    if customPersonalitySelected == "Motivational" {
                        getMotivotionalPhrase()
                    } else{
                        getUnmotivadedPhrase()
                    }  
                    
                    tagSelected = UserDefaults.standard.string(forKey: "TagSelected") ?? "Study"
                    
                    
                    print("DEBUG MODE: VIEW CARREGADA")
                    if TimerHasStarted == true {
                        if let timerEnd = timerEnd {
                            let currentTime = Date()
                            let timeInterval = Int(timerEnd.timeIntervalSince(currentTime))
                            timeRemaining = timeInterval > 0 ? timeInterval : 0
                        }
                    }
                })
                
                .padding(.horizontal, 20)
                
                
                
            }
            
            
            .onAppear {
                //                print("DEBUG MODE: VIEW CARREGADA")
                //                if TimerHasStarted == true {
                //                    if let timerEnd = timerEnd {
                //                        let currentTime = Date()
                //                        let timeInterval = Int(timerEnd.timeIntervalSince(currentTime))
                //                        timeRemaining = timeInterval > 0 ? timeInterval : 0
                //                    }
                //                }
                
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
                    if granted {
                        print("Notification authorization granted.")
                        UserDefaults.standard.set(true, forKey: "NotificationGranted")
                    } else {
                        print("Notification authorization denied.")
                        UserDefaults.standard.set(false, forKey: "NotificationGranted")
                    }
                }
            }
        } else {
        }
    }
    
    func getMotivotionalPhrase() {
        StarPomodoroService.sharedObjc.getMotivotionalPhrase { result in
            switch result {
            case .success(let model):
                guard let model = model else {return}
                getPhrase = []
                getPhrase.append(model)
            case .failure(let error):
                print("Error \(error.localizedDescription)")
            }
        }
    }
    
    func getUnmotivadedPhrase() {
        StarPomodoroService.sharedObjc.getunmotivadedPhrase { result in
            
            switch result {
            case .success(let model):
                guard let model = model else {return}
                getPhrase = []
                getPhrase.append(model)
            case .failure(let error):
                print("Error \(error.localizedDescription)")
            }
        }
    }
    
    func timeString(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                if breakTime > 0 {
                    breakTime -= 1
                }
            }
        })
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FastPomodoro()
    }
}
