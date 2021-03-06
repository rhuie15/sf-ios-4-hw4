//
//  RandomMovieViewController.swift
//  TopMovies
//
//  Created by Jeffrey Bergier on 12/12/15.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    //
    // Put IBOutlets Below This Line
    //
    
    @IBOutlet weak var titleLabel: UILabel?
    
    @IBOutlet weak var directorLabel: UILabel?
    
    @IBOutlet weak var summaryLabel: UILabel?
    
    @IBOutlet weak var imageView: UIImageView?
    //
    // Put IBOutlets Above This Line
    //
    
   // var movieTitle = ""
   // var director = ""
   // var summary = ""
  //  var imageURL = NSURL(string: "")!
    
    var movieTitle:String?
    var director:String?
    var summary:String?
    var imageURL:NSURL?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        titleLabel!.text = movieTitle
        directorLabel!.text = director
        summaryLabel!.text = summary
        imageView!.setImageWithURL(imageURL!)
        
         }
  
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
        if segue.identifier == "moviePosterDetailSegue" {
            let movPosterDetailViewController = segue.destinationViewController as! MoviePosterDetailViewController
            movPosterDetailViewController.imageURL = self.imageURL!
        }
        
        
    }
    

    

    

}
