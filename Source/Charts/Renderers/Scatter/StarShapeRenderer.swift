import Foundation
import CoreGraphics
import UIKit

open class StarShapeRenderer : NSObject, IShapeRenderer
{
    open func renderShape(
        context: CGContext,
        dataSet: IScatterChartDataSet,
        viewPortHandler: ViewPortHandler,
        point: CGPoint,
        color: NSUIColor)
    {
        let width = dataSet.scatterShapeSize
        let height = width * 0.4
        let halfWidth = width/2
        let halfHeight = height/2

        context.saveGState()

        let path = UIBezierPath(ovalIn: CGRect(x: -halfWidth, y: -halfHeight, width: width, height: height))
        context.setLineWidth(1.0)
        context.setStrokeColor(color.cgColor)
        context.setFillColor(color.cgColor)

        context.translateBy(x: point.x, y: point.y)

        path.fill()
        path.stroke()

        path.apply(CGAffineTransform(rotationAngle: 90 * .pi / 180))
        path.fill()
        path.stroke()

        context.restoreGState()
    }
}
