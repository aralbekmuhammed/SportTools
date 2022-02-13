import UIKit
import Lottie
import AudioToolbox
protocol PushUpsViewControllerProtocol: UIViewController{
    var presenter: PushUpsPresenterProtocol! {get set}
    var configurator: PushUpsConfiguratorProtocol {get set}
    func configureInitialView()
    func playAnimation()
    func setPushUpLabel(to count: Int, animated: Bool)
    func vibrate()
    func presentSetAnimationAlert()
    func updateAnimation(with animation: Animation?)
}
class PushUpsViewController: UIViewController, PushUpsViewControllerProtocol, UIGestureRecognizerDelegate{
    var configurator: PushUpsConfiguratorProtocol = PushUpsConfigurator()
    @IBOutlet weak var pushUpCountLabel: UILabel!
    @IBOutlet weak var setAnimationButton: UIButton!
    @IBOutlet weak var animationView: AnimationView!
    var presenter: PushUpsPresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(self)
        presenter.configureInitialView()
    }
    func configureInitialView() {
        animationView.do {
            $0.loopMode = .playOnce
            $0.animationSpeed = 1.8
        }
        presenter.updateAnimation()
        let gr = UITapGestureRecognizer(target: self,
                                        action: #selector(viewTapped))
        gr.delegate = self
        view.addGestureRecognizer(gr)
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let view = touch.view,
           view.isDescendant(of: setAnimationButton){
            return false
        }
        return true
    }
    func updateAnimation(with animation: Animation?) {
        animationView.animation = animation
    }
    func vibrate() {
        AudioServicesPlaySystemSound(1520)
    }
    func playAnimation() {
        animationView.play(completion: nil)
    }
    @objc func viewTapped(){
        presenter.viewTapped()
    }
    @IBAction func reloadButtonTapped(_ sender: Any) {
        presenter.reloadButtonTapped()
    }
    @IBAction func setAnimationButtonTapped(_ sender: Any) {
        presenter.setAnimationButtonTapped()
    }
    func presentSetAnimationAlert() {
        let alert = UIAlertController(title: "Set custom animation",
                                      message: "Please, type your animation link from lottiefiles.com",
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        let doneAction = UIAlertAction(title: "Use",
                                       style: .default) { [weak self] _ in
            guard let self = self,
                  let link = alert.textFields?.first?.text,
                  link.contains(".json") else{return}
            self.presenter.animationLinkTapped(link)
        }
        alert.addTextField {
            $0.placeholder = "Animation Link"
        }
        alert.addAction(cancelAction)
        alert.addAction(doneAction)
        presenter.presentAlert(alert)
    }
    func setPushUpLabel(to count: Int, animated: Bool) {
        pushUpCountLabel.text = count.description
        guard animated else{return}
        let label = pushUpCountLabel
        UIView.animate(withDuration: 0.35) {
            label?.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
        } completion: { finished in
            guard finished else{return}
            UIView.animate(withDuration: 0.35) {
                label?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        }
    }
}
