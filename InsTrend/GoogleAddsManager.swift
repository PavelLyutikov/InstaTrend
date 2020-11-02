

import Foundation
import GoogleMobileAds


class AddsM {
    
    enum AddSEnum: String {
        case testInter = "ca-app-pub-3940256099942544/4411468910"
        case inter = "ca-app-pub-9265838027738410/2220859760"
    }
    
    var interstitial: GADInterstitial!
    var rewardedAd: GADRewardedAd?
    
    init(controller: UIViewController) {
        interstitial =  createAndLoadInterstitial(viewController: controller)
        rewardedAd = createAndLoadVideo()
    }
    
    func createAndLoadVideo() -> GADRewardedAd {
        let rewerdedAd = GADRewardedAd(adUnitID: "ca-app-pub-9138643120126724/6311615844")
        rewardedAd?.load(GADRequest()) { error in
            if error != nil {
            // Handle ad failed to load case.
          } else {
            // Ad successfully loaded.
          }
        }
        return rewerdedAd
    }
    
    func createAndLoadInterstitial(viewController: UIViewController) -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: AddSEnum.inter.rawValue)
        interstitial.delegate = (viewController as! GADInterstitialDelegate)
        interstitial.load(GADRequest())
        return interstitial
    }
    
}
