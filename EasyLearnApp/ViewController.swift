//
//  ViewController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 29.06.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //let translation = RequestService()
        //translation.getTranslate(word: "dog")
        let networkManager = NetworkManager()
        networkManager.translateWord(word: "phone") { translation, error in
        if let error = error {
            print(error)
        }
        if let translation = translation {
            print(translation)
        }
            
        }
    }
}

