//  GradientView.swift
//  Pods
//
//  Created by  XMFraker on 2019/1/3
//  Copyright © XMFraker All rights reserved. (https://github.com/ws00801526)

import UIKit

open class GradientView: UIView {
    
    override open class var layerClass: AnyClass { return CAGradientLayer.self }
    
    open var startPosition: Position = .topLeft {
        didSet { gradient.startPoint = startPosition.point }
    }
    
    open var endPosition: Position = .bottomRight {
        didSet { gradient.endPoint = endPosition.point }
    }
    
    open var type: CAGradientLayerType = .axial {
        didSet { gradient.type = type }
    }
    
    open var locations: [NSNumber]? {
        didSet { gradient.locations = locations }
    }
    
    open var duration: TimeInterval = 3.0
    
    private var currentGradient: Int = 0
    private var colors: [UIColor] = Gradients.instagram.colors() {
        didSet { gradient.colors = gradientCGColors() }
    }
    private var gradient : CAGradientLayer { return (self.layer as! CAGradientLayer) }
    
    private func setup() {
        gradient.type = type
        gradient.locations = locations
        gradient.startPoint = startPosition.point
        gradient.endPoint = endPosition.point
        gradient.colors = currentGradientCGColors()
        gradient.drawsAsynchronously = true
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        gradient.colors = gradientCGColors()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        gradient.colors = gradientCGColors()
    }
    
    open override func removeFromSuperview() {
        super.removeFromSuperview()
        gradient.removeAllAnimations()
    }
}

fileprivate extension GradientView {
    
    func currentGradientCGColors() -> [CGColor] {
        guard colors.count > 0 else { return [] }
        let index = currentGradient % colors.count
        let nIndex = (currentGradient + 1) % colors.count
        return [colors[index].cgColor, colors[nIndex].cgColor]
    }
    
    func gradientCGColors() -> [CGColor] {
        guard colors.count > 0 else { return [] }
        return colors.map { $0.cgColor }
    }
}

public extension GradientView {
    
    public func startAnimation() {
        gradient.removeAllAnimations()
        setup()
        animateGradient()
    }
    
    public func setGradientColors(_ colors: Gradients) {
        setColors(colors.colors())
    }
    
    public func setColors(_ colors: [UIColor]) {
        guard colors.count > 0 else { return }
        self.colors = colors
    }
    
    public func add(_ color: UIColor) {
        self.colors.append(color)
    }
}

fileprivate extension GradientView {
    
    func animateGradient() {
        
        currentGradient += 1
        let animation = CABasicAnimation(keyPath: Animation.colors.keyPath)
        animation.delegate = self
        animation.duration = duration
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.toValue = currentGradientCGColors()
        gradient.add(animation, forKey: Animation.colors.key)
    }
}

extension GradientView: CAAnimationDelegate {
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard flag else { return }
        gradient.colors = currentGradientCGColors()
        animateGradient()
    }
}

open class GradientLabel: GradientView {
    
    private let label = UILabel(frame: .zero)
    
    open var text: String? {
        set { label.text = newValue }
        get { return label.text }
    }
    
    open var attributedText: NSAttributedString? {
        set { label.attributedText = newValue }
        get { return label.attributedText }
    }
    
    open var font: UIFont {
        set { label.font = newValue }
        get { return label.font }
    }
    
    open var textAlignment: NSTextAlignment {
        set { label.textAlignment = newValue }
        get { return label.textAlignment }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        mask = label
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        mask = label
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        mask = label
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = self.bounds
    }
}

open class GradientImageView : GradientView {
    
    private let imageView = UIImageView()
    private let contents = CALayer()
    
    open var image: UIImage? {
        set { imageView.image = newValue; imageView.sizeToFit() }
        get { return imageView.image }
    }
    
    open var insets: UIOffset = .zero
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.contentMode = .scaleAspectFill
        mask = imageView
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        imageView.contentMode = .scaleAspectFill
        mask = imageView
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFill
        mask = imageView
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds.insetBy(dx: insets.horizontal, dy: insets.vertical)
    }
}

public extension GradientImageView {
    
    convenience init(frame: CGRect, image: UIImage? = nil) {
        self.init(frame: frame)
        self.image = image
    }
}
