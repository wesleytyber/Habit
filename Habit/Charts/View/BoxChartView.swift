//
//  BoxChartView.swift
//  Habit
//
//  Created by Wesley Calazans on 26/01/22.
//


import Charts
import SwiftUI

struct BoxChartView: UIViewRepresentable {
    typealias UIViewType = LineChartView
    
    @Binding var entries: [ChartDataEntry]
    @Binding var dates: [String]
    
    func makeUIView(context: Context) -> LineChartView {
        let uiView = LineChartView()
        
        uiView.legend.enabled = false
        uiView.chartDescription?.enabled = false
        uiView.xAxis.granularity = 1
        uiView.xAxis.labelPosition = .bottom
        uiView.rightAxis.enabled = false
        uiView.xAxis.valueFormatter = DateAxisValueFormatter(dates: dates)
        uiView.leftAxis.axisLineColor = .orange
        uiView.animate(xAxisDuration: 1.0)
        
        uiView.data = addData()
        return uiView
    }
    
    private func addData() -> LineChartData {
        let colors = [UIColor.white.cgColor, UIColor.orange.cgColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: colorLocations) else { return LineChartData(dataSet: nil)}
        
        let dataSet = LineChartDataSet(entries: entries,   label: "")
        
        dataSet.mode = .cubicBezier
        dataSet.lineWidth = 2
        dataSet.circleRadius = 4
        dataSet.setColor(.orange)
        dataSet.circleColors = [.red]
        dataSet.valueColors = [.red]
        dataSet.drawFilledEnabled = true
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        dataSet.fill = Fill(linearGradient: gradient, angle: 90.0)
        
        return LineChartData(dataSet: dataSet)
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        
    }
    
}

class DateAxisValueFormatter: IAxisValueFormatter {
    
    let dates: [String]
    
    init(dates: [String]) {
        self.dates = dates
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let position = Int(value)
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy/MM/dd'T'HH:mm:ss"
        
        if position > 0 && position < dates.count {
            let date = formatter.date(from: dates[position])
            
            guard let date = date else {
                return ""
            }
            
            let df = DateFormatter()
            df.dateFormat = "dd/MM/"
            let createdAt = df.string(from: date)
            
            return createdAt
        } else {
            return ""
        }   
    }
}

struct BoxChartView_Previews: PreviewProvider {
    
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            BoxChartView(entries: .constant([
                
                ChartDataEntry(x: 1.0, y: 2.0),
                ChartDataEntry(x: 2.0, y: 4.0),
                ChartDataEntry(x: 3.0, y: 6.0),
                ChartDataEntry(x: 4.0, y: 7.0),
                ChartDataEntry(x: 5.0, y: 3.0),
                
            ]), dates: .constant([
                "01/01/2021",
                "02/01/2021",
                "03/01/2021",
                "04/01/2021",
                "05/01/2021",
            ]))
                .frame(maxWidth: .infinity, maxHeight: 350)
                .previewDevice("iPhone 13")
                .preferredColorScheme($0)
        }
    }
}
