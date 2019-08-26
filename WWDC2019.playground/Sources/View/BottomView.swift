import UIKit

public class BottomView: UIView {
    
    private var signsViewList: [UIImageView] = []
    private var word: String = ""
    
    internal override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.topLeft, .topRight], radius: 30.0)
    }
    
    public convenience init(frameView: CGRect) {
        let width = frameView.width
        let height = frameView.height * 0.185
        let frameRect = CGRect(x: 0, y: frameView.maxY - height, width: width, height: height)
        self.init(frame: frameRect)
        self.layer.zPosition = 10
        self.backgroundColor = UIColor.white
    }
    
    func setNew(word: String) {
        for image in self.signsViewList {
            image.removeFromSuperview()
        }
        self.word = word
        var leftMargin: CGFloat = 20.0
        let topMargin: CGFloat = self.frame.height * 0.1
        let heightHand = self.frame.height * 0.8
        let widthHand = heightHand
        for letter in word {
            let letter_right = String(letter)
            let imageView = UIImageView(image: UIImage(named: "Images/HandsGrayscale/" + letter_right.lowercased()))
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: leftMargin, y: topMargin, width: widthHand, height: heightHand)
            self.addSubview(imageView)
            self.signsViewList.append(imageView)
            leftMargin = leftMargin + imageView.frame.width + 20
        }
    }
    
    func changeSign(in index: Int) {
        let handImage = self.signsViewList[index]
        let splitWord = Array(self.word)
        let letter = splitWord[index]
        let letter_right = String(letter)
        handImage.image = UIImage(named: "Images/HandsColorful/" + letter_right.lowercased())
    }
    
}

extension BottomView {
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

}

