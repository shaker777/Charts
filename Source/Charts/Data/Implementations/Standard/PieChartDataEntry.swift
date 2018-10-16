//
//  PieChartDataEntry.swift
//  Charts
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/Charts
//

import Foundation
import CoreGraphics

open class PieChartDataEntry: ChartDataEntry
{
    public required init()
    {
        super.init()
    }
    
    /// - parameter value: The value on the y-axis
    /// - parameter label: The label for the x-axis
    @objc public convenience init(value1: Double, value2: Double, label: String?)
    {
        self.init(value1: value1, value2: value2, label: label, icon: nil, data: nil)
    }
    
    /// - parameter value: The value on the y-axis
    /// - parameter label: The label for the x-axis
    /// - parameter data: Spot for additional data this Entry represents
    @objc public convenience init(value1: Double, value2: Double, label: String?, data: AnyObject?)
    {
        self.init(value1: value1, value2: value2, label: label, icon: nil, data: data)
    }
    
    /// - parameter value: The value on the y-axis
    /// - parameter label: The label for the x-axis
    /// - parameter icon: icon image
    @objc public convenience init(value1: Double, value2: Double, label: String?, icon: NSUIImage?)
    {
        self.init(value1: value1, value2: value2, label: label, icon: icon, data: nil)
    }
    
    /// - parameter value: The value on the y-axis
    /// - parameter label: The label for the x-axis
    /// - parameter icon: icon image
    /// - parameter data: Spot for additional data this Entry represents
    @objc public init(value1: Double, value2: Double, label: String?, icon: NSUIImage?, data: AnyObject?)
    {
        super.init(x: value1, y: value2, icon: icon, data: data)
        
        self.label = label
    }
    
    /// - parameter value: The value on the y-axis
    @objc public convenience init(value1: Double, value2: Double)
    {
        self.init(value1: value1, value2: value2, label: nil, icon: nil, data: nil)
    }
    
    /// - parameter value: The value on the y-axis
    /// - parameter data: Spot for additional data this Entry represents
    @objc public convenience init(value1: Double, value2: Double, data: AnyObject?)
    {
        self.init(value1: value1, value2: value2, label: nil, icon: nil, data: data)
    }
    
    /// - parameter value: The value on the y-axis
    /// - parameter icon: icon image
    @objc public convenience init(value1: Double, value2: Double, icon: NSUIImage?)
    {
        self.init(value1: value1, value2: value2, label: nil, icon: icon, data: nil)
    }
    
    /// - parameter value: The value on the y-axis
    /// - parameter icon: icon image
    /// - parameter data: Spot for additional data this Entry represents
    @objc public convenience init(value1: Double, value2: Double, icon: NSUIImage?, data: AnyObject?)
    {
        self.init(value1: value1, value2: value2, label: nil, icon: icon, data: data)
    }
    
    // MARK: Data property accessors
    
    @objc open var label: String?
    
    @objc open var value1: Double
    {
        get { return x }
        set { x = newValue }
    }
    
    @objc open var value2: Double
        {
        get { return y }
        set { y = newValue }
    }
        
    // MARK: NSCopying
    
    open override func copyWithZone(_ zone: NSZone?) -> AnyObject
    {
        let copy = super.copyWithZone(zone) as! PieChartDataEntry
        copy.label = label
        return copy
    }
}
