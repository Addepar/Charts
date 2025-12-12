import CoreGraphics
import Foundation

open class BatShapeRenderer: NSObject, IShapeRenderer {
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

        let path = CGMutablePath()
        path.addArc(
            center: CGPoint(x: 0.0, y: 0.0), radius: radius, startAngle: -5 * .pi / 4,
            endAngle: -3 * .pi / 4, clockwise: true)
        path.addQuadCurve(
            to: CGPoint(x: radius * cos(.pi / 4), y: -radius * sin(CGFloat.pi / 4)),
            control: CGPoint(x: 0, y: 0))
        path.addArc(
            center: CGPoint(x: 0.0, y: 0.0), radius: radius, startAngle: -.pi / 4,
            endAngle: .pi / 4, clockwise: true)
        path.addQuadCurve(
            to: CGPoint(x: radius * cos(-5 * .pi / 4), y: radius * sin(-5 * .pi / 4)),
            control: CGPoint(x: 0, y: 0))
        path.closeSubpath()

        context.saveGState()
        context.translateBy(x: point.x, y: point.y)
        context.setLineWidth(1.0)
        context.setStrokeColor(color.cgColor)
        context.setFillColor(color.cgColor)
        context.addPath(path)
        context.drawPath(using: .fillStroke)
        context.restoreGState()
    }
}
