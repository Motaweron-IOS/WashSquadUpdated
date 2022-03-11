//
//  UIView+Ex.swift
//  Sokyakom
//
//  Created by Ghoost on 9/21/20.
//

import UIKit
import MOLH


extension UIView {
    
    func setRoundCorners(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func setShadow(_ cornerRadius: CGFloat) {
        layer.cornerRadius=cornerRadius
        layer.shadowColor=UIColor.black.cgColor
        layer.shadowOffset=CGSize(width: 0, height: 1)
        let shadowPath=UIBezierPath(roundedRect: bounds, cornerRadius:  cornerRadius)
        layer.shadowPath=shadowPath.cgPath
        layer.shadowOpacity=0.2
    }
    
    func drawBorder(raduis:CGFloat, borderColor:UIColor) {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 1.5
        self.setRoundCorners(raduis)
    }
    
    func shakeF() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    func animateScale() {
        self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.4) {
            self.transform = CGAffineTransform.identity
        }
    }
    
    
    func setGradientBackground(rightColor: UIColor,
                               leftColor: UIColor) {
        let layerGradient = CAGradientLayer()
        layerGradient.colors = [rightColor.cgColor, leftColor.cgColor]
        layerGradient.startPoint = CGPoint(x: 0, y: 1.0)
        layerGradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        //layerGradient.locations = [0, 1]
        layerGradient.frame = CGRect(x: 0, y: 0, width: self.layer.bounds.width, height: self.layer.bounds.height)
        self.layer.insertSublayer(layerGradient, at:0)
    }
    
    func addTapGesture(tapNumber: Int, target: Any, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
    
    
    func addActionn(vc:UIViewController,action: Selector){
        let tapGestureRecognizer = UITapGestureRecognizer(target:vc, action: action)
        self.isUserInteractionEnabled = true
       // tapGestureRecognizer.view?.tag = self.tag
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func addSwipActionn(vc:UIViewController,action: Selector){
        let swipGestureRecognizer = UISwipeGestureRecognizer(target: vc, action: action)

        if MOLHLanguage.currentAppleLanguage() == "ar" {
            swipGestureRecognizer.direction = .left
        }else {
            swipGestureRecognizer.direction = .right
        }
        
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(swipGestureRecognizer)
    }
    
    func swipDownActionn(vc:UIViewController,action: Selector){
        let swipGestureRecognizer = UISwipeGestureRecognizer(target: vc, action: action)
            swipGestureRecognizer.direction = .down
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(swipGestureRecognizer)
    }
    
    func viewOfType<T:UIView>(type:T.Type, process: (_ view:T) -> Void) {
        if let view = self as? T { process(view) } else {
            for subView in subviews {
                subView.viewOfType(type:type, process:process)
            }
        }
    }
    
    
    func roundSingleConrner(_ corners:UIRectCorner,_ cormerMask:CACornerMask, radius: CGFloat) {
          // layerMinXMaxYCorner :- Bottom Left
          // layerMinXMinYCorner :- Top Left
          // layerMaxXMinYCorner :- Top Right
          // layerMaxXMaxYCorner :- Bottom Right
        if #available(iOS 11.0, *){
            self.clipsToBounds = false
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = cormerMask
        }else{
            let rectShape = CAShapeLayer()
            rectShape.bounds = self.frame
            rectShape.position = self.center
            rectShape.path = UIBezierPath(roundedRect: self.bounds,    byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
            self.layer.mask = rectShape
        }}
    
    
    func layerGradient(startPoint:CAGradientPoint, endPoint:CAGradientPoint ,colorArray:[CGColor], type:CAGradientLayerType ) {
           let gradient = CAGradientLayer(start: startPoint, end: endPoint, colors: colorArray, type: type)
           gradient.frame.size = self.frame.size
           self.layer.insertSublayer(gradient, at: 0)
       }
    
    
    func animShow(){
           UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseIn],
                          animations: {
                           self.center.y -= self.bounds.height
                           self.layoutIfNeeded()
           }, completion: nil)
           self.isHidden = false
       }
       func animHide(){
           UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear],
                          animations: {
                           self.center.y += self.bounds.height
                           self.layoutIfNeeded()

           },  completion: {(_ completed: Bool) -> Void in
           self.isHidden = true
               })
       }
    
    
    func prepareViewConstrains(vcView: UIView, width:CGFloat, height:CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        vcView.addSubview(self)
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: vcView.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: vcView.centerYAnchor),
            self.heightAnchor.constraint(equalToConstant: height),
            self.widthAnchor.constraint(equalToConstant: width)
        ])
    }
    
    
    // Draw Triangle
    func setDownTriangle(){
        let heightWidth = self.frame.size.width
        let path = CGMutablePath()
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x:heightWidth/2, y: heightWidth/2))
        path.addLine(to: CGPoint(x:heightWidth, y:0))
        path.addLine(to: CGPoint(x:0, y:0))
        
        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = UIColor.blue.cgColor
        
        self.layer.insertSublayer(shape, at: 0)
    }
    
}

