import UIKit

protocol Appearable {}

extension Appearable where Self: UIView {

    func appear(alphaIn: CGFloat, alphaOut: CGFloat, duration: Double, delay: Double, scaleX: CGFloat, scaleY: CGFloat, onCompletion: ((Bool) -> Void)? = nil) {
        self.alpha = alphaIn

        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.alpha = alphaOut
            self.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        }, completion: onCompletion)

        self.transform = CGAffineTransform.identity
    }

    func disappear(alphaIn: CGFloat, alphaOut: CGFloat, duration: Double, delay: Double, scaleX: CGFloat, scaleY: CGFloat, onCompletion: ((Bool) -> Void)? = nil) {
        self.alpha = alphaIn
        self.transform = CGAffineTransform.identity

        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.alpha = alphaOut
            self.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)

        }, completion: onCompletion)

    }
}

