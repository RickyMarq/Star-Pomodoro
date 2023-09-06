//
//  NotificationScreen.swift
//  Star Pomodoro Watch App
//
//  Created by Henrique Marques on 08/07/23.
//

import SwiftUI

struct NotificationScreen: View {
    
    @State var isNotificationsOn = false
    
    
    // It's necessary send notifications to alert you when the time has ended.
    
    var body: some View {
        List {
            Section(header: Text("It's necessary send notifications to alert you when the time has ended.")
                .textCase(nil)
                .padding(.bottom, 10)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .multilineTextAlignment(.trailing)) {
                HStack {
                    Text("Notify")
                        .bold()
                    Toggle(isOn: $isNotificationsOn) {
                        
                    }
                    .onAppear {
                        if UserDefaults.standard.bool(forKey: "NotificationGranted") {
                            print("Permission Accepted")
                            isNotificationsOn = true
                        } else {
                            print("Permission Denied")
                            isNotificationsOn = false
                        }
                    }
                }
            }
            
//            onAppear(perform: {
//                // Crashing because i'm trying to access a value in UserDefaults.
//
//                if UserDefaults.standard.bool(forKey: "NotificationGranted") {
//                    print("Permission Accepted")
//                    isNotificationsOn = true
//                } else {
//                    print("Permission Denied")
//                    isNotificationsOn = false
//                }
//            })
        }
        


        
        .navigationTitle("Notifications")
    }
}

struct NotificationScreen_Previews: PreviewProvider {
    static var previews: some View {
        NotificationScreen()
    }
}
