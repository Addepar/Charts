import CoreGraphics
import Foundation

open class TargetShapeRenderer: NSObject, IShapeRenderer {
    open func renderShape(
        context: CGContext,
        dataSet: IScatterChartDataSet,
        viewPortHandler: ViewPortHandler,
        point: CGPoint,
        color: NSUIColor
    ) {
        let width = dataSet.scatterShapeSize
        let height = width
        let radius: CGFloat = dataSet.scatterShapeSize / 2

        context.saveGState()
        context.translateBy(x: point.x, y: point.y)
        context.setStrokeColor(color.cgColor)
        context.setFillColor(color.cgColor)

        // Outer circle
        context.setLineWidth(radius / 4)
        context.addArc(
            center: CGPoint(x: 0.0, y: 0.0), radius: radius, startAngle: 0, endAngle: .pi * 2,
            clockwise: false)
        context.strokePath()

        // Inner circle
        context.setLineWidth(1.0)
        context.addArc(
            center: CGPoint(x: 0.0, y: 0.0), radius: radius / 3, startAngle: 0, endAngle: .pi * 2,
            clockwise: false)
        context.drawPath(using: .fillStroke)

        context.restoreGState()
    }
}
