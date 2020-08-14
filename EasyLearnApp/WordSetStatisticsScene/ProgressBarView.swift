//
//  ProgressBarView.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 11.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class ProgressBarView: UIView {
    
    // MARK: - Constants
    
    enum Locals {
        static let cornerRadius: CGFloat = 8
    }
    
    // MARK: - Properties
    
    private var firstSection: CGFloat?
    private var secondSection: CGFloat?
    private var thirdSection: CGFloat?
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = Locals.cornerRadius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Drawing
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let firstSection = firstSection, let secondSection = secondSection, let thirdSection = thirdSection else {
            return
        }
        
        if firstSection != 0 {
            let partRect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: rect.width * firstSection, height: rect.height))
            UIColor.red.set()
            UIRectFill(partRect)
        }
        
        if secondSection != 0 {
            let partRect = CGRect(origin: CGPoint(x: rect.width * firstSection, y: 0), size: CGSize(width: rect.width * secondSection, height: rect.height))
            UIColor.yellow.set()
            UIRectFill(partRect)
        }
        
        if thirdSection != 0 {
            let partRect = CGRect(origin: CGPoint(x: rect.width * (firstSection + secondSection), y: 0), size: CGSize(width: rect.width * thirdSection, height: rect.height))
            UIColor.green.set()
            UIRectFill(partRect)
        }
    }
    
    public func setProgress(firstSection: CGFloat, secondSection: CGFloat, thirdSection: CGFloat) {
        self.firstSection = firstSection
        self.secondSection = secondSection
        self.thirdSection = thirdSection
        self.draw(frame)
    }
}
