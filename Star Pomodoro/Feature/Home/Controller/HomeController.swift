//
//  ViewController.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 02/08/23.
//

import UIKit
import ActivityKit
import FloatingPanel

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
    var currentPhrase: String?
    var sheetTagController: FloatingPanelController!
    var currentTag: String?
    var stackOfTags: [String] = []
    var sessionToken: String?
    var pomodoroAlerts: PomodoroAlert?
                                                           
    override func loadView() {
        self.homeScreen = HomeScreen()
        self.view = homeScreen
    }
                                                       
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pomodoroAlerts = PomodoroAlert()
        self.alerts = Alerts(controller: self)
        self.homeScreen?.delegate(delegate: self)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        self.configNavigationController()
//        self.requestNotifications()
        self.showLauchscreenAnimation()
        sheetTagController = FloatingPanelController()
        sheetTagController.delegate = self
        sheetTagController.isRemovalInteractionEnabled = true
        sheetTagController.backdropView.backgroundColor = .red
//        sheetTagController.move(to: .tip, animated: true)
        sheetTagController.surfaceView.backgroundColor = .tertiarySystemBackground
        sheetTagController.surfaceView.grabberHandle.isHidden = false
        sheetTagController.layout = TagViewFloatingPanelLayout()
        self.navigationItem.hidesBackButton = true
//        emptyStackOfTags()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.homeScreen?.circularSlider.endPointValue = 25
        print("DEBUG MODE: HOW MANY TIMES IS CALLED?")
        self.personalitySelected = UserDefaults.standard.string(forKey: "PersonalitySelected")
        print("DEBUG MODE: Perso Selected: \(personalitySelected)")
        self.homeScreen?.actualSliderValue.text = String(defaultValue) + ":00"
 //       print("DEBUG MODE: Current tag: \(currentTag)")
        currentTag = defaults.string(forKey: "currentTag")
        if currentTag == "" {
            self.homeScreen?.tagButton.setTitle("+ Add Tag", for: .normal)
        } else {
            self.homeScreen?.tagButton.setTitle(currentTag ?? "", for: .normal)
        }
        timerHasStarted = defaults.bool(forKey: "TimerHasStarted")
