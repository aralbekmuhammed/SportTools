import Foundation
import Lottie
protocol PushUpsInteractorProtocol: AnyObject{
    var presenter: PushUpsPresenterProtocol! {get set}
    var pushUps: Int {get set}
    var animationLink: String? {get set}
    func getAnimation(completionHandler:@escaping(Animation?)->())
}
class PushUpsInteractor: PushUpsInteractorProtocol{
    weak var presenter: PushUpsPresenterProtocol!
    var pushUps: Int = 0
    var animationLink: String?{
        get{
            UserDefaults.standard.string(forKey: "customAnimationLink")
        }set{
            UserDefaults.standard.setValue(newValue, forKey: "customAnimationLink")
        }
    }
    func getAnimation(completionHandler: @escaping (Animation?) -> ()) {
        let defaultAnimation = Animation.named("pushUpAnimation")
        if let customAnimationLink = animationLink,
           let url = URL(string: customAnimationLink){
            Animation.loadedFrom(url: url,
                                 closure: { loadedAnimation in
                completionHandler(loadedAnimation ?? defaultAnimation)
            },animationCache: nil)
        }else{
            completionHandler(defaultAnimation)
        }
        
    }
    
}

