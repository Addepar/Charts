import CoreGraphics
import Foundation

open class StarShapeRenderer: NSObject, IShapeRenderer {
    open func renderShape(
        context: CGContext,
        dataSet: IScatterChartDataSet,
        viewPortHandler: ViewPortHandler,
        point: CGPoint,
        color: NSUIColor
    ) {
        let width = dataSet.scatterShapeSize
        let height = width * 0.4
        let halfWidth = width / 2
        let halfHeight = height / 2

        context.saveGState()
        context.translateBy(x: point.x, y: point.y)
        context.setLineWidth(1.0)
        context.setStrokeColor(color.cgColor)
        context.setFillColor(color.cgColor)

        let rect = CGRect(x: -halfWidth, y: -halfHeight, width: width, height: height)
        context.addEllipse(in: rect)
        context.drawPath(using: .fillStroke)

        context.rotate(by: 90 * .pi / 180)
        context.addEllipse(in: rect)
        context.drawPath(using: .fillStroke)

        context.restoreGState()
    }
}
