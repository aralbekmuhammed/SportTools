import UIKit
protocol PushUpsRouterProtocol: AnyObject{
    var view: PushUpsViewControllerProtocol! {get set}
    func presentAlert(_ alert: UIAlertController)
}
class PushUpsRouter: PushUpsRouterProtocol{
    weak var view: PushUpsViewControllerProtocol!
    func presentAlert(_ alert: UIAlertController) {
        view.present(alert, animated: true)
    }
}
