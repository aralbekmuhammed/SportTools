import UIKit
import Then

protocol PushUpsConfiguratorProtocol: AnyObject{
    func configure(_ vc: PushUpsViewControllerProtocol)
}
class PushUpsConfigurator: PushUpsConfiguratorProtocol{
    func configure(_ vc: PushUpsViewControllerProtocol) {
        let presenter = PushUpsPresenter()
        let router = PushUpsRouter()
        let interactor = PushUpsInteractor()
        
        vc.presenter = presenter
        
        presenter.view = vc
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.view = vc
        
    }
}
