//
//  ViewController.swift
//  Gradient
//
//  Created by ws00801526 on 01/03/2019.
//  Copyright (c) 2019 ws00801526. All rights reserved.
//

import UIKit
import Foundation
import QuartzCore
import Gradient

class ViewController: UIViewController {

    
    var gradientImageView : GradientImageView = GradientImageView(frame: .zero)
    var gradientView: GradientView?
    
    @IBOutlet weak var testView2: UIView!
    @IBOutlet weak var testView2HConstraint: NSLayoutConstraint!
    @IBOutlet weak var gradientLabel: GradientLabel!
    @IBOutlet weak var progressView: UIView!
    
    var testView = UIView(frame: CGRect(x: 0, y: 350, width: 100, height: 100))
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 300.0))
        gradientView?.setColors([UIColor.red, UIColor.blue, UIColor.green])
        gradientView?.startPosition = .bottomLeft
        gradientView?.endPosition = .topRight
        gradientView?.duration = 3.0
        view.addSubview(gradientView!)
        gradientView?.startAnimation()
        
//        view.addSubview(testView)
//        testView.frame = CGRect(x: 0, y: 450, width: Double(self.view.bounds.width), height: (Double(arc4random() % 50) + 100.0))
//        testView.backgroundColor = UIColor.purple
        testView2.gradient.setPosition(end: .bottomLeft).setColors([UIColor.red, UIColor.blue, UIColor.green]).startAnimation()

        gradientLabel.startPosition = .left
        gradientLabel.endPosition = .right
        gradientLabel.duration = 0.5
        gradientLabel.text = "Instagram"
        gradientLabel.font = UIFont.systemFont(ofSize: 26.0)
        gradientLabel.textAlignment = .center
        view.addSubview(gradientLabel)
        gradientLabel.startAnimation()
        
        if let image = UIImage(named: "voice") {
            
            gradientImageView.setColors([UIColor(red: 76.0/255.0, green: 225.0/255.0, blue: 255.0/255.0, alpha: 1.0),
                                         UIColor(red: 101.0/255.0, green: 73.0/255.0, blue: 242.0/255.0, alpha: 1.0)])
            gradientImageView.image = image
            gradientImageView.duration = 1.0
            gradientImageView.startPosition = .bottom
            gradientImageView.endPosition = .top
            gradientImageView.bounds = CGRect(x: 0, y: 0, width: 100.0, height: 100.0)
            gradientImageView.center = view.center
            gradientImageView.insets = UIOffset(horizontal: 30.0, vertical: 30.0)
            gradientImageView.startAnimation()
            view.addSubview(gradientImageView)
        }
        
        
        setupProgress()
    }
    
    
    func setupProgress() {
        
        let gradient = Gradients.layer(withColors: [UIColor.black, UIColor.white, UIColor.black])
        gradient.startPoint = Position.left.point
        gradient.endPoint = Position.right.point
        gradient.frame = CGRect(x: 0, y: 0, width: progressView.bounds.width, height: progressView.bounds.height)
        gradient.locations = [-0.5, -0.5, 0.0]
        progressView.layer.insertSublayer(gradient, at: 0)
        
        let textLayer = CATextLayer.init()
        textLayer.frame = gradient.bounds
        textLayer.string = "Slide to Unlock"
        gradient.mask = textLayer
        
        // frame animation
//        let animation = CABasicAnimation(keyPath: "transform.translation.x")
//        animation.duration = 3.0
//        animation.toValue = progressView.bounds.width * 2
//        animation.repeatCount = Float.infinity
//        animation.autoreverses = true
//        animation.fillMode = .forwards
//        animation.isRemovedOnCompletion = false
//        gradient.add(animation, forKey: nil)
        
        
        // locations animation
        let anim = CABasicAnimation(keyPath: "locations")
        anim.duration = 3.0
        anim.repeatCount = Float.infinity
        anim.toValue = [1.0, 1.5, 1.5]
        gradient.add(anim, forKey: nil)
    }
    
    @IBAction func updateGradientViewFrame(_ sender: Any) {
        
        UIView.animate(withDuration: 3.0) {
            self.gradientView?.frame = CGRect(x: 0, y: 0, width: Double(self.view.bounds.width), height: (Double(arc4random() % 150) + 200))
        }
        
//        self.testView.gradient.animation(withDuration: 3.0, animations: {
//
//            let offset = max(0.3, CGFloat(Double((arc4random() % 10)) / 10.0))
//            self.testView.transform = CGAffineTransform.init(scaleX: offset, y: offset)
////            self.testView.frame = CGRect(x: 0, y: 350, width: Double(self.view.bounds.width), height: (Double(arc4random() % 50) + 100.0))
//        }, completion: nil)
//        
//        testView2HConstraint.constant = 80.0 - CGFloat(arc4random() % 30)
//        testView2.gradient.animation(withDuration: 3.0, animations: {
//            self.view.layoutIfNeeded()
//        }, completion: nil)
    }
    
}
