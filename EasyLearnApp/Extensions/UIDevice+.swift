//
//  UIDevice+.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 20.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit
import AudioToolbox

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
