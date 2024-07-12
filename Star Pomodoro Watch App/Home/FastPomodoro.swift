//
//  ContentView.swift
//  Star Pomodoro Watch App
//
//  Created by Henrique Marques on 07/07/23.
//

import SwiftUI
import UserNotifications
import AVFoundation
import WatchKit

struct FastPomodoro: View {
    
    @State var backgroundTimestamp: Date?
    @State var timeRemaining: Int = 1500
    @State var breakTime = 300
    @State var timer: Timer?  
    @State var defaults = UserDefaults.standard
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
    @State var showSheetToCancel = false
    @State var userCurrentDate: Date?
    @State var savedSeconds: Int?
    
    var body: some View {
        if #available(watchOS 8.0, *) {
            NavigationView {
                ScrollView {
                    VStack(alignment: .center, spacing: 10) {
                        HStack {
//                            NavigationLink(tagSelected ?? "") {
//                                TagsScreen()
//                            }
//                            .background(Color.green.opacity(0.5))
//                            .cornerRadius(10)
//                            .padding(.horizontal, 50)
//                            .padding(.vertical, 10)
//                            .frame(maxHeight: 30)
//                            Button {
//                            } label: {
//                                Text(tagSelected ?? "")
//                                    .foregroundColor(Color.white)
//                            }
//                            .background(Color.orange.opacity(0.5))
//                            .cornerRadius(10)
//                            .padding(.horizontal, 30)
//                            .padding(.top, 10)
                        
                            

//                            Text(tagSelected ?? "Read")
//                                .padding(8)
//                                .font(Font.system(size: 12))
                            
                            NavigationLink(destination: TagsScreen(), isActive: $showNewView) {
                                
                                HStack {
                                    Text(tagSelected ?? "Read")
                                        .padding(4)
                                        .font(Font.system(size: 14))
                                    Image(systemName: "checkmark")
                                }
                                
                            }
                            .background(Color.accentColor.opacity(0.1))
                            .cornerRadius(10)
                            .padding(.horizontal, 46)
                            .frame(maxHeight: 50)
                        }
                        
                        ZStack {
                            VStack {
                                Text(timeString(timeRemaining))
                                    .bold()
                                    .font(.title)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .shadow(color: .red ,radius: 0.5, x: -0.5, y: 0)
                                HStack {
                                    Button {
                                        if giveUp == false {
                                            homeTitle = "Get focused"
                                            startTimer(TimeRemaining: timeRemaining)
                                            NotificationController.sharedObjc.getNotification(title: "Time to rest", body: "Your timer ended", timeInterval: Double(timeRemaining), identifier: "")
                                            ButtonTitle = "Give up?"
                                            imageName = "pause"
                                            giveUp = true
                                            TimerHasStarted = true
                                            let date = Date()
                                            timerEnd = date.addingTimeInterval(TimeInterval(timeRemaining))
           //                                 timeRemaining = 1500
                                        } else if giveUp == true {
                                            // Need to pause the timer...
                                            print("Pause time...")
                                            giveUp = false
                                            imageName = "play"
                                            stopTimer()
                                            // TODO: RETOMAR...
                                        }
                                    } label: {
                                        Image(systemName: imageName)
                                        
                                        
                                    }
                                    
                                    
                                    if giveUp == true {
                                        Button {
                                            showSheetToCancel.toggle()
                                        } label: {
                                            Image(systemName: "xmark")
                                            
                                        }
                                        .padding()
                                        
                                        .alert(isPresented: $showSheetToCancel) {
                                            Alert(
                                                title: Text("Alert"),
                                                message: Text("End Pomodoro?"),
                                                primaryButton: .default(Text("End Pomodoro")) {
                                                    stopTimer()
                                                    TimerHasStarted = false
                                                    giveUp = false
                                                    timeRemaining = 1500
                                                    imageName = "play"
                                                    
                                                },
                                                secondaryButton: .cancel(Text("Cancel")) {
                        
                                                }
                                            )
                                            
                                            
                                        }
                                    }
                                    
                                }
                                .padding()
                                .frame(minWidth: WKInterfaceDevice.current().screenBounds.width)
                            }
                        }
                        HStack {
                            ForEach(getPhrase, id: \.id) { phrase in
                                VStack {
                                    Text(phrase.phrase ?? "")
                                        .multilineTextAlignment(.center)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .cornerRadius(10)
                                        .padding()
                                    
                                    Text(phrase.author ?? "")
                                        .multilineTextAlignment(.trailing)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .foregroundColor(Color.red)
                                        .cornerRadius(10)
                                        .padding()
                                    
                                }
                            }
                        }
                    }
                    .padding()
                    .cornerRadius(10)
                }
                
                
                .navigationTitle(homeTitle ?? "Pomodoro")
                .accentColor(Color.green)
                .navigationBarTitleDisplayMode(.inline)
                .onAppear(perform: {
                    userCurrentDate = Date()
                    self.configDay()
                    audioSelected = defaults.string(forKey: "AudioSelected")  ?? "sound-effect-twinklesparkle-115095.wav"
                    customPersonalitySelected = defaults.string(forKey: "PersonalitySelected") ?? "Motivational"
                    timeFocused = defaults.integer(forKey: "timeFocused")
                    if customPersonalitySelected == "Motivational" {
                        getMotivotionalPhrase()
                    } else {
                        getUnmotivadedPhrase()
                    }
                    tagSelected = defaults.string(forKey: "TagSelected") ?? "Study"
                    
                    if TimerHasStarted {
                        if let backgroundTimestamp = UserDefaults.standard.object(forKey: "BackgroundTimestamp") as? Date {
                            let currentTime = Date()
                            let timeInterval = currentTime.timeIntervalSince(backgroundTimestamp)
                            let savedMins = defaults.integer(forKey: "SavedMinuteCountDown")
                            var remainingTime = TimeInterval(savedMins * 60) - timeInterval
                            if remainingTime > 0 {
                                let remainingMinutes = Int(remainingTime) / 60
                                
                                timeRemaining = remainingMinutes
                                startTimer(TimeRemaining: timeRemaining)
                            } else {
                                defaults.setValue(false, forKey: "TimerHasStarted")
                            }
                        }
                        
                    } 
                    
                })
                
                .padding(.horizontal, 20)
                
                
                
            }
            
            .onDisappear(perform: {
                print("Will dissapear...")
                    self.stopTimer()
                    backgroundTimestamp = Date()
                    defaults.setValue(timeRemaining, forKey: "SavedMinuteCountDown")
                    defaults.setValue(backgroundTimestamp, forKey: "BackgroundTimestamp")
                    defaults.synchronize()
            })
            
            .onAppear {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
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
    
    func configDay() {
        if let savedDate = defaults.object(forKey: "LastSavedDay") as? Date {
            
            if Calendar.current.isDate(savedDate, inSameDayAs: userCurrentDate ?? Date()) {
                print("Dawn of a new day...")
                addTimeToDefaults(data: 0)
                defaults.set(userCurrentDate, forKey: "LastSavedDay")
            }
        } else {
            defaults.set(userCurrentDate, forKey: "LastSavedDay")
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
    
    func startTimer(TimeRemaining: Int) {
        timeRemaining = TimeRemaining
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
                timer = nil
                print("Time Ended")
                AudioController.sharedObjc.playSelectedAudio(audio: audioSelected ?? "")
                addTimeToDefaults(data: 25)
            }
        })
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func addTimeToDefaults(data: Int) {
        timeFocused = defaults.integer(forKey: "timeFocused")
        tagSelected = defaults.string(forKey: "TagSelected")
        timeFocused! += data
        
        if let savedData = defaults.object(forKey: "FocusedData") as? Data {
            do {
                var saved = try JSONDecoder().decode([SavedArrayTags].self, from: savedData)
                
                if let index = saved.firstIndex(where: { $0.tagName == tagSelected }) {
                    saved[index].minutesFocused += data
                    
                    let encoded = try JSONEncoder().encode(saved)
                    defaults.setValue(encoded, forKey: "FocusedData")
                } else {
                    print("No tag found.")
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
        
        defaults.set(timeFocused, forKey: "timeFocused")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FastPomodoro()
    }
}
