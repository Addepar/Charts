import Foundation
import CoreGraphics
import UIKit

extension UIBezierPath {
    convenience init?(withPolygonInRect rect: CGRect, lineWidth: CGFloat, sides: NSInteger, cornerRadius: CGFloat, rotationOffset: CGFloat = 0) {
        self.init()

        let theta: CGFloat = CGFloat(2.0 * CGFloat.pi) / CGFloat(sides) // How much to turn at every corner
        let width = min(rect.size.width, rect.size.height)        // Width of the square

        let center = CGPoint(x: rect.origin.x + width / 2.0, y: rect.origin.y + width / 2.0)

        // Radius of the circle that encircles the polygon
        // Notice that the radius is adjusted for the corners, that way the largest outer
        // dimension of the resulting shape is always exactly the width - linewidth
        let radius = (width - lineWidth + cornerRadius - (cos(theta) * cornerRadius)) / 2.0

        // Start drawing at a point, which by default is at the right hand edge
        // but can be offset
        var angle = CGFloat(rotationOffset)

        let corner = CGPoint(x: center.x + (radius - cornerRadius) * cos(angle), y: center.y + (radius - cornerRadius) * sin(angle))
        move(to: CGPoint(x: corner.x + cornerRadius * cos(angle + theta), y: corner.y + cornerRadius * sin(angle + theta)))

        for _ in 0..<sides {
            angle += theta

            let corner = CGPoint(x: center.x + (radius - cornerRadius) * cos(angle), y: center.y + (radius - cornerRadius) * sin(angle))
            let tip = CGPoint(x: center.x + radius * cos(angle), y: center.y + radius * sin(angle))
            let start = CGPoint(x: corner.x + cornerRadius * cos(angle - theta), y: corner.y + cornerRadius * sin(angle - theta))
            let end = CGPoint(x: corner.x + cornerRadius * cos(angle + theta), y: corner.y + cornerRadius * sin(angle + theta))

            addLine(to: start)
//            addQuadCurve(to: end, controlPoint: tip)
        }

        close()

        // Move the path to the correct origins
        let bounds = self.bounds
        let transform = CGAffineTransform(
            translationX: -bounds.origin.x + rect.origin.x + lineWidth / 2.0,
            y: -bounds.origin.y + rect.origin.y + lineWidth / 2.0
        )
        apply(transform)
    }

    convenience init?(withStampInRect rect: CGRect, lineWidth: CGFloat, spikes: NSInteger, spikeDepth: CGFloat, rotationOffset: CGFloat = 0) {
        self.init()

        let theta: CGFloat = CGFloat(2.0 * CGFloat.pi) / CGFloat(spikes) // How much to turn at every corner
        let halfTheta: CGFloat = theta/2
        let width = min(rect.size.width, rect.size.height)        // Width of the square

        let center = CGPoint(x: rect.origin.x + width / 2.0, y: rect.origin.y + width / 2.0)

        // Radius of the circle that encircles the polygon
        // Notice that the radius is adjusted for the corners, that way the largest outer
        // dimension of the resulting shape is always exactly the width - linewidth
        let radius = (width - lineWidth) / 2.0
        let spikeRadius = radius * (1 - spikeDepth)

        // Start drawing at a point, which by default is at the right hand edge
        // but can be offset
        var angle = CGFloat(rotationOffset)

        let corner = CGPoint(x: center.x + radius * cos(angle), y: center.y + radius * sin(angle))
        move(to: CGPoint(x: corner.x, y: corner.y))
        for i in 0..<(spikes*2) {
            angle += halfTheta
            let r = i % 2 == 0 ? spikeRadius : radius
            let corner = CGPoint(x: center.x + r * cos(angle), y: center.y + r * sin(angle))
            let start = CGPoint(x: corner.x, y: corner.y)
            addLine(to: start)
        }

        close()

        // Move the path to the correct origins
        let bounds = self.bounds
        let transform = CGAffineTransform(
            translationX: -bounds.origin.x + rect.origin.x + lineWidth / 2.0,
            y: -bounds.origin.y + rect.origin.y + lineWidth / 2.0
        )
        apply(transform)
    }
}
