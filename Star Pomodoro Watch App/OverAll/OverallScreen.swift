//
//  OverallScreen.swift
//  Star Pomodoro Watch App
//
//  Created by Henrique Marques on 09/07/23.
//

import SwiftUI
import SwiftUICharts

struct OverallScreen: View {
    
    @State var shiningStarsCount: Int = 1
    @State var isAnimating = false
    var arrayOfColor: [Color] = [Color.gray, Color.yellow, Color.accentColor, Color.pink]
    @State var arrayOfTags: [String] = []
    
    var body: some View {
        if #available(watchOS 8.0, *) {
            NavigationView {
            ScrollView {
                VStack(alignment: .center) {
                    Text("Focused Time")
                        .foregroundColor(.secondary)
                    
                    Text("0h 00min")
                        .foregroundColor(Color.accentColor)
                        .bold()
                    
                    Divider()
                    
                    VStack(alignment: .trailing) {
                        ForEach(arrayOfTags, id: \.self) { datum in
                            Text(datum)
                                .bold()
                            
                            Text("0min")
                                .foregroundColor(.accentColor)
                                .frame(alignment: .topTrailing)
                            
                            
                            
                            Rectangle()
                                .fill(Color.accentColor)
                                .cornerRadius(10)
                            
                            
                            
                        }
                    }
                    .padding(.horizontal, 5)
                    
                    Divider()
                    
                    Text("Tag Distribution")
                        .foregroundColor(Color.secondary)
                    
                    DoughnutChart(chartData: DoughnutChartData(dataSets: PieDataSet(dataPoints: [PieChartDataPoint(value: 1.0)], legendTitle: ""), metadata: ChartMetadata(title: "a"), noDataText: Text("")))
                    }
                }
                .navigationTitle("Overall")
                .navigationBarTitleDisplayMode(.inline)
            }
            
            .onAppear(perform: {
                if let objc = UserDefaults.standard.array(forKey: "ArrayOfTags") as? [String] {
                    arrayOfTags = objc
                }
            })
   
        } else {
            // Fallback on earlier versions
        }
    }
}

struct OverallScreen_Previews: PreviewProvider {
    static var previews: some View {
        OverallScreen()
    }
}