//        self.homeScreen?.tagButton.setTitle(currentTag, for: .normal)
        if timerHasStarted == true {
            print("TimeHasStarted")
            self.getPhrase()
        }
        getPhrase()
        checkBoardOfTags()
        sheetTagController.backdropView.dismissalTapGestureRecognizer.isEnabled = true
        // Erase
        sessionToken = defaults.string(forKey: "SessionToken")
        print("Session Token from HOME: \(sessionToken)")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    func configNavigationController() {
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
        let userIcon = UIBarButtonItem(image: UIImage(systemName: "rectangle.stack"), style: .plain, target: self, action: #selector(configOpenSummary))
        configIcon.tintColor = .systemYellow
        userIcon.tintColor = .systemYellow
        self.navigationItem.setRightBarButtonItems([configIcon], animated: true)
  //      self.navigationItem.setLeftBarButtonItems([userIcon], animated: true)
    }
    
    func checkBoardOfTags() {
        stackOfTags = defaults.array(forKey: "TagSaved") as? [String] ?? []
        currentTag = defaults.string(forKey: "currentTag")

        print("DEBUG MODE: STC TAGS \(stackOfTags.count)")
        
        if stackOfTags.isEmpty {
            self.homeScreen?.tagButton.setTitle("+ Add Tag", for: .normal)
            print("STC IS EMPTY")
        } else {
            currentTag = defaults.string(forKey: "currentTag")
            self.homeScreen?.tagButton.setTitle(currentTag ?? "", for: .normal)
            print("STC IS NOT EMPTY")

        }
    }
    
    func initLiveActivit(minutesData: Double) {
        let initialWidgetData = PomodoroAttributes.ContentState()
        currentTag = defaults.string(forKey: "currentTag")

//        let minutesInDate = convertIntToTimeDate(minutes: minutesData) ?? Date()
//        let shouldUpdateIn = minutesData * 60
//        print(shouldUpdateIn)
        let widgetData = PomodoroAttributes(phrase: currentPhrase ?? "", minutesLeft: minutesData, tagSelected: currentTag ?? "")
        print("DEBUG MODE: \(minutesData)")
        do {
            if #available(iOS 16.1, *) {
                let activity = try Activity<PomodoroAttributes>.request(attributes: widgetData, contentState: initialWidgetData)
            } else {
                // Fallback on earlier versions
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @available(iOS 16.2, *)
    func deinitLiveActivit() {
        Task {
            for activity in Activity<PomodoroAttributes>.activities {
                await activity.end(nil, dismissalPolicy: .immediate)
            }
        }
    }
    
    @available(iOS 16.2, *)
    func updateLiveActivit() {
        Task {
            let updatedData = PomodoroAttributes.ContentState()

            for activity in Activity<PomodoroAttributes>.activities {
                await activity.update(using: updatedData)
            }
        }
    }

    func convertIntToTimeDate(minutes: Int) -> Date? {
        let seconds = TimeInterval(minutes * 60)
        print("DEBUG MODE: TIME TRAVEL -> \(Date(timeIntervalSinceNow: seconds))")
        return Date(timeIntervalSinceNow: seconds)
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
    
    @objc func configOpenSummary() {
        let vc = SummaryController()
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
            self.stopTimerForBackground()
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
//                self.homeScreen?.primaryLabel.text = "Let's rest?"
                defaults.setValue(false, forKey: "TimerHasStarted")
                self.homeScreen?.giveUpButton.removeFromSuperview()
                self.homeScreen?.buttonsStackView.addArrangedSubview(homeScreen?.startButton ?? UIView())
                self.homeScreen?.circularSlider.endPointValue = 25
                self.homeScreen?.actualSliderValue.text = String(defaultValue) + ":00"

  //              self.homeScreen?.giveUpButton.removeFromSuperview()
            }
        }
    }
    
    func requestNotifications() {
        if UserDefaults.standard.bool(forKey: "NotFirstLaunch") == false {
            UserDefaults.standard.set(false, forKey: "NotFirstLaunch")
            UserDefaults.standard.setValue("Motivational", forKey: "PersonalitySelected")
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
    }
    
    func getMotivotinalPhrase() {
        HomeService.sharedObjc.getMotivotionalPhrase { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.homeScreen?.phraseLabel.text = data?.phrase ?? ""
                    self.currentPhrase = data?.phrase ?? ""
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
                    self.currentPhrase = data?.phrase ?? ""
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
            UserDefaults.standard.synchronize()
            self.personalitySelected = UserDefaults.standard.string(forKey: "PersonalitySelected")
            self.timerHasStarted = true
            self.minuteCountDown = minutesCount
            self.secondCountDown = secondsCount
            self.homeScreen?.primaryLabel.text = "Keep going..."
            self.homeScreen?.lottieAnimation.animation = .named("ZTGMCo71eD (1).json")
            self.homeScreen?.lottieAnimation.play()
            self.homeScreen?.circularSlider.isUserInteractionEnabled = false

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
                
                if self.hourCountDown == 0 && self.minuteCountDown == 0 && self.secondCountDown == 0 {
                    self.stopTimer()
                    if #available(iOS 16.2, *) {
                        self.deinitLiveActivit()
                    }
                }
            }
        }
    }
    
    func stopTimer() {
        print("STOP TIMER!!!")
        self.timerHasStarted = false
        timer?.invalidate()
        timer = nil
        self.homeScreen?.lottieAnimation.stop()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
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
    
    func stopTimerForBackground() {
        self.timerHasStarted = false
        timer?.invalidate()
        timer = nil
        self.homeScreen?.lottieAnimation.stop()
        defaults.set(defaultValue, forKey: "SavedMinuteCountDown")
        defaults.set(0, forKey: "SavedSecondCountDown")
        defaults.removeObject(forKey: "BackgroundTimestamp")
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
//        self.homeScreen?.lottieAnimation.animation = .named("ZTGMCo71eD (1).json")
//        self.homeScreen?.lottieAnimation.play()
        self.personalitySelected = UserDefaults.standard.string(forKey: "PersonalitySelected")
        self.homeScreen?.startButton.removeFromSuperview()
        self.homeScreen?.buttonsStackView.addArrangedSubview(homeScreen?.giveUpButton ?? UIView())
        self.homeScreen?.circularSlider.isUserInteractionEnabled = false
        self.getPhrase()
        let convertion = Int(self.homeScreen?.circularSlider.endPointValue ?? CGFloat())
        self.startTimer(minutesCount: convertion, secondsCount: 0)

        let notificationTimeInterval = self.homeScreen?.circularSlider.endPointValue ?? CGFloat()
        let convertToSeconds = notificationTimeInterval*60
        print("DEBUG: SECONDS \(convertToSeconds)")
        initLiveActivit(minutesData: convertToSeconds)
        NotificationManager.sharedObjc.getNotification(title: "Your Pomodoro has ended", body: "Let's rest a little bit?", timeInterval: convertToSeconds, identifier: "Default_Identifier")
        
    }
    
    func giveUpButtonAction() {
        if #available(iOS 16.2, *) {
            deinitLiveActivit()
        }
        
//        pomodoroAlerts?.showAlert(with: "Yeha", message: "", ViewController: self)
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
    
    func tagButtonAction() {
        let vc = TagController()
        vc.delegate = self
        sheetTagController.set(contentViewController: vc)
        sheetTagController.addPanel(toParent: self, animated: true)
        sheetTagController.move(to: .tip, animated: true)
    }
}

extension HomeController: FloatingPanelControllerDelegate {
    
    func floatingPanelDidChangeState(_ fpc: FloatingPanelController) {
        print("Floating Panel did move?")
        fpc.backdropView.dismissalTapGestureRecognizer.isEnabled = true

    }
}

extension HomeController: TagControllerProtocol {
  
    func updateValue(tag: String) {
        self.homeScreen?.tagButton.setTitle(tag, for: .normal)
        currentTag = tag
        defaults.setValue(currentTag, forKey: "currentTag")
        self.sheetTagController.move(to: .hidden, animated: true)
    }
    
    func emptyStackOfTags() {
        print("DEBUG MODE: EMPTY STACK CALLED")
        self.homeScreen?.tagButton.setTitle("+ Add Tag", for: .normal)
        currentTag = ""
        defaults.setValue(currentTag, forKey: "currentTag")
    }
    
}
