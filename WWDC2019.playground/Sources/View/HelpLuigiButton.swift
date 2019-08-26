import UIKit

class HelpLuigiButton: UIButton {
 
    internal override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(window: UIWindow) {
        let marginButton: CGFloat = 30
        let widthButton = window.frame.width * 0.20
        let heightButton = widthButton / Constants.helpLuigiProportion
        let xButton = window.frame.width - widthButton - marginButton
        let yButton = window.frame.height - heightButton - 8
        self.init(frame: CGRect(x: xButton, y: yButton, width: widthButton, height: heightButton))
        self.alpha = 0.0
        self.setImage(UIImage(named: "Images/helpLuigi"), for: .normal)
        UIView.animate(withDuration: 0.4) {
            self.alpha = 1.0
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        Player.shared.click()
    }
    
}
