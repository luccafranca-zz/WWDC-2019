import UIKit
import AVKit

public class PodcastViewController: UIViewController, UITextViewDelegate {
    
    internal var isStarted: Bool = false
    internal let transcriptionData = TranscriptionData()
    internal var textView = UITextView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    internal var wordIndex = 0
    internal var wordCount = 0
    internal let synthesizer = AVSpeechSynthesizer()
    internal let luigiImage = UIImageView(image: UIImage(named: "Images/luigiHead"))
    internal let imacImage = UIImageView(image: UIImage(named: "Images/iMac"))
    internal var startButton = UIButton(type: .roundedRect)
    internal var signButton = UIButton(type: .roundedRect)
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.textView.delegate = self
        self.view.addSubview(self.textView)
        Player.shared.playMusic()
        self.registerFonts()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    public override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.white
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if isStarted {
            self.drawLuigi()
            self.presentTextView()
        } else {
            self.presentStartButtom()
            self.drawLuigi()
        }
    }
    
    internal func presentStartButtom() {
        self.startButton.removeFromSuperview()
        self.startButton = StartButton(window: self.view.window!)
        self.startButton.addTarget(self, action: #selector(start), for: .touchUpInside)
        self.view.addSubview(self.startButton)
    }
    
    @objc internal func start() {
        if !self.isStarted {
            self.isStarted = true
            Player.shared.turnDownMusic()
            UIView.animate(withDuration: 0.67, animations: {
                self.startButton.alpha = 0.0
            }) { (success) in
                if success {
                    self.startButton.removeFromSuperview()
                    self.drawLuigi()
                    self.setText()
                    self.playText()
                }
            }
        }
    }
    
    internal func presentTextView() {
        let widthIMac = self.view.window!.frame.width * 0.65
        let heightIMac = widthIMac / Constants.iMacProportion
        let xIMac = self.view.window!.frame.width * 0.325
        let yIMac = self.view.window!.frame.height - heightIMac + 15
        self.imacImage.frame = CGRect(x: xIMac, y: yIMac, width: widthIMac, height: heightIMac)
        self.imacImage.layer.zPosition = 10
        self.view.addSubview(self.imacImage)        
        let widthTextView = widthIMac * 0.9
        let heightTextView = heightIMac * 0.57
        let xFrame = xIMac + (widthIMac * 0.06)
        let yFrame = yIMac + (heightIMac * 0.1)
        let frameTextView = CGRect(x: xFrame, y: yFrame, width: widthTextView, height: heightTextView)
        self.textView.frame = frameTextView
        self.textView.layer.zPosition = 20
        self.textView.backgroundColor = UIColor.clear
        self.textView.isSelectable = false
        self.textView.isMultipleTouchEnabled = false
        self.textView.font = UIFont(name: "OpenSans-Regular", size: 25)
        self.textView.layoutManager.allowsNonContiguousLayout = false
    }

    internal func playText() {
        let utterance = AVSpeechUtterance(string: transcriptionData.content)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        self.synthesizer.speak(utterance)
    }
    
    internal func setText() {
        let arrayOfWords = transcriptionData.content.split(separator: " ")
        Timer.scheduledTimer(withTimeInterval: 0.39, repeats: true) { (timer) in
            if self.transcriptionData.words.isEmpty {
                self.textView.text.append(contentsOf: arrayOfWords[self.wordIndex] + " ")
            } else {
                let actualWord = String(arrayOfWords[self.wordIndex])
                let preWord = self.transcriptionData.words.first
                if actualWord == preWord {
                    let wordSize = actualWord.count
                    var unknownString = ""
                    for _ in 0..<wordSize {
                        unknownString.append("_")
                    }
                    self.textView.text.append(contentsOf: unknownString + " ")
                } else {
                    self.textView.text.append(contentsOf: arrayOfWords[self.wordIndex] + " ")
                }
            }
            let stringLenght: Int = self.textView.text.count
            self.textView.scrollRangeToVisible(NSMakeRange(stringLenght - 1, 0))
            self.wordIndex += 1
            if self.wordIndex == arrayOfWords.count {
                timer.invalidate()
                self.showHelpLuigiButton()
            }
        }
    }
    
    internal func drawLuigi() {
        let widthLuigi = self.view.window!.frame.width * 0.30
        let heightLuigi = widthLuigi / Constants.luigiHeadProportion
        self.luigiImage.frame = CGRect(x: 10, y: self.view.window!.frame.height - heightLuigi, width: widthLuigi, height: heightLuigi)
        self.luigiImage.contentMode = .scaleAspectFill
        if self.isStarted {
            UIView.animate(withDuration: 0.3) {
                self.luigiImage.alpha = 1.0
            }
        } else {
            self.luigiImage.alpha = 0.0
        }
        self.view.addSubview(self.luigiImage)
    }
    
    func showHelpLuigiButton() {
        self.signButton = HelpLuigiButton(window: self.view.window!)
        signButton.addTarget(self, action: #selector(showSignView), for: .touchUpInside)
        self.view.addSubview(signButton)
    }
    
    @objc func showSignView() {
        Player.shared.stopMusic()
        let vc = SignDetectViewController()
        vc.words = self.transcriptionData.words
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func registerFonts() {
        let cfURL1 = Bundle.main.url(forResource: "Fonts/Sniglet-Regular", withExtension: "ttf")! as CFURL
        let cfURL2 = Bundle.main.url(forResource: "Fonts/OpenSans-Regular", withExtension: "ttf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL1, CTFontManagerScope.process, nil)
        CTFontManagerRegisterFontsForURL(cfURL2, CTFontManagerScope.process, nil)
        var fontNames: [[AnyObject]] = [[]]
        for name in UIFont.familyNames {
            fontNames.append(UIFont.fontNames(forFamilyName: name) as [AnyObject])
        }
    }
    
}

