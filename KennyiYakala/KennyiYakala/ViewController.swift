
import UIKit

class ViewController: UIViewController {

    var timer = Timer()
    var timerKenny = Timer()
    var Counter = 0
    var sscore = 0
    var kennyArray = [UIImageView]()
    var hiighScore = 0
    
    @IBOutlet weak var ImageView9: UIImageView!
    @IBOutlet weak var ImageView8: UIImageView!
    @IBOutlet weak var ImageView7: UIImageView!
    @IBOutlet weak var ImageView6: UIImageView!
    @IBOutlet weak var ImageView5: UIImageView!
    @IBOutlet weak var ImageView4: UIImageView!
    @IBOutlet weak var ImageView3: UIImageView!
    @IBOutlet weak var ImageView2: UIImageView!
    @IBOutlet weak var ImageView1: UIImageView!
    
    
    @IBOutlet weak var highScore: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var sayacc: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        score.text = "Score: \(sscore)"
        
        let storedHighScore = UserDefaults.standard.object(forKey: "skor")
        if storedHighScore == nil{
            hiighScore = 0
            highScore.text = String("HighScore \(hiighScore)")
        }
        
        if let newScore = storedHighScore as? Int{
            hiighScore = newScore
            highScore.text = String("HighScore: \(hiighScore)")
        }
        
        
        
        ImageView1.isUserInteractionEnabled = true
        ImageView2.isUserInteractionEnabled = true
        ImageView3.isUserInteractionEnabled = true
        ImageView4.isUserInteractionEnabled = true
        ImageView5.isUserInteractionEnabled = true
        ImageView6.isUserInteractionEnabled = true
        ImageView7.isUserInteractionEnabled = true
        ImageView8.isUserInteractionEnabled = true
        ImageView9.isUserInteractionEnabled = true

        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(basmaDurumu))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(basmaDurumu))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(basmaDurumu))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(basmaDurumu))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(basmaDurumu))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(basmaDurumu))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(basmaDurumu))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(basmaDurumu))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(basmaDurumu))
        
        ImageView1.addGestureRecognizer(gestureRecognizer1)
        ImageView2.addGestureRecognizer(gestureRecognizer2)
        ImageView3.addGestureRecognizer(gestureRecognizer3)
        ImageView4.addGestureRecognizer(gestureRecognizer4)
        ImageView5.addGestureRecognizer(gestureRecognizer5)
        ImageView6.addGestureRecognizer(gestureRecognizer6)
        ImageView7.addGestureRecognizer(gestureRecognizer7)
        ImageView8.addGestureRecognizer(gestureRecognizer8)
        ImageView9.addGestureRecognizer(gestureRecognizer9)
        
        kennyArray = [ImageView1 ,ImageView2 ,ImageView3 ,ImageView4 ,ImageView5 ,ImageView6 ,ImageView7 ,ImageView8 ,ImageView9 ]
        
        Counter = 10
        sayacc.text = String(Counter)
       timer =  Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector (timerFunc), userInfo: nil, repeats: true)
        timerKenny = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        hideKenny()
    }

    
    @objc func hideKenny(){
        for kenny in kennyArray{
            kenny.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(kennyArray.count-1)))
        kennyArray[random].isHidden = false
    }
    
    @objc func timerFunc(){
        sayacc.text = String(Counter)
        Counter -= 1
        if Counter < 0 {
            timer.invalidate()
            timerKenny.invalidate()
            
            for kenny in kennyArray{
                kenny.isHidden = true
            }
            
            if self.sscore > self.hiighScore{
                self.hiighScore = self.sscore
                UserDefaults.standard.set(self.hiighScore, forKey: "skor")
            }
            
            let alert = UIAlertController(title: "Bitti!", message: "Son", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
            let tryButton = UIAlertAction(title: "Dene", style: UIAlertAction.Style.default){
                (UIAlertAction) in
                self.sscore = 0
                self.score.text = "Score: \(self.sscore)"
                self.Counter = 10
                self.sayacc.text = String(self.Counter)
                
                self.timer =  Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector (self.timerFunc), userInfo: nil, repeats: true)
                self.timerKenny = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
            }
            
            
            alert.addAction(okButton)
            alert.addAction(tryButton)
            self.present(alert, animated: true)
            
            sayacc.text = "Time's over!"
        }
    }
    
    @objc func basmaDurumu(){
        sscore += 1
        score.text = "Score: \(sscore)"
        
    }
    
}


