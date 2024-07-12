//
//  TagController.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 19/09/23.
//

import UIKit
import TagListView

protocol TagControllerProtocol: AnyObject {
    func updateValue(tag: String)
    func emptyStackOfTags()
}

class TagController: UIViewController {
        
    var tagViewScreen: tagScreen?
    var lastTitle: String = ""
    var defaults = UserDefaults.standard
    var currentTag = ""
    var stackOfTags: [String] = []
    var alerts: Alerts?
    
    weak var delegate: TagControllerProtocol?
    
    func delegate(delegate: TagControllerProtocol) {
        self.delegate = delegate
    }
    
    override func loadView() {
        self.tagViewScreen = tagScreen()
        self.view = tagViewScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        alerts = Alerts(controller: self)
        tagViewScreen?.tagListDelegate(delegate: self)
        tagViewScreen?.delegate(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configInitialTags()
    }
    
    func configInitialTags() {
        print("DEBUG MODE: POGCHAMP")
        let stackOfTags = defaults.array(forKey: "TagSaved") ?? []
        
        for tags in stackOfTags {
        
//            print("DEBUG MODE: COUNT Initial: \(stackOfTags.count)")
//            print("DEBUG MODE: Tags \(tags)")
            self.tagViewScreen?.tagList.addTag(tags as? String ?? "")
            
        }
        
//         self.tagViewScreen?.tagList.tagViews[0].isSelected = true
        
//        print("DEBUG MODE: ")
        if tagViewScreen?.tagList.tagViews.count ?? 0 == 0 {
            print("drawer of tags is empty")
            self.delegate?.emptyStackOfTags()
        } else {
            self.tagViewScreen?.tagList.tagViews[0].isSelected = true
        }
    }
    
    func selectFirstIndexOfStack() {
        let stackOfTags = defaults.array(forKey: "TagSaved") ?? []
        
//        for tags in stackOfTags {
//            self.delegate?.updateValue(tag: tags as? String ?? "")
//        }

        if tagViewScreen?.tagList.tagViews.count ?? 0 == 0 {
            self.delegate?.emptyStackOfTags()
        } else {
            self.tagViewScreen?.tagList.tagViews[0].isSelected = true
            let firstTag = tagViewScreen?.tagList.tagViews[0].currentTitle ?? ""
            self.delegate?.updateValue(tag: firstTag)
            
        }
    }
}

extension TagController: TagListViewDelegate {

    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print(title)
        stackOfTags = defaults.array(forKey: "TagSaved") as? [String] ?? []

        self.delegate?.updateValue(tag: title)
        currentTag = title
        
        if let index = stackOfTags.firstIndex(of: title) {
            stackOfTags.remove(at: index)
            stackOfTags.insert(title, at: 0)
            print("DEBUG MODE: PRESSED INSERT \(stackOfTags.count)")
            defaults.setValue(stackOfTags, forKey: "TagSaved")
        }
        
        
        defaults.set(currentTag, forKey: "currentTag")

//        tagView.allTargets.forEach { tag in
//            tagView.isSelected = true
//
//        }
        
        print("Tag pressed: \(title), \(sender)")

    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        self.alerts?.getAlert(title: "Delete tag?", message: "Are you sure do you to delete this tag?", buttonMessage: "Delete", destructiveAction: { [self] in
            print(">>> Tag Removing...: \(title)")
            stackOfTags = defaults.array(forKey: "TagSaved") as? [String] ?? []
            print("DEBUG MODE: ITEMS \(stackOfTags.count)")
            //            self.stackOfTags = []
            
            if let index = stackOfTags.firstIndex(of: title) {
                sender.removeTag(title)
                print("DEBUG MODE: Index \(index)")
                print(">>> Tag Removed: \(title)")
                stackOfTags.remove(at: index)
                defaults.setValue(stackOfTags, forKey: "TagSaved")
                selectFirstIndexOfStack()

            }
            
            if stackOfTags.isEmpty {
                self.delegate?.emptyStackOfTags()
            }
        
            
//            for data in stackOfTags {
//                if data == title {
//                    sender.removeTag(title)
//                
//                }
//            }
            
        })
    
    }
}

extension TagController: tagScreenProtocol {
    
    func addNewTagAction() {
            let alert = UIAlertController(title: "New tag", message: "Insert a new tag", preferredStyle: .alert)
            alert.addTextField(configurationHandler: nil)
            let cancel = UIAlertAction(title: "Cancel", style: .default)
            let addTag = UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self] _ in
                guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {return}
                let newTag = field.text ?? ""
                
                var savedTags = self?.defaults.array(forKey: "TagSaved") ?? []
//                savedTags.append(newTag)
                savedTags.insert(newTag, at: 0)
                self?.defaults.setValue(savedTags, forKey: "TagSaved")
                self?.defaults.setValue(newTag, forKey: "currentTag")
//                print("DEBUG MODE: COUNT appeding: \(self?.stackOfTags?.count)")
//                self?.tagView  Screen?.tagList.insertTag(field.text ?? "", at: 0)
//                self?.tagViewScreen?.tagList.tagViews[0].isSelected = true
                self?.delegate?.updateValue(tag: newTag)
            })
        
            alert.addAction(cancel)
            alert.addAction(addTag)
            alert.preferredAction = addTag

            self.present(alert, animated: true)
    }
}
