//
//  PagerViewController.swift
//  constraintExample
//
//  Created by P21_0105 on 12/01/22.
//

import UIKit

class PagerViewController: UIViewController ,UIScrollViewDelegate{

    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
 
    @IBAction func btnNext(_ sender: Any) {
        print("hello")
        btnNext.setTitle("Done", for: .normal)
        imageView.image = UIImage(named: "intro_image2")
    }
    
}
