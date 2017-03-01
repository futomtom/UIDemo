//
//  StencilView.swift
//  StencilView
//
//  Created by Swarup on 28/6/16.
//  Copyright © 2016 swarup. All rights reserved.
//

import UIKit

class StencilView : UIView {
    
    var font = "Verdana-Bold"
    var strokeColor = UIColor.black.cgColor
    var textLayer = CAShapeLayer()
    var lineWidth:CGFloat = 1.0
    var animationDuration = 3.0
    var fontSize:CGFloat = 64
    var spacing:CGFloat = 10
    
    func drawText(_ text: String) {
        CATransaction.begin()
            self.textLayer.removeFromSuperlayer()
        self.textLayer = CAShapeLayer()
        
        let layer = self.textLayer
        let path = self.getPath(text)
        CATransaction.setCompletionBlock {
            layer.fillColor = UIColor.red.cgColor
        }

        
        layer.path = path.cgPath
        
        layer.bounds = path.bounds
        layer.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        layer.lineWidth = self.lineWidth
        layer.strokeColor = self.strokeColor
        layer.fillColor = UIColor.clear.cgColor
        layer.isGeometryFlipped = true
        
        layer.strokeStart = 0.0
        layer.strokeEnd = 1.0
        
        let anim = CABasicAnimation(keyPath: "strokeEnd")
        anim.duration = animationDuration
        anim.fromValue = 0.0
        anim.toValue = 1.0
        
        layer.add(anim, forKey: nil)
        self.layer.addSublayer(self.textLayer)
        
         CATransaction.commit()
      
    }
    
    
    
    func getPath(_ word: String) -> UIBezierPath {
        let path = UIBezierPath()
        let spacing: CGFloat = self.spacing
        var i: CGFloat = 0
        for letter in word.characters {
            let newPath = getPathForLetter(letter)
            let actualPathRect = path.cgPath.boundingBox
            let transform = CGAffineTransform(translationX: (actualPathRect.width + min(i, 1)*spacing), y: 0)
            newPath.apply(transform)
            path.append(newPath)
            i += 1
        }
        
        return path
    }
    
    func getPathForLetter(_ letter: Character) -> UIBezierPath {
        var path = UIBezierPath()
        let font = CTFontCreateWithName(self.font as CFString?, self.fontSize, nil)
        var unichars = [UniChar]("\(letter)".utf16)
        var glyphs = [CGGlyph](repeating: 0, count: unichars.count)
        
        let gotGlyphs = CTFontGetGlyphsForCharacters(font, &unichars, &glyphs, unichars.count)
        if gotGlyphs {
            let cgpath = CTFontCreatePathForGlyph(font, glyphs[0], nil)
            path = UIBezierPath(cgPath: cgpath!)
        }
        
        return path
    }
}

