//
//  TagsScreen.swift
//  Star Pomodoro Watch App
//
//  Created by Henrique Marques on 11/07/23.
//

import SwiftUI

//struct SavedArrayTags {
//    let tagName: String
//    let minutesFocused: Int
//}

struct TagsScreen: View {
    
    @State var text: String = ""
    @ObservedObject var data = TagsScreenModelPopulate()
    @State var tagSelected: String = ""
    @State var arrayTags: [String] = []
    
    var body: some View {
        List {
            Section {
                ForEach(arrayTags, id: \.self) { datum in
                    HStack {
                        Text(datum)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        
                        if tagSelected == datum {
                            Image(systemName: "checkmark")
                                .foregroundColor(Color.accentColor)
                                .frame(alignment: .trailing)
                        }
                    }
                    .onTapGesture {
                        print("Teste")
                        tagSelected  = datum
                        UserDefaults.standard.set(tagSelected, forKey: "TagSelected")
                    }
                }
               
                .onDelete { IndexSet in
  //                  data.removeTag(atIndex: IndexSet)
            
                    if var index = UserDefaults.standard.array(forKey: "ArrayOfTags") as? [String] {
                        index.remove(atOffsets: IndexSet)
                        arrayTags = index
                        tagSelected = ""
                        UserDefaults.standard.set(arrayTags, forKey: "ArrayOfTags")
                    }
                    
                }
            } header: {
                Text("You can set the task that you doing for metrics.")
                    .textCase(nil)
                    .padding(.bottom, 10)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
            } footer: {
                HStack {
                    TextField("Enter a new one...", text: $text) {
                        //data.addData(text)
                        tagSelected = text
                        if var savedTags = UserDefaults.standard.array(forKey: "ArrayOfTags") as? [String] {
                            savedTags.append(text)
                            arrayTags = savedTags
                            print(arrayTags)
                            UserDefaults.standard.set(arrayTags, forKey: "ArrayOfTags")
                        }
                        
                        text = ""
                        
                        Text("Swipe to left to delete an item")
                            .multilineTextAlignment(.trailing)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }.padding()
            }
        }
        .navigationTitle("Tags")
        .onAppear {
            text = ""
            
           var arrayOfTags = ["Work", "Study", "Workout"]
            let save = UserDefaults.standard
            save.set(arrayOfTags, forKey: "ArrayOfTags")
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
            
            if let objc = UserDefaults.standard.array(forKey: "ArrayOfTags") as? [String] {
                print(objc)
                arrayTags = objc
                print(arrayTags)
            }
        }
    }
}

struct TagsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TagsScreen()
    }
}
