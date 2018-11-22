//
//  XAxisRendererRadarChart.swift
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

#if !os(OSX)
import UIKit
#endif

open class XAxisRendererRadarChart: XAxisRenderer
{
    @objc open weak var chart: RadarChartView?
    
    @objc public init(viewPortHandler: ViewPortHandler, xAxis: XAxis?, chart: RadarChartView)
    {
        super.init(viewPortHandler: viewPortHandler, xAxis: xAxis, transformer: nil)
        
        self.chart = chart
    }
    
    open override func renderAxisLabels(context: CGContext)
    {
        guard let
            xAxis = axis as? XAxis,
            let chart = chart
            else { return }
        
        if !xAxis.isEnabled || !xAxis.isDrawLabelsEnabled
        {
            return
        }
        
        let labelFont = xAxis.labelFont
        var labelTextColor = xAxis.labelTextColor
        let labelRotationAngleRadians = xAxis.labelRotationAngle.RAD2DEG
        let drawLabelAnchor = CGPoint(x: 0.5, y: 0.5)
        
        let sliceangle = chart.sliceAngle
        
        // calculate the factor that is needed for transforming the value to pixels
        let factor = chart.factor
        
        let center = chart.centerOffsets
        
        for i in stride(from: 0, to: chart.data?.maxEntryCountSet?.entryCount ?? 0, by: 1)
        {
            
            if chart.webColors.count > i{
                labelTextColor = chart.webColors[i]
            }
            let label = xAxis.valueFormatter?.stringForValue(Double(i), axis: xAxis) ?? ""
            let angle = (sliceangle * CGFloat(i) + chart.rotationAngle).truncatingRemainder(dividingBy: 360.0)
            
            let valueTextSize = NSString(string: label).size(withAttributes: [NSAttributedStringKey.font : labelFont])
            let valueTextCenter = CGPoint(x: valueTextSize.width/2, y: valueTextSize.height/2)
            
            let sliceXBase = cos(angle.DEG2RAD)
            let sliceYBase = sin(angle.DEG2RAD)
            
            let valueTextRadius = [(0-valueTextCenter.x)/sliceXBase,
                                   (valueTextSize.width-valueTextCenter.x)/sliceXBase,
                                   (0-valueTextCenter.y)/sliceYBase,
                                   (valueTextSize.height-valueTextCenter.y)/sliceYBase].filter({ (a) -> Bool in
                                    return a > 0
                                   }) .min { (a, b) -> Bool in
                                    return a < b
                } ?? 0
            

            
            let p = center.moving(distance: (CGFloat(chart.yRange) * factor + valueTextRadius + chart.webLineHoleRadius + 5), atAngle: angle)
            drawLabel(context: context,
                      formattedLabel: label,
                      x: p.x,
                y: p.y,
                attributes: [NSAttributedStringKey.font: labelFont, NSAttributedStringKey.foregroundColor: labelTextColor],
                anchor: drawLabelAnchor,
                angleRadians: labelRotationAngleRadians)
            
        }
    }
    
    @objc open func drawLabel(
        context: CGContext,
        formattedLabel: String,
        x: CGFloat,
        y: CGFloat,
        attributes: [NSAttributedStringKey : Any],
        anchor: CGPoint,
        angleRadians: CGFloat)
    {
        ChartUtils.drawText(
            context: context,
            text: formattedLabel,
            point: CGPoint(x: x, y: y),
            attributes: attributes,
            anchor: anchor,
            angleRadians: angleRadians)
    }
    
    open override func renderLimitLines(context: CGContext)
    {
        /// XAxis LimitLines on RadarChart not yet supported.
    }
}
