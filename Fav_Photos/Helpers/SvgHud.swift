//
//  SvgHud.swift
//  Fav_Photos
//
//  Created by Decagon on 7/20/21.
//

import Foundation
import SVProgressHUD

final class HUD {
    class func show(status: String) {
        DispatchQueue.main.async {
            SVProgressHUD.setDefaultStyle(.custom)
            SVProgressHUD.setDefaultMaskType(.custom)
            SVProgressHUD.setForegroundColor(.systemIndigo)
            SVProgressHUD.setBackgroundColor(.systemGray3)
            SVProgressHUD.setBackgroundLayerColor(.clear)
            SVProgressHUD.show(withStatus: status)
        }
    }
    
    class func hide() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
}
