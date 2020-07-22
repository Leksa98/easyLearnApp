//
//  AddWordRouter.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 19.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol AddWordRoutingLogic {
    func routeToAddSetView(source: AddWordViewController, destination: AddSetViewController)
}

final class AddWordRouter: AddWordRoutingLogic {
    
    
    func routeToAddSetView(source: AddWordViewController, destination: AddSetViewController) {
        passData(source: source.addWord, destination: destination)
        source.dismiss(animated: true, completion: nil)
    }
    
    private func passData(source: AddSetModel, destination: AddSetViewController) {
        destination.addedWords.append(source)
        print(destination.addedWords)
    }
    
}
