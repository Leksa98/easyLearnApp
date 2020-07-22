//
//  AddSetTableViewCell.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 19.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class AddSetTableViewCell: AddWordTableViewCell {
    
    private enum Locals {
        static let backgroundColor = UIColor(cgColor: CGColor(srgbRed: 233.0/255.0, green: 241.0/255.0, blue: 247.0/255.0, alpha: 1))
    }
    
    override var viewModel: Any? {
        didSet {
            if let viewModel = viewModel {
                if let viewModel = viewModel as? AddSetModel {
                    self.updateContent(label: viewModel.word + " - " + viewModel.translation)
                }
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Locals.backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
