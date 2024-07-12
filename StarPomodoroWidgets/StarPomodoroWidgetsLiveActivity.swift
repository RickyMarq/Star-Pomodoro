//
//  StarPomodoroWidgetsLiveActivity.swift
//  StarPomodoroWidgets
//
//  Created by Henrique Marques on 15/09/23.
//

import ActivityKit
import WidgetKit
import SwiftUI
import Lottie

struct PomodoroLiveActivitiesWidget: Widget {
        
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: PomodoroAttributes.self) { content in
            
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.black)
                
                VStack {
                    HStack {
                        
                        Image(systemName: "sparkles")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.yellow)
                            .frame(width: 40, height: 40)
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                        
                        HStack {

                            Text(timerInterval: Date()...Date().addingTimeInterval(content.attributes.minutesLeft), countsDown: true, showsHours: false)
                                        .font(.title)
                            
                            Spacer()
                            
                            Text(content.attributes.tagSelected)
                                .foregroundStyle(.yellow)
                                .font(.subheadline)

                        }

                            Text(String(content.attributes.phrase))
                                .font(.footnote)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        
                        Spacer()
                        
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)

                    
                }
                .padding(15)

            }
        } dynamicIsland: { context in
            
            DynamicIsland {

                DynamicIslandExpandedRegion(.leading) {
                    Image(systemName: "sparkles")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.yellow)
                        .frame(width: 20, height: 20)
                }

                DynamicIslandExpandedRegion(.center) {
                    
                    VStack {
                        
                        HStack {
                            Text(timerInterval: Date()...Date().addingTimeInterval(context.attributes.minutesLeft), countsDown: true, showsHours: false)
                                .font(.title)
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                            
                            Text(context.attributes.tagSelected)
                                .foregroundStyle(.yellow)
                                .font(.subheadline)
                        }
                        
//                        Text(timerInterval: Date()...Date().addingTimeInterval(context.attributes.minutesLeft), countsDown: true, showsHours: false)
//                            .font(.title)
//                            .multilineTextAlignment(.leading)
                        
                        Text(String(context.attributes.phrase))
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                        
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(0)

                    }
                }

            } compactLeading: {
                Image(systemName: "sparkles")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.yellow)
                    .frame(width: 20, height: 20)
            } compactTrailing: {
                Text(timerInterval: Date()...Date().addingTimeInterval(context.attributes.minutesLeft), countsDown: true, showsHours: false)
                    .multilineTextAlignment(.center)
                    .frame(width: 40)
                    .font(.caption2)
            } minimal: {
                Text(timerInterval: Date()...Date().addingTimeInterval(context.attributes.minutesLeft), countsDown: true, showsHours: false)
                    .multilineTextAlignment(.center)
                    .frame(width: 40)
                    .font(.caption2)
            }
            .keylineTint(Color.yellow)
        }
    }
}

func stopLiveActivities() {
    
    Task {
        for activity in Activity<PomodoroAttributes>.activities {
            await activity.end(nil, dismissalPolicy: .immediate)
        }
    }
}
