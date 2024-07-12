//
//  OnboardingController.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 19/09/23.
//

import UIKit

class OnboardingController: UIViewController {
    
    var onboardingView: OnboardingView?
    var onboardingViewModel: OnboardingViewModel?
    var index = 0
    
    override func loadView() {
        self.onboardingView = OnboardingView()
        self.view = onboardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.onboardingViewModel = OnboardingViewModel()
        self.onboardingView?.onboardingCollectionViewProtocols(delegate: self, dataSource: self)
        self.onboardingViewModel?.populateObjc()
        self.onboardingView?.delegate(delegate: self)
        self.navigationItem.hidesBackButton = true
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
}

extension OnboardingController: OnboardingViewProtocol {
    
    func skipIntroButton() {
        let nextIndex = min((self.onboardingView?.onboardingViewPageControl.currentPage ?? 0) + 1, (onboardingViewModel?.objc.count ?? 0) + 1)
        let index = IndexPath(item: nextIndex, section: 0)
        self.onboardingView?.onboardingViewPageControl.currentPage = nextIndex
        print(nextIndex)
        
        if nextIndex == 3 {
            let vc = HomeController()
            self.navigationItem.hidesBackButton = true
            self.navigationController?.pushViewController(vc, animated: true)
        } else if nextIndex == 1 {
            self.onboardingView?.onboardingCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        } else {
            self.onboardingView?.onboardingCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        }
    }
}

extension OnboardingController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.onboardingView?.onboardingViewPageControl.numberOfPages = onboardingViewModel?.count ?? 0
        return onboardingViewModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier, for: indexPath) as? OnboardingCell else {return UICollectionViewCell()}
        if let data = onboardingViewModel?.indexPath(indexPath: indexPath) {
            cell.setUpCell(data: data)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == 2 {
            self.index = -2
            self.onboardingView?.skipIntroButton.setTitle("Begin", for: .normal)
        } else if indexPath.row == 1 {
            self.index = -1
            self.requestNotifications()
            self.onboardingView?.skipIntroButton.setTitle("Next", for: .normal)
        } else {
            self.onboardingView?.skipIntroButton.setTitle("Next", for: .normal)
        }
        
        guard let visible = collectionView.visibleCells.last else {return}
        guard let index = collectionView.indexPath(for: visible)?.row else {return}
        self.onboardingView?.onboardingViewPageControl.currentPage = index
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let visible = collectionView.visibleCells.last else {return}
        guard let index = collectionView.indexPath(for: visible)?.row else {return}
        self.onboardingView?.onboardingViewPageControl.currentPage = index
    }
}

