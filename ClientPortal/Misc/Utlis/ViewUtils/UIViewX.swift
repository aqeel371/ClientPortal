//
//  UIViewX.swift
//  Weather
//
//  Created by Muhammad Aqeel on 05/09/2022.
//

import UIKit

@IBDesignable
class UIViewX: UIView {
    
    // MARK: - Gradient
    
    @IBInspectable var firstColor: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var secondColor: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var thirdColor: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var horizontalGradient: Bool = false {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var radialGradient: Bool = false {
        didSet {
            updateView()
        }
    }
    @IBInspectable public var isDottedBorder:Bool = false {
        didSet{
            addDashedBorder()
        }
    }
    @IBInspectable public var isRainbow:Bool = false {
        didSet{
            updateView()
        }
    }
    @IBInspectable public var isThirdGradient:Bool = true {
        didSet{
            updateView()
        }
    }
    @IBInspectable var dotedLineWidth: CGFloat = 1
    func addDashedBorder() {
        let color = borderColor.cgColor

        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)

        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = dotedLineWidth
//        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [8,8]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: cornerRadius).cgPath

        self.layer.addSublayer(shapeLayer)
    }
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    func updateView() {
        let layer = self.layer as! CAGradientLayer
        if isRainbow{
            layer.colors = [ UIColor.white.cgColor, UIColor.red.cgColor, UIColor.yellow.cgColor, UIColor(red: 10/299, green: 142/299, blue: 0/299, alpha: 1).cgColor, UIColor(red: 6/299, green: 229/299, blue: 4/299, alpha: 1).cgColor]
        } else {
            if isThirdGradient{
                layer.colors = [ firstColor.cgColor, secondColor.cgColor , thirdColor.cgColor]
            }else {
                layer.colors = [ firstColor.cgColor, secondColor.cgColor]
            }
        }
        
        if (horizontalGradient) {
            layer.startPoint = CGPoint(x: 0.0, y: 0.5)
            layer.endPoint = CGPoint(x: 1.0, y: 0.5)
        } else {
            layer.startPoint = CGPoint(x: 0, y: 0)
            layer.endPoint = CGPoint(x: 0, y: 1)
        }
    }
    @IBInspectable public var isInnerShadow: Bool = false {
        didSet {
            if isInnerShadow{
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                    self.clipsToBounds = true
                    self.addShadow(to: [.top],radius: 8)
                })
            }
        }
    }
    
    // MARK: - Border
    
    @IBInspectable public var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    // MARK: - Shadow
    
    @IBInspectable public var shadowOpacity: CGFloat = 0 {
        didSet {
            layer.shadowOpacity = Float(shadowOpacity)
        }
    }
    
    @IBInspectable public var shadowColor: UIColor = UIColor.clear {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable public var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable public var shadowOffsetY: CGFloat = 0 {
        didSet {
            layer.shadowOffset.height = shadowOffsetY
        }
    }
    func addShadow(to edges: [UIRectEdge], radius: CGFloat = 3.0, opacity: Float = 0.6, color: CGColor = UIColor.black.cgColor) {

        let fromColor = color
        let toColor = UIColor.clear.cgColor
        let viewFrame = self.frame
        for edge in edges {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [fromColor, toColor]
            gradientLayer.opacity = opacity

            switch edge {
            case .top:
                gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
                gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
                gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: viewFrame.width, height: radius)
            case .bottom:
                gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
                gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
                gradientLayer.frame = CGRect(x: 0.0, y: viewFrame.height - radius, width: viewFrame.width, height: radius)
            case .left:
                gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
                gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: radius, height: viewFrame.height)
            case .right:
                gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
                gradientLayer.frame = CGRect(x: viewFrame.width - radius, y: 0.0, width: radius, height: viewFrame.height)
            default:
                break
            }
            self.layer.addSublayer(gradientLayer)
        }
    }
}
