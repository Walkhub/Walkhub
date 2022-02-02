import UIKit

import KDCircularProgress
import SnapKit
import Then

class WHCircleProgressView: UIView {

    private let trackView = KDCircularProgress()
    private let progressView = KDCircularProgress()

    private var totalAngle: Double = 360 {
        didSet { setTotalAngle(totalAngle) }
    }

    public var progress: Double = 0 {
        didSet { setProgress(progress) }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubviews()
        self.makeSubviewConstraints()
    }

    public func setup(
        totalAngle: Double,
        progressThickness: Double,
        trackThickness: Double,
        trackColor: UIColor,
        progressColor: UIColor
    ) {
        self.totalAngle = totalAngle
        self.setThickness(progressThickness: progressThickness, trackThickness: trackThickness)
        self.setColor(trackColor: trackColor, progressColor: progressColor)
        self.setGlow()
    }

}

// MARK: - Private Methods
extension WHCircleProgressView {

    private func setTotalAngle(_ totalAngle: Double) {
        let inclination = (360-totalAngle)/2+90
        self.trackView.angle = totalAngle
        self.trackView.startAngle = inclination
        self.progressView.startAngle = inclination
    }

    private func setProgress(_ progress: Double) {
        let toAngle = self.totalAngle*(progress/100)
        self.progressView.animate(
            toAngle: toAngle,
            duration: 0.3,
            completion: nil
        )
    }

    private func setThickness(progressThickness: Double, trackThickness: Double) {
        self.progressView.progressThickness = progressThickness
        self.trackView.progressThickness = trackThickness
    }

    private func setColor(trackColor: UIColor, progressColor: UIColor) {
        self.trackView.trackColor = .clear
        self.trackView.progressColors = [trackColor]
        self.progressView.trackColor = .clear
        self.progressView.progressColors = [progressColor]
    }

    private func setGlow() {
        self.trackView.glowMode = .noGlow
        self.progressView.glowMode = .noGlow
    }

}

// MARK: - Layout
extension WHCircleProgressView {

    private func addSubviews() {
        self.addSubview(trackView)
        self.trackView.addSubview(progressView)
    }

    private func makeSubviewConstraints() {
        trackView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        progressView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
    }

}
