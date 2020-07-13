//
//  ViewController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 29.06.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class AddSetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add new set"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        self.dismissKey()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        newSetNameAlert()
    }
    
    private func newSetNameAlert() {
        let addNameAlertController = UIAlertController(title: "New Word Set", message: "Enter set name", preferredStyle: .alert)
        addNameAlertController.addTextField { textField in
            textField.placeholder = "Set Name"
        }
        let nextAlertAction = UIAlertAction(title: "Next", style: .default) { (action:UIAlertAction) in
            print("You've pressed next")
            let addEmojiAlertController = UIAlertController(title: "New Word Set", message: "Enter emoji for the new set", preferredStyle: .alert)
            addEmojiAlertController.addTextField { textField in
                textField.placeholder = "Set Emoji"
            }
            let nextEmojiAlert = UIAlertAction(title: "Next", style: .default) { (action:UIAlertAction) in
                print("OK")
            }
            let cancelEmojiAlert = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
                print("You've pressed cancel")
            }
            addEmojiAlertController.addAction(nextEmojiAlert)
            addEmojiAlertController.addAction(cancelEmojiAlert)
            self.present(addEmojiAlertController, animated: true, completion: nil)
        }
        let cancelNameAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
            print("You've pressed cancel")
        }
        addNameAlertController.addAction(nextAlertAction)
        addNameAlertController.addAction(cancelNameAlertAction)
        self.present(addNameAlertController, animated: true, completion: nil)
    }
    
    // private func addWord() {
    //     let networkManager = NetworkManager()
    //     networkManager.translateWord(word: "school") { translation, error in
    //     if let error = error {
    //         print(error)
    //     }
    //     if let translation = translation {
    //         print(translation)
    //     }
    //     }
    // }
}


extension UIViewController {
    func dismissKey() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension UITextField {
    open override var textInputMode: UITextInputMode? {
        if self.placeholder == "Set Emoji" {
            return UITextInputMode.activeInputModes.filter { $0.primaryLanguage == "emoji" }.first ?? super.textInputMode
        }
        return UITextInputMode.activeInputModes.filter { $0.primaryLanguage == NSLocale.current.languageCode }.first ?? super.textInputMode
    }
}
