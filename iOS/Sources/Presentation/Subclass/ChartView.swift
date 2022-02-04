import UIKit

import Charts
import SnapKit
import Then

class ChartView: UIView {
    private let barChartView = BarChartView()

    override func layoutSubviews() {
        super.layoutSubviews()
        addSubviews()
        setCharts()
    }

    public func setWeekCharts(
        days: [String],
        stepCounts: [Int],
        chartColor: [UIColor]
    ) {
        var dataEntries: [BarChartDataEntry] = []
        for data in 0..<days.count {
            let dataEntry = BarChartDataEntry(x: Double(data), y: Double(stepCounts[data]))
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "걸음 수")
        chartDataSet.colors = chartColor

        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.setDrawValues(false)
        chartData.barWidth = 0.4
        barChartView.data = chartData

        chartDataSet.highlightEnabled = false

        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: days)
        barChartView.xAxis.setLabelCount(days.count, force: true)

        barChartView.leftAxis.axisMinimum = 0
        barChartView.leftAxis.granularity = 5000
    }

    public func setMothCharts(
        days: [String],
        stepCounts: [Int]
    ) {
        let color1 = UIColor.random()
        let color2 = UIColor.random()
        let color3 = UIColor.random()
        let color4 = UIColor.random()

        let chartColor = [color1, color1, color1, color1, color1, color1, color1,
                          color2, color2, color2, color2, color2, color2, color2,
                          color3, color3, color3, color3, color3, color3, color3,
                          color4, color4, color4, color4, color4, color4, color4]

        var dataEntries: [BarChartDataEntry] = []
        for data in 0..<days.count {
            let dataEntry = BarChartDataEntry(x: Double(data), y: Double(stepCounts[data]))
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "걸음 수")
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
