//
//  ViewController.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 02/08/23.
//

import UIKit

class HomeController: UIViewController {
    
    var alerts: Alerts?
    var defaults = UserDefaults.standard
    var backgroundTimestamp: Date?
    var homeScreen: HomeScreen?
    var personalitySelected: String?
    var timer: Timer?
    var returningFromBackground = false
    var timerHasStarted = false
    var hourCountDown = 0
    var minuteCountDown = 0
    var secondCountDown = 0
    var defaultValue = 25
    
    override func loadView() {
        self.homeScreen = HomeScreen()
        self.view = homeScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.alerts = Alerts(controller: self)
  //      self.restorationIdentifier = "HomeRestorarionIdenfier"
        self.homeScreen?.delegate(delegate: self)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)

        
        self.configNavigationController()
        self.requestNotifications()
        self.showLauchscreenAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.homeScreen?.circularSlider.endPointValue = 25
        self.personalitySelected = UserDefaults.standard.string(forKey: "PersonalitySelected")
        self.homeScreen?.actualSliderValue.text = String(defaultValue) + ":00"
        timerHasStarted = defaults.bool(forKey: "TimerHasStarted")
        if timerHasStarted == true {
            print("TimeHasStarted")
            self.getPhrase()
        }
        
        // DEBUG SAVING
//        self.homeScreen?.actualSliderValue.text = "Mins: \(minuteCountDown): Secs: \(secondCountDown)"
        print("DEBUG SAVING MINS: \(minuteCountDown)")
        print("DEBUG SAVING SECS: \(secondCountDown)")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    func configNavigationController() {
//        self.title = "Star Pomodoro"
        self.navigationController?.navigationBar.prefersLargeTitles = false
//        let appearance = UINavigationBarAppearance()
//        appearance.backgroundColor = .tertiarySystemBackground
//        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
//        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
//        navigationController?.navigationBar.tintColor = .label
//        navigationController?.navigationBar.standardAppearance = appearance
//        navigationController?.navigationBar.compactAppearance = appearance
//        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let configIcon = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(configIconTapped))
        configIcon.tintColor = .systemYellow
        self.navigationItem.setRightBarButtonItems([configIcon], animated: true)
    }
    
    
    @objc func configIconTapped() {
        let vc = SettingsController()
        
        if let sheet = vc.sheetPresentationController {
            
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.selectedDetentIdentifier = .medium
            sheet.largestUndimmedDetentIdentifier = .medium
        }
        self.present(vc, animated: true)
    }
    
    @objc func appWillResignActive() {
        print("DEBUG MODE: WILL STOP....")
        if timerHasStarted {
            self.stopTimer()
            backgroundTimestamp = Date()
            
            defaults.setValue(minuteCountDown, forKey: "SavedMinuteCountDown")
            defaults.setValue(secondCountDown, forKey: "SavedSecondCountDown")
            defaults.setValue(backgroundTimestamp, forKey: "BackgroundTimestamp")
            defaults.synchronize()
        }
    }
    
    @objc func appDidBecomeActive() {
        self.returningFromBackground = true
        if let backgroundTimestamp = UserDefaults.standard.object(forKey: "BackgroundTimestamp") as? Date {
            self.homeScreen?.startButton.removeFromSuperview()
            self.homeScreen?.buttonsStackView.addArrangedSubview(homeScreen?.giveUpButton ?? UIView())
            self.getPhrase()
            let currentTime = Date()
            let timeInterval = currentTime.timeIntervalSince(backgroundTimestamp)
            let savedMins = defaults.integer(forKey: "SavedMinuteCountDown")
            let savedSecs = defaults.integer(forKey: "SavedSecondCountDown")
            let remainingTime = TimeInterval(savedMins * 60 + savedSecs) - timeInterval
            if remainingTime > 0 {
                let remainingMinutes = Int(remainingTime) / 60
                let remainingSeconds = Int(remainingTime) % 60
                
                minuteCountDown = remainingMinutes
                secondCountDown = remainingSeconds
                self.timerHasStarted = false
                startTimer(minutesCount: minuteCountDown, secondsCount: secondCountDown)
            } else {
                self.homeScreen?.primaryLabel.text = "Let's rest?"
                defaults.setValue(false, forKey: "TimerHasStarted")
                self.homeScreen?.buttonsStackView.addArrangedSubview(homeScreen?.restButton ?? UIView())
                self.homeScreen?.giveUpButton.removeFromSuperview()
                self.homeScreen?.startButton.removeFromSuperview()
            }
        }
    }
    
