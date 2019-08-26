import UIKit
import AVKit

public class SignDetectViewController : UIViewController {
    
    public let captureSession = AVCaptureSession()
    public var previewLayer: AVCaptureVideoPreviewLayer?
    public var words: [String] = []
    public var wordCount: Int = 0
    public var wordIndex: Int = 0
    public var bottomView: BottomView?
    
    public var labelTeste = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 100))
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.sessionConfiguration()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setCameraLayer()
        if let bottomView = self.bottomView {
            bottomView.removeFromSuperview()
        }
        self.bottomView = BottomView(frameView: self.view.window!.frame)
        self.view.addSubview(self.bottomView!)
        self.bottomView?.setNew(word: self.words[wordCount])
        self.showWord()
    }

    public func setCameraLayer() {
        self.previewLayer!.videoGravity = .resizeAspectFill
        self.previewLayer?.zPosition = 10
        self.previewLayer!.connection?.videoOrientation = .landscapeRight
        self.previewLayer!.frame = self.view.window!.frame
        self.view.layer.addSublayer(self.previewLayer!)
    }
    
    func analyzeResult(_ prediction: String) {
        let word = words[wordCount]
        let splitWord = Array(word)
        let letter = String(splitWord[wordIndex])
        if prediction == letter.capitalized {
            Player.shared.rightSign()
            self.bottomView?.changeSign(in: wordIndex)
            wordIndex += 1
            if wordCount < self.words.count {
                if splitWord.count == wordIndex {
                    wordCount += 1
                    wordIndex = 0
                    self.showWord()
                    self.bottomView?.setNew(word: self.words[wordCount])
                }
            } else {
                let vc = UIViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    
    public func showWord() {
        let widthLabel = (self.view.window?.frame.width)! * 0.6
        let heightLabel: CGFloat = 50
        let xLabel = (self.view.window!.frame.width / 2) - (widthLabel / 2)
        let yLabel = (self.view.window!.frame.height / 2) - (heightLabel / 2)
        let label = UILabel(frame: CGRect(x: xLabel, y: yLabel, width: widthLabel, height: heightLabel))
        label.text = "The word is '\(words[wordCount])'"
        label.layer.zPosition = 250
        label.textAlignment = .center
        label.alpha = 0.0
        label.textColor = UIColor.white
        label.font = UIFont(name: "Sniglet-Regular", size: 50)
        self.view.addSubview(label)
        UIView.animate(withDuration: 0.5, animations: {
            label.alpha = 1.0
        }) { (success) in
            if success {
                Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { (timer) in
                    UIView.animate(withDuration: 0.5, animations: {
                        label.alpha = 0.0
                    })
                })
            }
        }

    }
    
}
