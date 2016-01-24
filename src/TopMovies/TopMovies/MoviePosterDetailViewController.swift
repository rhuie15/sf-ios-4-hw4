//
//  MoviePosterDetailViewController.swift
//  TopMovies
//
//  Created by Raymond Huie on 1/18/16.
//  Copyright © 2016 GA Student. All rights reserved.
//

import UIKit

class MoviePosterDetailViewController: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet weak var imageScrollView: UIScrollView!
    
    var imageURL:NSURL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageScrollView.delegate = self
        
        let moviePosterImage =  UIImage(data: NSData(contentsOfURL: imageURL!)!)
        let moviePosterImageView = UIImageView(image: moviePosterImage)
        moviePosterImageView.frame = self.view.frame  // expands to fill the size of the screen
        
        self.imageScrollView.addSubview(moviePosterImageView)
        self.imageScrollView.contentSize = moviePosterImageView.frame.size
     
        
        // Do any additional setup after loading the view.
    }

    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return scrollView.subviews.first
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
