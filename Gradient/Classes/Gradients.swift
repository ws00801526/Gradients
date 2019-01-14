//  Gradients.swift
//  Pods
//
//  Created by  XMFraker on 2019/1/4
//  Copyright © XMFraker All rights reserved. (https://github.com/ws00801526)
//  Gradient Designed by https://webgradients.com/
//  Github https://github.com/itmeo/webgradients
//  Github https://github.com/cruisediary/Gradients

import Foundation

public enum Gradients {
    
    case warmFlame
    case nightFade
    case springWarmth
    case juicyPeach
    case youngPassion
    case ladyLips
    case sunnyMorning
    case rainyAshville
    case frozenDreams
    case winterNeva
    case dustyGrass
    case temptingAzure
    case heavyRain
    case amyCrisp
    case meanFruit
    case deepBlue
    case ripeMalinka
    case cloudyKnoxville
    case malibuBeach
    case newLife
    case trueSunset
    case morpheusDen
    case rareWind
    case nearMoon
    case wildApple
    case saintPeterburg
    case ariellesSmile
    case plumPlate
    case everlastingSky
    case happyFisher
    case instagram
}

public enum Position {
    
    case left
    case top
    case right
    case bottom
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
    case degree(CGFloat)
}

public extension Position {
    
    var point: CGPoint {
        switch self {
        case .left: return CGPoint(x: 0.0, y: 0.5)
        case .top: return CGPoint(x: 0.5, y: 0.0)
        case .right: return CGPoint(x: 1.0, y: 0.5)
        case .bottom: return CGPoint(x: 0.5, y: 1.0)
        case .topLeft: return CGPoint(x: 0.0, y: 0.0)
        case .topRight: return CGPoint(x: 1.0, y: 0.0)
        case .bottomLeft: return CGPoint(x: 0.0, y: 1.0)
        case .bottomRight: return CGPoint(x: 1.0, y: 1.0)
        case .degree(let degree):
            let radian = degree * .pi / 180
            return CGPoint(x: 0.5 * (cos(radian) + 1), y: 0.5 * (1 - sin(radian)))
        }
    }
}

public extension Gradients {
    
