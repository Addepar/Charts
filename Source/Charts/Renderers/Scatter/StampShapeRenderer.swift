import Foundation
import CoreGraphics
import UIKit

open class StampShapeRenderer : NSObject, IShapeRenderer
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
        let halfWidth = width/2
        let halfHeight = height/2

        let rect = CGRect(x: -halfWidth, y: -halfHeight, width: width, height: height)
        let path = UIBezierPath(withStampInRect: rect, lineWidth: 1, spikes: 12, spikeDepth: 0.25, rotationOffset: 0)!

        context.setLineWidth(1.0)
        context.setStrokeColor(color.cgColor)
        context.setFillColor(color.cgColor)

        context.translateBy(x: point.x, y: point.y)

        path.fill()
        path.stroke()
    }
}
