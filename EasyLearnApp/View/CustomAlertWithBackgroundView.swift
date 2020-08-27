//
//  CustomAlertWithBackgroundView.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 26.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

protocol AlertButtonWasPressed {
    func alertButtonWasPressed()
}

final class CustomAlertWithBackgroundView: UIView {
    
    // MARK: - Constants
    
    private enum Locals {
        static let alertViewWidth: CGFloat = 300
        static let alertViewHeight: CGFloat = 150
        static let alertTransformScale: CGFloat = 1.3
        static let animationDuration: TimeInterval = 0.4
    }
    
    // MARK: - Property
    
    let alertView = CustomAlertView()
    var screenshotImageView = UIImageView()
    var navigationController: UINavigationController?
    var delegate: AlertButtonWasPressed?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        screenshotImageView.addBlur()
        alertView.alpha = 0
        alertView.button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        addSubview(screenshotImageView)
        addSubview(alertView)
        
        alertView.translatesAutoresizingMaskIntoConstraints = false
        screenshotImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            screenshotImageView.topAnchor.constraint(equalTo: topAnchor),
            screenshotImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            screenshotImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            screenshotImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            alertView.centerXAnchor.constraint(equalTo: centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: centerYAnchor),
            alertView.widthAnchor.constraint(equalToConstant: Locals.alertViewWidth),
            alertView.heightAnchor.constraint(equalToConstant: Locals.alertViewHeight),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Show alert
    
    func showAlert() {
        alertView.transform = CGAffineTransform(scaleX: Locals.alertTransformScale, y: Locals.alertTransformScale)
        navigationController?.setNavigationBarHidden(true, animated: false)
        UIView.animate(withDuration: Locals.animationDuration) {
            self.alertView.alpha = 1
            self.alertView.transform = CGAffineTransform.identity
        }
    }
    
    // MARK: - Button action
    
    @objc private func buttonPressed() {
        UIView.animate(withDuration: Locals.animationDuration,
                       animations: {
                        self.alertView.alpha = 0
                        self.alertView.transform = CGAffineTransform(scaleX: Locals.alertTransformScale, y: Locals.alertTransformScale)
        }) { _ in
            self.delegate?.alertButtonWasPressed()
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            self.removeFromSuperview()
        }
    }
}
