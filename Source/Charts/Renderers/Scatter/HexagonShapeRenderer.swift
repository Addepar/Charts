import CoreGraphics
import Foundation

open class HexagonShapeRenderer: NSObject, IShapeRenderer {
    open func renderShape(
        context: CGContext,
        dataSet: IScatterChartDataSet,
        viewPortHandler: ViewPortHandler,
        point: CGPoint,
        color: NSUIColor
    ) {
        let width = dataSet.scatterShapeSize
        let height = width
        let halfWidth = width / 2
        let halfHeight = height / 2

        let rect = CGRect(x: -halfWidth, y: -halfHeight, width: width, height: height)

        let sides = 6
        let theta: CGFloat = CGFloat(2.0 * CGFloat.pi) / CGFloat(sides)
        let radius = min(rect.size.width, rect.size.height) / 2.0
        let center = CGPoint(x: rect.midX, y: rect.midY)

        let path = CGMutablePath()
        var angle = CGFloat.pi / 6.0  // rotationOffset

        let firstPoint = CGPoint(
            x: center.x + radius * cos(angle), y: center.y + radius * sin(angle))
        path.move(to: firstPoint)

        for _ in 0..<sides {
            angle += theta
            let point = CGPoint(
                x: center.x + radius * cos(angle), y: center.y + radius * sin(angle))
            path.addLine(to: point)
        }
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
