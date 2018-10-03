//
//  HorizontalBarLayout.swift
//  Tabman
//
//  Created by Merrick Sapsford on 30/05/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

/// Layout that displays bar buttons sequentially along the horizontal axis.
open class HorizontalBarLayout: BarLayout {
    
    // MARK: Defaults
    
    private struct Defaults {
        static let interButtonSpacing: CGFloat = 8.0
        static let minimumRecommendedButtonWidth: CGFloat = 40.0
    }
    
    // MARK: Properties
    
    internal let stackView = UIStackView()
    
    public override var contentMode: BarLayout.ContentMode {
        didSet {
            switch contentMode {
            case .fill:
                buttonDistribution = .fill
            case .fit:
                buttonDistribution = .fillEqually
            }
        }
    }
    
    // MARK: Lifecycle
    
    open override func layout(in view: UIView) {
        super.layout(in: view)
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        self.interButtonSpacing = Defaults.interButtonSpacing
    }
    
    open override func insert(buttons: [BarButton], at index: Int) {
        var currentIndex = index
        for button in buttons {
            if index >= stackView.arrangedSubviews.count { // just add
                stackView.addArrangedSubview(button)
            } else {
                stackView.insertArrangedSubview(button, at: currentIndex)
            }
            currentIndex += 1
        }
    }
    
    open override func remove(buttons: [BarButton]) {
        for button in buttons {
            stackView.removeArrangedSubview(button)
        }
    }
    
    open override func focusArea(for position: CGFloat, capacity: Int) -> CGRect {
        let range = BarMath.localIndexRange(for: position, minimum: 0, maximum: capacity - 1)
        guard stackView.arrangedSubviews.count > range.upperBound else {
            return .zero
        }
        
        let lowerView = stackView.arrangedSubviews[range.lowerBound]
        let upperView = stackView.arrangedSubviews[range.upperBound]
        
        let progress = BarMath.localProgress(for: position)
        let interpolation = lowerView.frame.interpolate(with: upperView.frame, progress: progress)
        
        return CGRect(x: lowerView.frame.origin.x + interpolation.origin.x,
                      y: 0.0,
                      width: lowerView.frame.size.width + interpolation.size.width,
                      height: view.bounds.size.height)
    }
}

// MARK: - Customization
public extension HorizontalBarLayout {
    
    public var interButtonSpacing: CGFloat {
        set {
            stackView.spacing = newValue
        } get {
            return stackView.spacing
        }
    }
    
    private var buttonDistribution: UIStackView.Distribution {
        set {
            stackView.distribution = newValue
        } get {
            return stackView.distribution
        }
    }
}