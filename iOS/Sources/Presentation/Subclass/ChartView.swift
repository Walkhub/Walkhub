import UIKit

import Charts
import SnapKit
import Then
import RxSwift

class ChartView: UIView {
    private let barChartView = BarChartView()

    override func layoutSubviews() {
        super.layoutSubviews()
        addSubviews()
        setCharts()
    }

    public func setWeekCharts(
        stepCounts: [Int]
    ) {
        let today = Date()
        var week = Calendar.current.component(.weekday, from: today) + 1
        var days = [String]()
        let chartColor = [UIColor.random()]
        var dataEntries: [BarChartDataEntry] = []

        for _ in 0..<7 {
            if week <= 7 {
                let day = Week(rawValue: week)
                days.append(day!.dayName)
            } else {
                let day = Week(rawValue: week - 7)
                days.append(day!.dayName)
            }
            week += 1
        }

        for data in 0..<days.count {
            let dataEntry = BarChartDataEntry(x: Double(data), y: Double(stepCounts[data]))
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries)
        chartDataSet.colors = chartColor

        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.setDrawValues(false)
        chartData.barWidth = 0.4
        barChartView.data = chartData

        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: days)
        barChartView.xAxis.setLabelCount(days.count, force: false)

        barChartView.leftAxis.axisMinimum = 0
        barChartView.leftAxis.granularity = 5000
    }

    public func setMothCharts(
        stepCounts: [Int]
    ) {
        let today  = Date()
        var days = [String]()
        var day = today
        var week = Calendar.current.component(.weekday, from: today)
        var chartColor = [UIColor]()

        for _ in 0...4 {
            let color = UIColor.random()
            while week - 1 > 0 && chartColor.count < 28 {
                    chartColor.append(color)
                    week -= 1
                }
                week = 8
        }
        chartColor.reverse()

        for _ in 0..<28 {
            let weekDay = Calendar.current.component(.weekday, from: day)
            if weekDay == 2 {
                days.append(day.toString())
            } else {
                days.append("")
            }
            day -= 86400
        }
        days.reverse()

        var dataEntries: [BarChartDataEntry] = []
        for data in 0..<days.count {
            let dataEntry = BarChartDataEntry(x: Double(data), y: Double(stepCounts[data]))
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries)
        chartDataSet.colors = chartColor

        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.setDrawValues(false)
        chartData.barWidth = 0.4

        barChartView.data = chartData

        chartDataSet.highlightEnabled = false

        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: days)
        barChartView.xAxis.setLabelCount(days.count, force: false)

        barChartView.leftAxis.axisMinimum = 0
        barChartView.leftAxis.granularity = 5000
    }
}

extension ChartView {
    private func addSubviews() {
        self.addSubview(barChartView)

        barChartView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func setCharts() {
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.drawAxisLineEnabled = false
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.doubleTapToZoomEnabled = false
        barChartView.rightAxis.enabled = false

        barChartView.legend.enabled = false
    }
}

enum Week: Int {
    case sun = 1
    case mon = 2
    case tue = 3
    case wed = 4
    case thu = 5
    case fri = 6
    case sat = 7
}

extension Week {
    var dayName: String {
        switch self {
        case .sun:
            return "일"
        case .mon:
            return "월"
        case .tue:
            return "화"
        case .wed:
            return "수"
        case .thu:
            return "목"
        case .fri:
            return "금"
        case .sat:
            return "토"
        }
    }
}
