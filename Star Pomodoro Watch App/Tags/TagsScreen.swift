//
//  TagsScreen.swift
//  Star Pomodoro Watch App
//
//  Created by Henrique Marques on 11/07/23.
//

import SwiftUI
import WatchKit

struct TagsScreen: View {
    
    @State var text: String = ""
    @ObservedObject var data = TagsScreenModelPopulate()
    @State var tagSelected: String = ""
    @State var arrayTags: [SavedArrayTags] = []
    
    var body: some View {
        List {
            Section {
                ForEach(arrayTags, id: \.self) { datum in
                    HStack {
                        Text(datum.tagName)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        
                        if tagSelected == datum.tagName {
                            Image(systemName: "checkmark")
                                .foregroundColor(Color.accentColor)
                                .frame(alignment: .trailing)
                        }
                    }
                    .onTapGesture {
                        print("Teste")
                        tagSelected = datum.tagName
                        UserDefaults.standard.set(tagSelected, forKey: "TagSelected")
                    }
                }
               
                .onDelete { IndexSet in
  //                  data.removeTag(atIndex: IndexSet)
            
//                    if var index = UserDefaults.standard.array(forKey: "ArrayOfTags") as? [String] {
//                        index.remove(atOffsets: IndexSet)
//                        arrayTags = index
//                        tagSelected = ""
//                        UserDefaults.standard.set(arrayTags, forKey: "ArrayOfTags")
//                    }
                    
                    if let savedData = UserDefaults.standard.object(forKey: "FocusedData") as? Data {
                        do {
                            var saved = try JSONDecoder().decode([SavedArrayTags].self, from: savedData)
                            saved.remove(atOffsets: IndexSet)
                            arrayTags = saved
                            let encoded = try JSONEncoder().encode(saved)
                            UserDefaults.standard.setValue(encoded, forKey: "FocusedData")
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                    
                }
            } header: {
                VStack {
                    Text("You can set the task that you doing for metrics.")
                        .textCase(nil)
                        .padding(.bottom, 10)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.white)
                    
                    Button("Add Task") {
                        WKExtension.shared().visibleInterfaceController?.presentTextInputController(withSuggestions: ["Study", "Programming"], allowedInputMode: .plain, completion: { text in
                            
                            if text == nil {
                            } else {
//                                if var savedTags = UserDefaults.standard.array(forKey: "ArrayOfTags") as? [String] {
//                                    print(text?.first)
//                                    let tagToSave = text?.first
//                                    
//                                    savedTags.append(tagToSave as! String)
//                                    tagSelected = tagToSave as! String
//                                    arrayTags = savedTags
//                                    print(savedTags)
//                                    UserDefaults.standard.set(savedTags, forKey: "ArrayOfTags")
//                                }
                                if let savedData = UserDefaults.standard.object(forKey: "FocusedData") as? Data {
                                    do {
                                        var saved = try JSONDecoder().decode([SavedArrayTags].self, from: savedData)
                                        let tagToSave = text?.first
                                        saved.append(SavedArrayTags(tagName: tagToSave as! String, minutesFocused: 0))
                                        arrayTags = saved
                                        let encoded = try JSONEncoder().encode(saved)
                                        UserDefaults.standard.setValue(encoded, forKey: "FocusedData")
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                }
                                
                            }
                        })

                    }
                }
                .foregroundColor(Color.orange)
            } footer: {
                HStack {
//                    TextField("Enter a new one...", text: $text) {
                        //data.addData(text)
//                        tagSelected = text
//                        if var savedTags = UserDefaults.standard.array(forKey: "ArrayOfTags") as? [String] {
//                            savedTags.append(text)
//                            arrayTags = savedTags
//                            print(arrayTags)
//                            UserDefaults.standard.set(arrayTags, forKey: "ArrayOfTags")
//                       }
                        
//                        text = ""
                        
                        Text("Swipe to left to delete an item")
                            .multilineTextAlignment(.trailing)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }.padding()
            }
            
//        }

        .navigationTitle("Tags")
        .onAppear {
            text = ""
            
            // Resolver isso...
            
//           var arrayToSave = [SavedArrayTags(tagName: "Work", minutesFocused: 0),
//                              SavedArrayTags(tagName: "Study", minutesFocused: 0),
//                              SavedArrayTags(tagName: "Other", minutesFocused: 0)]
//            
//            do {
//                let encoded = try JSONEncoder().encode(arrayToSave)
//                UserDefaults.standard.setValue(encoded, forKey: "FocusedData")
//            } catch {
//                print(error.localizedDescription)
//            }
            
            
////
//           var arrayOfTags = ["Work", "Study", "Workout", "Other"]
//           let save = UserDefaults.standard
//           save.set(arrayOfTags, forKey: "ArrayOfTags")
                
            
//            if let tagSelec = UserDefaults.standard.string(forKey: "tagSelected") {
//                tagSelected = tagSelec
//            }
            
//            let arr = SavedArrayTags(tagName: "Work", minutesFocused: 0), SavedArrayTags(tagName: "Study", minutesFocused: 0), SavedArrayTags(tagName: "Workout", minutesFocused: 0)
            
//            UserDefaults.standard.set(arr, forKey: "SavedArrayTags")
//
//            if let ob = UserDefaults.standard.array(forKey: "SavedArrayTags") as? [SavedArrayTags] {
//                print(ob)
//            }
            
//
            
            tagSelected = UserDefaults.standard.string(forKey: "TagSelected") ?? "Study"
            
//            if let objc = UserDefaults.standard.array(forKey: "ArrayOfTags") as? [String] {
//                print(objc)
//                arrayTags = objc
//                print(arrayTags)
//            }
            
            if let savedData = UserDefaults.standard.object(forKey: "FocusedData") as? Data {
                do {
                    let saved = try JSONDecoder().decode([SavedArrayTags].self, from: savedData)
                    arrayTags = saved
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct TagsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TagsScreen()
    }
}
