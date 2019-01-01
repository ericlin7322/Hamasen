//
//  RotaryDial.swift
//  Hamasen
//
//  Created by Eric Lin on 2018/12/19.
//  Copyright © 2018 Eric Lin. All rights reserved.
//

import UIKit

class RotaryDial: UIView {
    var gestureRecognizer = RotationGestureRecognizer()
    
    var startAngle: CGFloat {
        get { return renderer.startAngle }
        set { renderer.startAngle = newValue }
    }
    
    var endAngle: CGFloat {
        get { return renderer.endAngle }
        set { renderer.endAngle = newValue }
    }
    
    var timer = Timer()
    var timerActive = false
    var value: Int?
    var changeAngle: CGFloat?
    
    let renderer = RotaryDialRenderer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func commonInit() {
        renderer.updateBounds(bounds)
        
        layer.addSublayer(renderer.phoneDial)
        layer.addSublayer(renderer.wheel)
        for i in renderer.number {
            layer.addSublayer(i)
        }
        layer.addSublayer(renderer.wheelBreak)
        
        gestureRecognizer = RotationGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func handleGesture(_ gesture: RotationGestureRecognizer) {
        if timerActive != true {
            self.inputView?.layoutIfNeeded()
            
            let gestureLoacation = gesture.location(in: self)
            
            var boundedAngle = gesture.touchAngle
            
            if gesture.state == .began {
                renderer.startLocation = gestureLoacation
                renderer.startAngle = boundedAngle
                renderer.increaseAngle = boundedAngle
            }
            
            if boundedAngle < startAngle {
                boundedAngle += CGFloat.pi * 2
            }
            
            let angle = boundedAngle - renderer.startAngle
            
            if renderer.number[0].frame.contains(renderer.startLocation) {
                if renderer.increaseAngle < boundedAngle && angle < CGFloat.pi * 1.8 * 1 / 10 {
                    renderer.increaseAngle = boundedAngle
                    changeAngle = renderer.increaseAngle - renderer.startAngle
                    renderer.setPointerAngle(CGFloat(angle), animated: false)
                    value = 1
                }
            }else if renderer.number[1].frame.contains(renderer.startLocation) {
                if renderer.increaseAngle < boundedAngle && angle < CGFloat.pi * 1.8 * 2 / 10 {
                    renderer.increaseAngle = boundedAngle
                    changeAngle = renderer.increaseAngle - renderer.startAngle
                    renderer.setPointerAngle(CGFloat(angle), animated: false)
                    value = 2
                }
            }else if renderer.number[2].frame.contains(renderer.startLocation) {
                if renderer.increaseAngle < boundedAngle && angle < CGFloat.pi * 1.8 * 3 / 10 {
                    renderer.increaseAngle = boundedAngle
                    changeAngle = renderer.increaseAngle - renderer.startAngle
                    renderer.setPointerAngle(CGFloat(angle), animated: false)
                    value = 3
                }
            }else if renderer.number[3].frame.contains(renderer.startLocation) {
                if renderer.increaseAngle < boundedAngle && angle < CGFloat.pi * 1.8 * 4 / 10 {
                    renderer.increaseAngle = boundedAngle
                    changeAngle = renderer.increaseAngle - renderer.startAngle
                    renderer.setPointerAngle(CGFloat(angle), animated: false)
                    value = 4
                }
            }else if renderer.number[4].frame.contains(renderer.startLocation) {
                if renderer.increaseAngle < boundedAngle && angle < CGFloat.pi * 1.8 * 5 / 10 {
                    renderer.increaseAngle = boundedAngle
                    changeAngle = renderer.increaseAngle - renderer.startAngle
                    renderer.setPointerAngle(CGFloat(angle), animated: false)
                    value = 5
                }
            }else if renderer.number[5].frame.contains(renderer.startLocation) {
                if renderer.increaseAngle < boundedAngle && angle < CGFloat.pi * 1.8 * 6 / 10 {
                    renderer.increaseAngle = boundedAngle
                    changeAngle = renderer.increaseAngle - renderer.startAngle
                    renderer.setPointerAngle(CGFloat(angle), animated: false)
                    value = 6
                }
            }else if renderer.number[6].frame.contains(renderer.startLocation) {
                if renderer.increaseAngle < boundedAngle && angle < CGFloat.pi * 1.8 * 7 / 10 {
                    renderer.increaseAngle = boundedAngle
                    changeAngle = renderer.increaseAngle - renderer.startAngle
                    renderer.setPointerAngle(CGFloat(angle), animated: false)
                    value = 7
                }
            }else if renderer.number[7].frame.contains(renderer.startLocation) {
                if renderer.increaseAngle < boundedAngle && angle < CGFloat.pi * 1.8 * 8 / 10 {
                    renderer.increaseAngle = boundedAngle
                    changeAngle = renderer.increaseAngle - renderer.startAngle
                    renderer.setPointerAngle(CGFloat(angle), animated: false)
                    value = 8
                }
            }else if renderer.number[8].frame.contains(renderer.startLocation) {
                if renderer.increaseAngle < boundedAngle && angle < CGFloat.pi * 1.8 * 9 / 10 {
                    renderer.increaseAngle = boundedAngle
                    changeAngle = renderer.increaseAngle - renderer.startAngle
                    renderer.setPointerAngle(CGFloat(angle), animated: false)
                    value = 9
                }
            }else if renderer.number[9].frame.contains(renderer.startLocation) {
                if renderer.increaseAngle < boundedAngle && angle < CGFloat.pi * 1.8 * 10 / 10 {
                    renderer.increaseAngle = boundedAngle
                    changeAngle = renderer.increaseAngle - renderer.startAngle
                    renderer.setPointerAngle(CGFloat(angle), animated: false)
                    value = 0
                }
            }
            
            if gesture.state == .ended || gesture.state == .cancelled {
                timer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(reSpin), userInfo: nil, repeats: true)
                timerActive = true
            }
        }
    }
    
