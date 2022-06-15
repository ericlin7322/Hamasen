//
//  Maps.swift
//  Hamasen
//
//  Created by Eric Lin on 2018/12/19.
//  Copyright © 2018 Eric Lin. All rights reserved.
//

import UIKit

class RotaryPhone: UIView {
    let MARGIN: CGFloat = 10.0
    let imageView = UIImageView(image: UIImage(named: "image1"))
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        rotaryPhoneModule()
        rotraryPhoneDial()
    }
    
    private func rotaryPhoneModule() {
        let context = UIGraphicsGetCurrentContext()
        let offset = CGFloat.pi * 1.8
        let pointX = self.frame.midX + 80 * sin(CGFloat.pi / 2 + offset)
        let pointY = self.frame.midY + 80 * cos(CGFloat.pi / 2 + offset)
        let pointBX = self.frame.midX + 160 * sin(CGFloat.pi / 2 + offset)
        let pointBY = self.frame.midY + 160 * cos(CGFloat.pi / 2 + offset)
        
        context?.setFillColor(UIColor.black.cgColor)
        context?.addArc(center: CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2), radius: 160.0, startAngle: 0.0, endAngle: CGFloat(Double.pi * 2.0), clockwise: false)
        context?.fillPath()
        context?.setFillColor(UIColor.white.cgColor)
        context?.addArc(center: CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2), radius: 80.0, startAngle: 0.0, endAngle: CGFloat.pi * 2.0, clockwise: false)
        context?.fillPath()
        context?.setLineWidth(5.0)
        context?.setStrokeColor(UIColor.gray.cgColor)
        context?.move(to: CGPoint(x: pointX, y: pointY))
        context?.addCurve(to: CGPoint(x: pointBX, y: pointBY), control1: CGPoint(x: pointX + 15, y: pointY + 60), control2: CGPoint(x: pointBX, y: pointBY))
        context?.strokePath()
    }
    
    private func rotraryPhoneDial() {
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.white.cgColor)
        for i in 0...9 {
            let offset = CGFloat.pi * 1.8 / 10.0 * CGFloat(i)
            let pointX = self.frame.midX + 120 * sin(CGFloat.pi / 2 + offset)
            let pointY = self.frame.midY + 120 * cos(CGFloat.pi / 2 + offset)
            let number = UILabel(frame: CGRect(x: pointX - 15, y: pointY - 15, width: 30, height: 30))
            context?.addArc(center: CGPoint(x: pointX, y: pointY), radius: 30.0, startAngle: 0.0, endAngle: CGFloat.pi * 2.0, clockwise: false)
            
            number.textAlignment = .center
            number.textColor = UIColor.black
            number.font = number.font.withSize(30.0)
            if i + 1 == 10 {
                number.text = String(0)
            }else {
                number.text = String(i + 1)
            }
            
            context?.fillPath()
            self.addSubview(number)
        }
    }
    
}
