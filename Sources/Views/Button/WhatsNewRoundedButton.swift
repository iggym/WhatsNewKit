//
//  WhatsNewCompletionButton.swift
//  WhatsNewKit
//
//  Created by Sven Tiigi on 19.05.18.
//  Copyright © 2018 WhatsNewKit. All rights reserved.
//

import UIKit

/// The WhatsNewRoundedButton
class WhatsNewRoundedButton: UIButton {
    
    // MARK: Properties
    
    /// The highlighted background color
    private var highlightedBackgroundColor: UIColor = .white
    
    /// The onPress closure
    private var onPress: (() -> Void)?
    
    // MARK: Initializer
    
    /// Convenience initializer
    ///
    /// - Parameters:
    ///   - title: The title
    ///   - theme: The Theme
    ///   - onPress: The on press closure
    convenience init(title: String,
                     theme: WhatsNewViewController.Theme,
                     onPress: @escaping () -> Void) {
        // Init with Custom Type
        self.init(type: .custom)
        // Set onPress closure
        self.onPress = onPress
        // Set highlighted background color
        self.highlightedBackgroundColor = theme.completionButtonTheme.backgroundColor
        // Set corner radius to rounded button
        self.layer.cornerRadius = theme.completionButtonTheme.cornerRadius
        // Set mask to bound
        self.layer.masksToBounds = true
        // Set font
        self.titleLabel?.font = theme.completionButtonTheme.titleFont
        // Set normal title color
        self.setTitleColor(theme.completionButtonTheme.titleColor, for: .normal)
        // Set title
        self.setTitle(title, for: .normal)
        // Set number of lines
        self.titleLabel?.numberOfLines = 0
        // Set line break mode
        self.titleLabel?.lineBreakMode = .byWordWrapping
        // Add target
        self.addTarget(
            self,
            action: #selector(self.didTouchUpInside),
            for: .touchUpInside
        )
    }
    
    // MARK: ViewLifecycle
    
    /// Layout Subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        // Check if current background image is nil
        if self.currentBackgroundImage == nil {
            // Set the backgroundimage
            self.setBackgroundImage(
                self.getImageWithColor(
                    self.highlightedBackgroundColor,
                    size: self.bounds.size
                ),
                for: .normal
            )
        }
    }
    
    // MARK: Helper functions
    
    /// Return a UIImage with a given UIColor and CGSize
    ///
    /// - Parameters:
    ///   - color: The color of the returned UIImage
    ///   - size: The size of the returned UIImage
    /// - Returns: Optional UIImage
    private func getImageWithColor(_ color: UIColor, size: CGSize) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// Button did touch up inside
    @objc private func didTouchUpInside() {
        // Invoke onPress closure
        self.onPress?()
    }
    
}
