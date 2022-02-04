import UIKit

import Charts
import SnapKit
import Then

class ChartView: UIView {
    private let barChartView = BarChartView()

    override func layoutSubviews() {
        super.layoutSubviews()
        addSubviews()
    }

    public func setCharts(
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

        barChartView.doubleTapToZoomEnabled = false

        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: days)
        barChartView.xAxis.drawAxisLineEnabled = false
        barChartView.xAxis.drawGridLinesEnabled = false

        barChartView.leftAxis.axisMinimum = 0
        barChartView.leftAxis.granularity = 5000

        barChartView.rightAxis.enabled = false
        barChartView.rightAxis.setLabelCount(days.count, force: false)

        barChartView.legend.enabled = false
    }
}

extension ChartView {
    private func addSubviews() {
        self.addSubview(barChartView)

        barChartView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
