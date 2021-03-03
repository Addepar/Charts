import Foundation
import CoreGraphics
import UIKit

open class BatShapeRenderer : NSObject, IShapeRenderer
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

        let path = UIBezierPath()

        path.addArc(
            withCenter: CGPoint(x: 0.0, y: 0.0),
            radius: radius,
            startAngle: -5 * .pi / 4,
            endAngle: -3 * .pi / 4,
            clockwise: true
        )
        path.addQuadCurve(to: CGPoint(x: radius * cos(.pi/4), y: -radius * sin(CGFloat.pi/4)), controlPoint: CGPoint(x: 0, y: 0))
        path.addArc(
            withCenter: CGPoint(x: 0.0, y: 0.0),
            radius: radius,
            startAngle: -.pi / 4,
            endAngle: .pi / 4,
            clockwise: true
        )
        path.addQuadCurve(
            to: CGPoint(x: radius * cos(-5 * .pi / 4), y: radius * sin(-5 * .pi / 4)),
            controlPoint: CGPoint(x: 0, y: 0)
        )
        path.close()

        context.setLineWidth(1.0)
        context.setStrokeColor(color.cgColor)
        context.setFillColor(color.cgColor)

        context.translateBy(x: point.x, y: point.y)

        path.fill()
        path.stroke()
    }
}
