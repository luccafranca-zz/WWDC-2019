import UIKit

class StartButton: UIButton {
    
    internal override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public convenience init(window: UIWindow) {
        let heightBtn = window.frame.height * 0.4
        let widthBtn = heightBtn
        self.init(frame: CGRect(x: 0, y: 0, width: widthBtn, height: heightBtn))
        self.setImage(UIImage(named: "Images/play"), for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
        self.center = window.center
        
        let animationBtn = CABasicAnimation(keyPath: "transform.scale")
        animationBtn.duration = 1.0
        animationBtn.fromValue = 0.92
        animationBtn.toValue = 1
        animationBtn.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animationBtn.autoreverses = true
        animationBtn.repeatCount = .greatestFiniteMagnitude
        self.layer.add(animationBtn, forKey: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        Player.shared.click()
    }

}
