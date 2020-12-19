//
//  ViewController.swift
//  datePicker2016
//
//  Created by BettyPan on 2020/12/16.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var AUDatePicker: UIDatePicker!
    @IBOutlet weak var dateSlider: UISlider!
    
    let dateFormatter = DateFormatter()
    var dateString:String = ""
    var timer:Timer?
    var imageNumber = 0
    var sliderNumber = 0
    //Array 依序列出欲顯示之圖片
    let AUphotos = [
        "20170120.jpg", "20170220.jpg", "20170320.jpg",
        "20170420.jpg", "20170520.jpg", "20170620.jpg",
        "20170720.jpg", "20170820.jpg",
        "20170920.jpg","20171020.jpg", "20171120.jpg",
        "20171220.jpg"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
    }
    //使用switch做選擇照片的連續數值判斷
    func choosePhoto(num2:Int){
        switch num2 {
        case 0: dateString = "2017/01/20"
        case 1: dateString = "2017/02/20"
        case 2: dateString = "2017/03/20"
        case 3: dateString = "2017/04/20"
        case 4: dateString = "2017/05/20"
        case 5: dateString = "2017/06/20"
        case 6: dateString = "2017/07/20"
        case 7: dateString = "2017/08/20"
        case 8: dateString = "2017/09/20"
        case 9: dateString = "2017/10/20"
        case 10: dateString = "2017/11/20"
        default: dateString = "2017/12/20"
        }
        //使datePicker顯示之日期為dateString內的字串
        let date = dateFormatter.date(from: dateString)
        AUDatePicker.date = date!
        
    }
    //if eles, 比對Array內的照片
    func compare() {
        if imageNumber >= AUphotos.count {
            imageNumber = 0
            choosePhoto(num2: imageNumber)
            photoImageView.image = UIImage(named: AUphotos[imageNumber])
        }else{
            choosePhoto(num2: imageNumber)
            photoImageView.image = UIImage(named: AUphotos[imageNumber])
        }
        //連動slider
        dateSlider.value = Float(imageNumber)
        imageNumber += 1
        
    }
    //每秒執行一次compare(使圖片跑起來)
    func time() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {(timer) in
            self.compare()
        })
    }
    
    @IBAction func chageDate(_ sender: UIDatePicker) {
        //取得datePicker的日期
        let photoDate = AUDatePicker.date
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: photoDate)
        
        var month = dateComponents.month!
        //Array由0開始，因此月份需-1
        month -= 1
        photoImageView.image = UIImage(named:AUphotos[month])
        
        //連動slider
        dateSlider.value = Float(month)
    
    }

    @IBAction func changeDateSlider(_ sender: UISlider) {
        //取得日期
        sliderNumber = Int(sender.value)
        dateSlider.value.round()
        photoImageView.image = UIImage(named: AUphotos[sliderNumber])
        
    }
    
    @IBAction func autoPlay(_ sender: UISwitch) {
        if sender .isOn{
            time()
            imageNumber = sliderNumber
            dateSlider.value = Float(imageNumber)
        }else{
            timer?.invalidate()
        }
    }
    
    
    
    
    }