    @objc func reSpin() {
        if changeAngle ?? 0 >= CGFloat(0.0) {
            changeAngle! -= CGFloat(0.01)
            self.renderer.setPointerAngle(self.changeAngle!, animated: false)
        }else {
            timer.invalidate()
            timerActive = false
        }
        
    }
}

class RotaryDialRenderer {
    var phoneDialColor: UIColor = .black
    var whealBreakColor: UIColor = UIColor(white: 0.8, alpha: 1.0)
    var numberColor: UIColor = .black
    var wheelColor: UIColor = UIColor(white: 0.2, alpha: 0.5)
    
    let phoneDial = CAShapeLayer()
    let wheelBreak = CAShapeLayer()
    let wheel = CAShapeLayer()
    var number: [CATextLayer] = []
    
    var startLocation: CGPoint!
    var increaseAngle: CGFloat!
    var startAngle: CGFloat = -CGFloat.pi * 2.0
    var endAngle: CGFloat = 0.0
    
    init() {
        for i in 0...9 {
            number.append(CATextLayer())
            number[i].foregroundColor = numberColor.cgColor
        }
        phoneDial.backgroundColor = UIColor.white.cgColor
        phoneDial.fillColor = phoneDialColor.cgColor
        phoneDial.fillRule = .evenOdd
        wheelBreak.strokeColor = whealBreakColor.cgColor
        wheel.fillColor = wheelColor.cgColor
        wheel.fillRule = .evenOdd
    }
    
    func setPointerAngle(_ newPointerAngle: CGFloat, animated: Bool = false) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        wheel.transform = CATransform3DMakeRotation(newPointerAngle, 0, 0, 1)
        
        CATransaction.commit()
        
