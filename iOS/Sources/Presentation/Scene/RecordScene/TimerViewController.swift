import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

class TimerViewController: UIViewController {

    var viewModel: TimerViewModel!

    private let move = PublishRelay<Void>()
    private var disposeBag = DisposeBag()

    private let timerLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 120, family: .bold)
        $0.textColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        view.backgroundColor = .primary400
    }

    override func viewDidAppear(_ animated: Bool) {
        let countDown = 3
        Observable<Int>.timer(
            .seconds(0),
            period: .seconds(1),
            scheduler: MainScheduler.instance
        ).take(3)
            .map { countDown - $0 }
            .map { String($0) }
            .bind(to: timerLabel.rx.text)
            .disposed(by: disposeBag)
    }

    override func viewDidLayoutSubviews() {
        view.addSubview(timerLabel)

        timerLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private func bindViewModel() {
        let input = TimerViewModel.Input(move: move.asDriver(onErrorJustReturn: ()))

        let output = viewModel.transform(input)
    }
}
