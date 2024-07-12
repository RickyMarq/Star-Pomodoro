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
    @State var timeFocused: Int?
    @State var arrayOfTags: [SavedArrayTags] = []
    @State var hours: Int?
    @State var minutes: Int?
    @State var dataPointsChart: [PieChartDataPoint] = []
    @State var arrayOfColors: [Color] = [Color.orange, Color.red, Color.yellow]

    
    var body: some View {
        if #available(watchOS 8.0, *) {
            NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Focused Time")
                        .foregroundColor(.secondary)
                        .padding(.vertical, 2.5)
                        .padding(.horizontal)
                    
                    Text(String(hours ?? 0) + " hr " + String(minutes ?? 0) + " Mins ")
//                        .fontWeight(12)
                        .bold()
                        .foregroundColor(Color.accentColor)
                        .padding(.vertical, 2.5)
                        .padding(.horizontal)

                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Tasks")
 //                           .padding()
                            .frame(maxWidth: .infinity, alignment: .center)

                        ForEach(arrayOfTags, id: \.id) { datum in
                            HStack(alignment: .firstTextBaseline) {
                                Text(datum.tagName)
                                    .bold()
                                
                                // datum.minutesFocused + "Min"
                                Text(String(datum.minutesFocused) + " Min")
                                    .foregroundColor(.accentColor)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                
                                
                            }
                            
                            let maximMinutesFocused = arrayOfTags.max(by:  { $0.minutesFocused < $1.minutesFocused })?.minutesFocused ?? 1
                            
                            GeometryReader { geometry in
                                Rectangle()
                                    .fill(datum.minutesFocused == maximMinutesFocused ? Color.green : Color.accentColor)
                                 //   .fill(Color.accentColor)
                                    .cornerRadius(10)
                                     .frame(width: CGFloat(datum.minutesFocused) / CGFloat(100) * geometry.size.width, height: 10)

                            }
                            
                            
                        }
                        Divider()
                        
                        
//                        Text("Tag Distribution")
//                            .bold()
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .padding()
//
//
//                        DoughnutChart(chartData: DoughnutChartData(dataSets: PieDataSet(dataPoints: dataPointsChart, legendTitle: "Tag Distribution."), metadata: ChartMetadata(title: "Tag Distribution"), noDataText: Text("Tag Distribution")))
////                            .legends(chartData: DoughnutChartData(dataSets: dataPointsChart, metadata: ChartMetadata(title: "Tag Distribution"), noDataText: Text("Tag Distribution")), columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())])
////                            .headerBox(chartData: DougnutChartData(dataSets: dataPointsChart,
////                                                                    metadata: ChartMetadata(title: "Doughnut", subtitle: "mmm doughnuts"),
////                                                                    chartStyle: DoughnutChartStyle(infoBoxPlacement: .header),
////                                                                    noDataText: Text("hello"))
//                                .frame(height: 100, alignment: .leading)
//                                .padding(.leading)
                        

                       }
                    }
                }
                .navigationTitle("Overall")
                .navigationBarTitleDisplayMode(.inline)
            }
            
            .onAppear(perform: {
//                if let objc = UserDefaults.standard.array(forKey: "ArrayOfTags") as? [String] {
//                    arrayOfTags = objc
//                }
                dataPointsChart = []
                
                if let savedData = UserDefaults.standard.object(forKey: "FocusedData") as? Data {
                    do {
                        let saved = try JSONDecoder().decode([SavedArrayTags].self, from: savedData)
                        arrayOfTags = saved
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                
            
                for datum in arrayOfTags {
                    let datumPoints = PieChartDataPoint(value: Double(datum.minutesFocused), colour: Color.random(randomOpacity: false), label: .label(text: datum.tagName, rFactor: 1.0))
                    print("TAG: " + datum.tagName)
                    print("TF: " + String(datum.minutesFocused))
                    dataPointsChart.append(datumPoints)
                }
                
                timeFocused = UserDefaults.standard.integer(forKey: "timeFocused")
                
                if let timeFocused = timeFocused {
                    hours = timeFocused / 60
                    minutes = timeFocused % 60
                } else {
                    hours = 0
                    minutes = 0
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
