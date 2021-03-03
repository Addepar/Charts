import Foundation
import CoreGraphics
import UIKit

open class TargetShapeRenderer : NSObject, IShapeRenderer
{
    open func renderShape(
        context: CGContext,
        dataSet: IScatterChartDataSet,
        viewPortHandler: ViewPortHandler,
        point: CGPoint,
        color: NSUIColor)
    {
        let width = dataSet.scatterShapeSize
        let height = width
        let radius: CGFloat = dataSet.scatterShapeSize/2

        context.setLineWidth(radius/4)
        context.setStrokeColor(color.cgColor)
        context.setFillColor(color.cgColor)
        context.translateBy(x: point.x, y: point.y)

        let path = UIBezierPath(
            arcCenter: CGPoint(x: 0.0, y: 0.0),
            radius: radius,
            startAngle: 0,
            endAngle: .pi * 2,
            clockwise: true
        )
        path.lineWidth = radius/4
        path.close()
        path.stroke()

        let path2 = UIBezierPath(
            arcCenter: CGPoint(x: 0.0, y: 0.0),
            radius: radius/3,
            startAngle: 0,
            endAngle: .pi * 2,
            clockwise: true
        )
        path2.close()

        path2.fill()
        path2.stroke()
    }
}
