//
//  AddSetTableViewCell.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 19.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class AddSetTableViewCell: AddWordTableViewCell {
    
    override var viewModel: Any? {
        didSet {
            if let viewModel = viewModel {
                if let viewModel = viewModel as? WordModel {
                    self.updateContent(label: viewModel.word + " - " + viewModel.translation)
                }
            }
        }
    }
}
