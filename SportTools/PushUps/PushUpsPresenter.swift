import Then
import Lottie
protocol PushUpsPresenterProtocol: AnyObject{
    var interactor: PushUpsInteractorProtocol! {get set}
    var router: PushUpsRouterProtocol! {get set}
    var view: PushUpsViewControllerProtocol! {get set}
    func configureInitialView()
    func viewTapped()
    func reloadButtonTapped()
    func setAnimationButtonTapped()
    func animationLinkTapped(_ link: String)
    func updateAnimation()
    func presentAlert(_ alert: UIAlertController)
}
class PushUpsPresenter: PushUpsPresenterProtocol{
    var interactor: PushUpsInteractorProtocol!
    var router: PushUpsRouterProtocol!
    weak var view: PushUpsViewControllerProtocol!
    func configureInitialView() {
        view.configureInitialView()
        view.setPushUpLabel(to: 0, animated: false)
    }
    func reloadButtonTapped() {
        interactor.pushUps = 0
        view.setPushUpLabel(to: 0, animated: false)
        view.vibrate()
    }
    func updateAnimation() {
        interactor.getAnimation { [weak self] animation in
            guard let self = self else{return}
            self.view.updateAnimation(with: animation)
        }
    }
    func presentAlert(_ alert: UIAlertController) {
        router.presentAlert(alert)
    }
    func viewTapped() {
        interactor.pushUps += 1
        view.playAnimation()
        view.vibrate()
        view.setPushUpLabel(to: interactor.pushUps, animated: true)
    }
    func animationLinkTapped(_ link: String) {
        interactor.animationLink = link
        updateAnimation()
    }
    func setAnimationButtonTapped() {
        view.presentSetAnimationAlert()
    }
}
