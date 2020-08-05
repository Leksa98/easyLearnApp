//
//  WordListTableViewCell.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 28.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class WordListTableViewCell: AddWordTableViewCell {

    override var viewModel: Any? {
        didSet {
            if let viewModel = viewModel {
                if let viewModel = viewModel as? WordModel {
                    self.updateContent(label: viewModel.word + " - " + viewModel.translation)
                }
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