    func requestNotifications() {
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
    
    func getMotivotinalPhrase() {
        HomeService.sharedObjc.getMotivotionalPhrase { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.homeScreen?.phraseLabel.text = data?.phrase ?? ""
                }
            case .failure(let error):
                print("Error \(error.localizedDescription)")
            }
        }
    }
    
    func getUnmotivadedPhrase() {
        HomeService.sharedObjc.getunmotivadedPhrase { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.homeScreen?.phraseLabel.text = data?.phrase ?? ""
                }
            case .failure(let error):
                print("Error \(error.localizedDescription)")
            }
        }
    }
    
    func getPhrase() {
        if personalitySelected == "Motivational" {
            self.getMotivotinalPhrase()
        } else {
            self.getUnmotivadedPhrase()
        }
    }

    func startTimer(minutesCount: Int, secondsCount: Int) {
        if timerHasStarted == true {
            
        } else {
            self.timerHasStarted = true
            self.minuteCountDown = minutesCount
            self.secondCountDown = secondsCount
            
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                if self.secondCountDown > 0 {
                    self.secondCountDown = self.secondCountDown - 1
                } else if self.minuteCountDown > 0 && self.secondCountDown == 0 {
                    self.minuteCountDown = self.minuteCountDown - 1
                    self.secondCountDown = 59
                } else if self.hourCountDown > 0 && self.minuteCountDown == 0 && self.secondCountDown == 0 {
                    self.timerHasStarted = false
                    self.hourCountDown = self.hourCountDown - 1
                    self.minuteCountDown = 59
                    self.secondCountDown = 59
                }
                print(self.minuteCountDown)
                let formattedMinute = String(format: "%02d", self.minuteCountDown)
                let formattedSecond = String(format: "%02d", self.secondCountDown)
                self.homeScreen?.circularSlider.endPointValue = CGFloat(self.minuteCountDown-1)
                
                if self.hourCountDown == 0 {
                    self.homeScreen?.actualSliderValue.text = "\(formattedMinute):\(formattedSecond)"
                } else {
                    self.homeScreen?.actualSliderValue.text = "\(formattedMinute):\(formattedSecond)"
                }
            }
        }
    }
    
    func stopTimer() {
        self.timerHasStarted = false
        timer?.invalidate()
        timer = nil
//        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        self.homeScreen?.circularSlider.endPointValue = 25.0
        defaults.set(defaultValue, forKey: "SavedMinuteCountDown")
        defaults.set(0, forKey: "SavedSecondCountDown")
        defaults.removeObject(forKey: "BackgroundTimestamp")
        self.homeScreen?.actualSliderValue.text = String(defaultValue) + ":00"
        self.homeScreen?.primaryLabel.text = "Let's get focused?"
        self.homeScreen?.circularSlider.isUserInteractionEnabled = true
        self.homeScreen?.buttonsStackView.addArrangedSubview(homeScreen?.startButton ?? UIView())
        self.homeScreen?.giveUpButton.removeFromSuperview()
    }
    
    func showLauchscreenAnimation() {
        self.homeScreen?.contentView.removeFromSuperview()
        self.homeScreen?.launchAnimation.play { _ in
            UIView.animate(withDuration: 0.5, animations: {
                self.homeScreen?.launchAnimation.alpha = 0
            }, completion: { _ in
                self.homeScreen?.launchAnimation.isHidden = true
                self.homeScreen?.launchAnimation.removeFromSuperview()
                self.homeScreen?.launchView.removeFromSuperview()
                self.homeScreen?.addSubview(self.homeScreen?.contentView ?? UIView())
            })
        }
    }
}

extension HomeController: HomeScreenProtocol {
    
    func startButtonAction() {
        AudioController.sharedObjc.playSelectedAudio(audio: "StartPomodoro.mp3")
        self.homeScreen?.primaryLabel.text = "Keep going..."
//        self.homeScreen?.lottieAnimation.animation = .named("stars.json")
//        self.homeScreen?.lottieAnimation.play()
        self.homeScreen?.startButton.removeFromSuperview()
        self.homeScreen?.buttonsStackView.addArrangedSubview(homeScreen?.giveUpButton ?? UIView())
        self.homeScreen?.circularSlider.isUserInteractionEnabled = false
        self.getPhrase()
        let convertion = Int(self.homeScreen?.circularSlider.endPointValue ?? CGFloat())
        self.startTimer(minutesCount: convertion, secondsCount: 0)
        let notificationTimeInterval = self.homeScreen?.circularSlider.endPointValue ?? CGFloat()
        let convertToSeconds = notificationTimeInterval*60
        print("DEBUG: SECONDS \(convertToSeconds)")
        NotificationManager.sharedObjc.getNotification(title: "Your Pomodoro has ended", body: "Let's rest a little bit?", timeInterval: convertToSeconds, identifier: "Default_Identifier")
        
    }
    
    func giveUpButtonAction() {
//        self.stopTimer()
        self.alerts?.getAlert(title: "Cancel Pomodoro?", message: "Are you sure?", buttonMessage: "Cancel", destructiveAction: {
            self.stopTimer()
        })
      
    }
    
    func restButtonAction() {
        let convertion = Int(self.homeScreen?.circularSlider.endPointValue ?? CGFloat())
        self.startTimer(minutesCount: convertion, secondsCount: 0)
        let notificationTimeInterval = self.homeScreen?.circularSlider.endPointValue ?? CGFloat()
        let convertToSeconds = notificationTimeInterval*60
        NotificationManager.sharedObjc.getNotification(title: "Break has ended", body: "Let's rest a focus?", timeInterval: convertToSeconds, identifier: "Default_Identifier_Resting")
    }
    
}

extension HomeController {
    
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        print("ENCODE")
//        coder.encode(hourCountDown, forKey: "hourCountDown")
        coder.encode(minuteCountDown, forKey: "minuteCountDown")
        coder.encode(secondCountDown, forKey: "secondCountDown")

    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        minuteCountDown = coder.decodeInteger(forKey: "minuteCountDown")
        secondCountDown = coder.decodeInteger(forKey: "secondCountDown")
    }
}

