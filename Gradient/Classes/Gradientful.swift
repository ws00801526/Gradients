//  Gradientful.swift
//  Pods
//
//  Created by  XMFraker on 2019/1/7
//  Copyright © XMFraker All rights reserved. (https://github.com/ws00801526)

import UIKit

public protocol GradientCompatible {
    associatedtype CompatibleType
    var gradient: CompatibleType { get }
    var bounds: CGRect { get set }
    func insertSublayer(_ layer: CALayer) -> Void
}

fileprivate var GKey = 102
public extension GradientCompatible {
    
    public var gradient: Gradient<Self> {
        if let gradient = objc_getAssociatedObject(self, &GKey) as? Gradient<Self> { return gradient }
        let gradient = Gradient(self)
        objc_setAssociatedObject(self, &GKey, gradient, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return gradient
    }
}

extension UIView : GradientCompatible {
    
    public func insertSublayer(_ layer: CALayer) {
        if let sublayers = self.layer.sublayers, sublayers.contains(layer) { return }
        self.layer.insertSublayer(layer, at: 0)
    }
}

extension CALayer : GradientCompatible {
    public func insertSublayer(_ layer: CALayer) {
        if let sublayers = self.sublayers, sublayers.contains(layer) { return }
        self.insertSublayer(layer, at: 0)
    }
}

public final class Gradient<Base> : NSObject, CAAnimationDelegate {
    
    public let base : Base
    public init(_ base: Base) {
        self.base = base
    }
    
    fileprivate var currentGradient: Int = 0
    fileprivate var colors : [UIColor] = Gradients.instagram.colors()
    fileprivate var startPosition : Position = .topLeft
    fileprivate var endPosition : Position = .bottomRight
    fileprivate var type : CAGradientLayerType = .axial
    fileprivate var locations : [NSNumber]? = nil
    
    fileprivate var duration : TimeInterval = 3.0
    fileprivate let gradient = CAGradientLayer()
    fileprivate var animation: Animation = .none {
        didSet {
            if animation == .none { setup(colors) }
            else { setup(currentGradientColors()) }
            animateGradient()
        }
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard flag else { return }
        animateGradient()
    }
}

fileprivate extension Gradient {
    
    func currentGradientColors() -> [UIColor] {
        guard colors.count > 0 else { return [] }
        let index = currentGradient % colors.count
        let nIndex = (currentGradient + 1) % colors.count
        return [colors[index], colors[nIndex]]
    }
    
    func setup(_ colors: [UIColor]) {
        gradient.removeAllAnimations()
        gradient.removeFromSuperlayer()
        
        gradient.type = type
        gradient.locations = locations
        gradient.startPoint = startPosition.point
        gradient.endPoint = endPosition.point
        gradient.drawsAsynchronously = true
        gradient.colors = colors.map { $0.cgColor }
    }
}

/// animations of Gradient
fileprivate extension Gradient {
    
    func animateGradient() {
        
        switch animation {
        case .none:         gradient.removeAllAnimations()
        case .colors:       animateColorsAnimation()
        case .locations:    animateLocationsAnimation()
        }
    }

    func animateColorsAnimation() {
        
        gradient.colors = currentGradientColors().map { $0.cgColor }
        
        currentGradient += 1
        let anim = CABasicAnimation(keyPath: animation.keyPath)
        anim.duration = duration
        anim.toValue = currentGradientColors().map { $0.cgColor }
        anim.fillMode = .forwards
        anim.isRemovedOnCompletion = false
        anim.delegate = self
        gradient.add(anim, forKey: animation.key)
    }
    
    func animateLocationsAnimation() {
        
        gradient.locations = [0.2, 0.4, 0.6]
        // locations animation
        let anim = CABasicAnimation(keyPath: animation.keyPath)
        anim.duration = duration
        anim.repeatCount = Float.infinity
        anim.toValue = [0.6, 0.8, 1.0]
        anim.autoreverses = true
        gradient.add(anim, forKey: animation.key)
    }
}

public extension Gradient {
    
    public func setColors(_ colors: [UIColor]) -> Self {
        guard colors.count > 0 else { return self }
        self.colors = colors
        return self
    }
    
    public func setGradient(_ gradient: Gradients) -> Self {
        return setColors(gradient.colors())
    }
    
    public func add(_ color: UIColor) -> Self {
        colors.append(color)
        return self
    }
    
    public func setDuration(_ duration: TimeInterval) -> Self {
        self.duration = duration
        return self
    }
    
    public func setPosition(start: Position = .topRight, end: Position = .bottomLeft) -> Self {
        self.startPosition = start
        self.endPosition = end
        return self
    }
    
    public func setType(_ type: CAGradientLayerType) -> Self {
        self.type = type
        return self
    }
    
    public func setLocations(_ locations: [NSNumber]?) -> Self {
        self.locations = locations
        return self
    }
}

public enum Animation {
    
    /// none animation
    case none
    /// animation of CAGradientLayer.colors
    case colors
    /// animation of CAGradientLayer.locations
    case locations
    
    internal var keyPath: String {
        switch self {
            //        case .bounds: return "bounds"
        //        case .position: return "position"
        case .none: return ""
        case .colors: return "colors"
        case .locations: return "locations"
        }
    }
    
    internal var key: String {
        switch self {
            //        case .bounds: return "boundsChange"
        //        case .position: return "positionChange"
        case .none: return ""
        case .colors: return "colorsChange"
        case .locations : return "locationsChange"
        }
    }
}

public extension Gradient where Base : GradientCompatible {
    
    public func apply(_ anim: Animation = .none) {
        animation = anim
        base.insertSublayer(gradient)
        DispatchQueue.main.async { [unowned self] in self.gradient.frame = self.base.bounds }
    }
}
