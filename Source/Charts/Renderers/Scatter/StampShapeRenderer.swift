import CoreGraphics
import Foundation

open class StampShapeRenderer: NSObject, IShapeRenderer {
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

        let spikes = 12
        let spikeDepth: CGFloat = 0.25
        let lineWidth: CGFloat = 1
        let rotationOffset: CGFloat = 0

        let theta: CGFloat = CGFloat(2.0 * CGFloat.pi) / CGFloat(spikes)
        let halfTheta: CGFloat = theta / 2
        let radius = (min(rect.size.width, rect.size.height) - lineWidth) / 2.0
        let spikeRadius = radius * (1 - spikeDepth)
        let center = CGPoint(x: rect.midX, y: rect.midY)

        let path = CGMutablePath()
        var angle = rotationOffset

        let firstPoint = CGPoint(
            x: center.x + radius * cos(angle), y: center.y + radius * sin(angle))
        path.move(to: firstPoint)

        for i in 0..<(spikes * 2) {
            angle += halfTheta
            let r = i % 2 == 0 ? spikeRadius : radius
            let point = CGPoint(x: center.x + r * cos(angle), y: center.y + r * sin(angle))
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