    public static func layer(withColors colors: [UIColor], start: Position = .bottomLeft, end: Position = .topRight, locations: [NSNumber]? = nil) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.colors = colors.map { $0.cgColor }
        layer.locations = locations
        layer.startPoint = start.point
        layer.endPoint = end.point
        return layer
    }
    
    public func layer(start: Position = .bottomLeft, end: Position = .topRight, locations: [NSNumber]? = nil) -> CAGradientLayer {
        return Gradients.layer(withColors: colors(), start: start, end: end, locations: locations)
    }
    
    public func colors() -> [UIColor] {
        switch self {
        case .warmFlame:         return [#colorLiteral(red: 1, green: 0.6039215686, blue: 0.6196078431, alpha: 1), #colorLiteral(red: 0.9803921569, green: 0.8156862745, blue: 0.768627451, alpha: 1)]
        case .nightFade:         return [#colorLiteral(red: 0.631372549, green: 0.5490196078, blue: 0.8196078431, alpha: 1), #colorLiteral(red: 0.9843137255, green: 0.7607843137, blue: 0.9215686275, alpha: 1)]
        case .springWarmth:      return [#colorLiteral(red: 0.9803921569, green: 0.8156862745, blue: 0.768627451, alpha: 1), #colorLiteral(red: 1, green: 0.8196078431, blue: 1, alpha: 1)]
        case .juicyPeach:        return [#colorLiteral(red: 1, green: 0.9254901961, blue: 0.8235294118, alpha: 1), #colorLiteral(red: 0.9882352941, green: 0.7137254902, blue: 0.6235294118, alpha: 1)]
        case .sunnyMorning:      return [#colorLiteral(red: 0.9647058824, green: 0.8274509804, blue: 0.3960784314, alpha: 1), #colorLiteral(red: 0.9921568627, green: 0.6274509804, blue: 0.5215686275, alpha: 1)]
        case .rainyAshville:     return [#colorLiteral(red: 0.9843137255, green: 0.7607843137, blue: 0.9215686275, alpha: 1), #colorLiteral(red: 0.6509803922, green: 0.7568627451, blue: 0.9333333333, alpha: 1)]
        case .winterNeva:        return [#colorLiteral(red: 0.631372549, green: 0.768627451, blue: 0.9921568627, alpha: 1), #colorLiteral(red: 0.7607843137, green: 0.9137254902, blue: 0.9843137255, alpha: 1)]
        case .dustyGrass:        return [#colorLiteral(red: 0.831372549, green: 0.9882352941, blue: 0.4745098039, alpha: 1), #colorLiteral(red: 0.5882352941, green: 0.9019607843, blue: 0.631372549, alpha: 1)]
        case .temptingAzure:     return [#colorLiteral(red: 0.5176470588, green: 0.9803921569, blue: 0.6901960784, alpha: 1), #colorLiteral(red: 0.5607843137, green: 0.8274509804, blue: 0.9568627451, alpha: 1)]
        case .heavyRain:         return [#colorLiteral(red: 0.8117647059, green: 0.8509803922, blue: 0.8745098039, alpha: 1), #colorLiteral(red: 0.8862745098, green: 0.9215686275, blue: 0.9411764706, alpha: 1)]
        case .amyCrisp:          return [#colorLiteral(red: 0.6509803922, green: 0.7529411765, blue: 0.9960784314, alpha: 1), #colorLiteral(red: 0.9647058824, green: 0.5019607843, blue: 0.5176470588, alpha: 1)]
        case .meanFruit:         return [#colorLiteral(red: 0.9882352941, green: 0.7960784314, blue: 0.5647058824, alpha: 1), #colorLiteral(red: 0.8352941176, green: 0.4941176471, blue: 0.9215686275, alpha: 1)]
        case .deepBlue:          return [#colorLiteral(red: 0.8784313725, green: 0.7647058824, blue: 0.9882352941, alpha: 1), #colorLiteral(red: 0.5568627451, green: 0.7725490196, blue: 0.9882352941, alpha: 1)]
        case .ripeMalinka:       return [#colorLiteral(red: 0.9411764706, green: 0.5764705882, blue: 0.9843137255, alpha: 1), #colorLiteral(red: 0.9607843137, green: 0.3411764706, blue: 0.4235294118, alpha: 1)]
        case .cloudyKnoxville:   return [#colorLiteral(red: 0.9921568627, green: 0.9843137255, blue: 0.9843137255, alpha: 1), #colorLiteral(red: 0.9215686275, green: 0.9294117647, blue: 0.9333333333, alpha: 1)]
        case .malibuBeach:       return [#colorLiteral(red: 0.3098039216, green: 0.6745098039, blue: 0.9960784314, alpha: 1), #colorLiteral(red: 0, green: 0.9490196078, blue: 0.9960784314, alpha: 1)]
        case .newLife:           return [#colorLiteral(red: 0.262745098, green: 0.9137254902, blue: 0.4823529412, alpha: 1), #colorLiteral(red: 0.2196078431, green: 0.9764705882, blue: 0.8431372549, alpha: 1)]
        case .trueSunset:        return [#colorLiteral(red: 0.9803921569, green: 0.4392156863, blue: 0.6039215686, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.8823529412, blue: 0.2509803922, alpha: 1)]
        case .morpheusDen:       return [#colorLiteral(red: 0.1882352941, green: 0.8117647059, blue: 0.8156862745, alpha: 1), #colorLiteral(red: 0.2, green: 0.03137254902, blue: 0.4039215686, alpha: 1)]
        case .rareWind:          return [#colorLiteral(red: 0.6588235294, green: 0.9294117647, blue: 0.9176470588, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.8392156863, blue: 0.8901960784, alpha: 1)]
        case .nearMoon:          return [#colorLiteral(red: 0.368627451, green: 0.9058823529, blue: 0.8745098039, alpha: 1), #colorLiteral(red: 0.7058823529, green: 0.5647058824, blue: 0.7921568627, alpha: 1)]
        case .wildApple:         return [#colorLiteral(red: 0.8235294118, green: 0.6, blue: 0.7607843137, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.9764705882, blue: 0.8431372549, alpha: 1)]
        case .saintPeterburg:    return [#colorLiteral(red: 0.9607843137, green: 0.968627451, blue: 0.9803921569, alpha: 1), #colorLiteral(red: 0.7647058824, green: 0.8117647059, blue: 0.8862745098, alpha: 1)]
        case .plumPlate:         return [#colorLiteral(red: 0.4, green: 0.4941176471, blue: 0.9176470588, alpha: 1), #colorLiteral(red: 0.462745098, green: 0.2941176471, blue: 0.6352941176, alpha: 1)]
        case .everlastingSky:    return [#colorLiteral(red: 0.9921568627, green: 0.9882352941, blue: 0.9843137255, alpha: 1), #colorLiteral(red: 0.8862745098, green: 0.8196078431, blue: 0.7647058824, alpha: 1)]
        case .happyFisher:       return [#colorLiteral(red: 0.537254902, green: 0.968627451, blue: 0.9960784314, alpha: 1), #colorLiteral(red: 0.4, green: 0.6509803922, blue: 1, alpha: 1)]
        case .ariellesSmile:     return [#colorLiteral(red: 0.0862745098, green: 0.8509803922, blue: 0.8901960784, alpha: 1), #colorLiteral(red: 0.1882352941, green: 0.7803921569, blue: 0.9254901961, alpha: 1), #colorLiteral(red: 0.2745098039, green: 0.6823529412, blue: 0.968627451, alpha: 1)]
        case .frozenDreams:      return [#colorLiteral(red: 0.9921568627, green: 0.7960784314, blue: 0.9450980392, alpha: 1), #colorLiteral(red: 0.9921568627, green: 0.7960784314, blue: 0.9450980392, alpha: 1), #colorLiteral(red: 0.9019607843, green: 0.8705882353, blue: 0.9137254902, alpha: 1)]
        case .ladyLips:          return [#colorLiteral(red: 1, green: 0.6039215686, blue: 0.6196078431, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.8117647059, blue: 0.937254902, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.8117647059, blue: 0.937254902, alpha: 1)]
        case .youngPassion:      return [#colorLiteral(red: 1, green: 0.5058823529, blue: 0.4666666667, alpha: 1), #colorLiteral(red: 1, green: 0.5254901961, blue: 0.4784313725, alpha: 1), #colorLiteral(red: 1, green: 0.5490196078, blue: 0.4980392157, alpha: 1), #colorLiteral(red: 0.9764705882, green: 0.568627451, blue: 0.5215686275, alpha: 1), #colorLiteral(red: 0.8117647059, green: 0.3333333333, blue: 0.4235294118, alpha: 1), #colorLiteral(red: 0.6941176471, green: 0.1647058824, blue: 0.3568627451, alpha: 1)]
        case .instagram:         return [#colorLiteral(red: 0.6117647059, green: 0.1529411765, blue: 0.6901960784, alpha: 1), #colorLiteral(red: 1, green: 0.2509803922, blue: 0.5058823529, alpha: 1), #colorLiteral(red: 0.4823529412, green: 0.1215686275, blue: 0.6352941176, alpha: 1), #colorLiteral(red: 0.1254901961, green: 0.2980392157, blue: 1, alpha: 1), #colorLiteral(red: 0.1254901961, green: 0.6196078431, blue: 1, alpha: 1), #colorLiteral(red: 0.3529411765, green: 0.4705882353, blue: 0.4980392157, alpha: 1), #colorLiteral(red: 0.2274509804, green: 1, blue: 0.8509803922, alpha: 1)]
        }
    }
}
