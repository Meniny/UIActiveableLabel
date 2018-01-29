//
//  ViewController.swift
//  Sample
//
//  Created by 李二狗 on 2018/1/29.
//  Copyright © 2018年 Meniny Lab. All rights reserved.
//

import UIKit
import UIActiveableLabel

class ViewController: UIViewController {

    @IBOutlet weak var label: UIActiveableLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let yayType = UIActiveableType.custom(pattern: "\\sYay\\b") //Looks for "Yay"
        let itType = UIActiveableType.custom(pattern: "\\sit\\b") //Looks for "it"
        let supportsType = UIActiveableType.custom(pattern: "\\ssupports\\b") //Looks for "supports"
        
        self.label.enabledTypes.append(yayType)
        self.label.enabledTypes.append(itType)
        self.label.enabledTypes.append(supportsType)
        
        self.label.urlMaximumLength = 31
        
        self.label.customize { label in
            
            label.text = "This is a sample post with #multiple #hashtags and a @userhandle.\n" +
                "Links are also supported,\nlike: https://meniny.cn.\n" +
                "Now it also supports custom patterns -> Yay\n\n" +
            "Let's trim a long link: \nhttps://meniny.cn/api/v2/about.json"
            
            label.numberOfLines = 0
            label.lineSpacing = 4
            
            label.textColor = UIColor(red: 0.26, green: 0.25, blue: 0.25, alpha: 1.00)
            label.hashtagColor = UIColor(red: 1.00, green: 0.77, blue: 0.18, alpha: 1.00)
            label.mentionColor = UIColor(red: 0.64, green: 0.64, blue: 0.99, alpha: 1.00)
            label.URLColor = UIColor(red: 0.89, green: 0.38, blue: 0.30, alpha: 1.00)
            label.URLSelectedColor = UIColor(red: 0.31, green: 0.68, blue: 0.33, alpha: 1.00)
            
            label.handleMentionTap {
                self.alert("Mention", message: $0)
            }
            label.handleHashtagTap {
                self.alert("Hashtag", message: $0)
            }
            label.handleURLTap {
                self.alert("URL", message: $0.absoluteString)
            }
            
            //Custom types
            
            label.customColor[yayType] = UIColor.purple
            label.customSelectedColor[yayType] = UIColor.green
            
            label.customColor[itType] = UIColor.magenta
            label.customSelectedColor[itType] = UIColor.green
            
            label.customColor[supportsType] = UIColor.lightGray
            label.customSelectedColor[supportsType] = UIColor.green
            
            label.handleCustomTap(for: yayType) {
                self.alert("Custom type", message: $0)
            }
            label.handleCustomTap(for: itType) {
                self.alert("Custom type", message: $0)
            }
            label.handleCustomTap(for: supportsType) {
                self.alert("Custom type", message: $0)
            }
        }
        
//        label.frame = CGRect(x: 20, y: 40, width: view.frame.width - 40, height: 300)
        
    }
    
    func alert(_ title: String, message: String) {
        let vc = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        vc.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
        self.present(vc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