public enum CAGradientPoint {
    case topLeft
    case centerLeft
    case bottomLeft
    case topCenter
    case center
    case bottomCenter
    case topRight
    case centerRight
    case bottomRight
    var point: CGPoint {
        switch self {
        case .topLeft:
            return CGPoint(x: 0, y: 0)
        case .centerLeft:
            return CGPoint(x: 0, y: 0.5)
        case .bottomLeft:
            return CGPoint(x: 0, y: 1.0)
        case .topCenter:
            return CGPoint(x: 0.5, y: 0)
        case .center:
            return CGPoint(x: 0.5, y: 0.5)
        case .bottomCenter:
            return CGPoint(x: 0.5, y: 1.0)
        case .topRight:
            return CGPoint(x: 1.0, y: 0.0)
        case .centerRight:
            return CGPoint(x: 1.0, y: 0.5)
        case .bottomRight:
            return CGPoint(x: 1.0, y: 1.0)
        }
    }
}

extension CAGradientLayer {
    convenience init(start: CAGradientPoint, end: CAGradientPoint, colors: [CGColor], type: CAGradientLayerType) {
        self.init()
        self.frame.origin = CGPoint.zero
        self.startPoint = start.point
        self.endPoint = end.point
        self.colors = colors
        self.locations = (0..<colors.count).map(NSNumber.init)
        self.type = type
    }
}
extension UIView {

    enum AnimationKeyPath: String {
        case opacity = "opacity"
    }

    func flash(animation: AnimationKeyPath ,withDuration duration: TimeInterval = 0.5, repeatCount: Float = 5){
        let flash = CABasicAnimation(keyPath: animation.rawValue)
        flash.duration = duration
        flash.fromValue = 1 // alpha
        flash.toValue = 0 // alpha
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = repeatCount

        layer.add(flash, forKey: nil)
    }
    
    func animate(animateOption: AnimationOptions) {
        UIView.animate(withDuration: 1, delay: 1, options: animateOption, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
}
enum VerticalLocation: String {
    case bottom
    case top
}

extension UIView {
    func addShadow(location: VerticalLocation, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        switch location {
        case .bottom:
             addShadow(offset: CGSize(width: 0, height: 10), color: color, opacity: opacity, radius: radius)
        case .top:
            addShadow(offset: CGSize(width: 0, height: -10), color: color, opacity: opacity, radius: radius)
        }
    }

    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
}
extension UIView {

    func fadeIn(_ duration: TimeInterval? = 0.2, onCompletion: (() -> Void)? = nil) {
        self.alpha = 0
        self.isHidden = false
        UIView.animate(withDuration: duration!,
                       animations: { self.alpha = 1 },
                       completion: { (value: Bool) in
                          if let complete = onCompletion { complete() }
                       }
        )
    }

    func fadeOut(_ duration: TimeInterval? = 0.2, onCompletion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration!,
                       animations: { self.alpha = 0 },
                       completion: { (value: Bool) in
                           self.isHidden = true
                           if let complete = onCompletion { complete() }
                       }
        )
    }

}