        updateWheelLayerPath()
    }
    
    func updatePhoneLayerPath() {
        let bounds = phoneDial.bounds
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let outlineOffset = CGFloat(10)
        let outlineRadius = min(bounds.width, bounds.height) / 2 - outlineOffset
        
        let inlineOffset = outlineRadius / 2
        let inlineRadius = outlineRadius - inlineOffset
        
        let wheelBreakOffset = CGFloat.pi * 1.8
        let pointX = bounds.midX + inlineRadius * sin(CGFloat.pi / 2 + wheelBreakOffset)
        let pointY = bounds.midY + inlineRadius * cos(CGFloat.pi / 2 + wheelBreakOffset)
        let pointDX = bounds.midX + outlineRadius * sin(CGFloat.pi / 2 + wheelBreakOffset)
        let pointDY = bounds.midY + outlineRadius * cos(CGFloat.pi / 2 + wheelBreakOffset)
        
        let outlineRing = UIBezierPath(arcCenter: center, radius: outlineRadius, startAngle: 0.0, endAngle: CGFloat.pi * 2, clockwise: false)
        let inlineRing = UIBezierPath(arcCenter: center, radius: inlineRadius, startAngle: 0.0, endAngle: CGFloat.pi * 2, clockwise: false)
        let line = UIBezierPath()
        line.move(to: CGPoint(x: pointX, y: pointY))
        line.addLine(to: CGPoint(x: pointDX, y: pointDY))
        
        outlineRing.append(inlineRing)
        
        for i in 0..<number.count {
            let offset = CGFloat(10)
            let radius = outlineRadius / 4 - offset
            let offsets = CGFloat.pi * 1.8 / 10.0 * CGFloat(i)
            let pointX = bounds.midX + outlineRadius * 3 / 4 * sin(CGFloat.pi / 2 + offsets)
            let pointY = bounds.midY + outlineRadius * 3 / 4 * cos(CGFloat.pi / 2 + offsets)
            
            number[i].fontSize = 30.0
            number[i].alignmentMode = .center
            number[i].frame = CGRect(x: pointX - radius, y: pointY - radius / 2, width: radius * 2, height: radius * 2)
            number[i].contentsScale = 2.0
            if i == 9 {
                number[i].string = String(0)
            }else {
                number[i].string = String(i + 1)
            }
            
            let ring = UIBezierPath(arcCenter: CGPoint(x: pointX, y: pointY), radius: radius, startAngle: 0.0, endAngle: CGFloat.pi * 2.0, clockwise: false)
            
            outlineRing.append(ring)
        }
        
        phoneDial.path = outlineRing.cgPath
        wheelBreak.path = line.cgPath
        wheelBreak.lineWidth = 5.0
    }
    
    func updateWheelLayerPath() {
        let bounds = wheel.bounds
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let offset = CGFloat(5)
        let radius = min(bounds.width, bounds.height) / 2 - offset
        
        let rings = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0.0, endAngle: CGFloat.pi * 2, clockwise: false)
        
        for i in 0..<number.count {
            let offset = CGFloat(10)
            let radius = (min(bounds.width, bounds.height) / 2 - CGFloat(10)) / 4 - offset
            let offsets = CGFloat.pi * 1.8 / 10.0 * CGFloat(i)
            let pointX = bounds.midX + (min(bounds.width, bounds.height) / 2 - CGFloat(10)) * 3 / 4 * sin(CGFloat.pi / 2 + offsets)
            let pointY = bounds.midY + (min(bounds.width, bounds.height) / 2 - CGFloat(10)) * 3 / 4 * cos(CGFloat.pi / 2 + offsets)
            
            let dial = UIBezierPath(arcCenter: CGPoint(x: pointX, y: pointY), radius: radius, startAngle: 0.0, endAngle: CGFloat.pi * 2.0, clockwise: false)
            
            rings.append(dial)
        }
        
        wheel.path = rings.cgPath
    }
    
    func updateBounds(_ bounds: CGRect) {
        phoneDial.bounds = bounds
        phoneDial.position = CGPoint(x: bounds.midX, y: bounds.midY)
        wheelBreak.bounds = bounds
        wheelBreak.position = CGPoint(x: bounds.midX, y: bounds.midY)
        updatePhoneLayerPath()
        
        wheel.bounds = bounds
        wheel.position = CGPoint(x: bounds.midX, y: bounds.midY)
        updateWheelLayerPath()
    }
}

class RotationGestureRecognizer: UIPanGestureRecognizer {
    private(set) var touchAngle: CGFloat = 0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        updateAngle(with: touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        updateAngle(with: touches)
    }
    
    private func updateAngle(with touches: Set<UITouch>) {
        guard
            let touch = touches.first,
            let view = view
            else {
                return
        }
        let touchPoint = touch.location(in: view)
        touchAngle = angle(for: touchPoint, in: view)
    }
    
    private func angle(for point: CGPoint, in view: UIView) -> CGFloat {
        let centerOffset = CGPoint(x: point.x - view.bounds.midX, y: point.y - view.bounds.midY)
        return atan2(centerOffset.y, centerOffset.x)
    }
    
    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
        
        maximumNumberOfTouches = 1
        minimumNumberOfTouches = 1
    }
    
    
}
