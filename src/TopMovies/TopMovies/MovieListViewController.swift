//
//  MovieListViewController.swift
//  TopMovies
//
//  Created by Raymond Huie on 1/11/16.
//  Copyright © 2016 GA Student. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var movies: [NSDictionary]?
    
    @IBOutlet weak var movieListTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.movieListTableView.delegate = self
        self.movieListTableView.dataSource = self
    
        
        self.title = "🔝🎞"
        
        let itunesURL = NSURL(string: "https://itunes.apple.com/us/rss/topmovies/limit=100/json")!
        NSURLSession.sharedSession().dataTaskWithRequest(NSURLRequest(URL: itunesURL)) { (data, response, error) in
            dispatch_async(dispatch_get_main_queue()) {
                let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                let moviesArray = json.valueForKeyPath("feed.entry") as? [NSDictionary]
                self.movies = moviesArray
                
                self.movieListTableView.reloadData()  // gets inserted into the tableview once the download is finished
                
                print("Yay! The Movies Downloaded! 🎉")
            }
            }.resume()
    }
    
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {  // indexPath gives section and row
        print("willdisplaycell")
        let movieCell = cell as! MovieTableViewCell
    
        let title = self.titleStringForMovieAtIndex(indexPath.row)
        let director = self.directorStringForMovieAtIndex(indexPath.row)
        let summary = self.summaryStringForMovieAtIndex(indexPath.row)
        let posterImageURL = self.posterImageURLForMovieAtIndex(indexPath.row)
        
        movieCell.titleLabel?.text = title
        movieCell.directorLabel?.text = director
        movieCell.descriptionLabel?.text = summary
        movieCell.posterImageView?.setImageWithURL(posterImageURL)
        
   //    self.imageView?.image = nil   // this will prevent the old image from displaying while there is new text for the new movie
   //   self.imageView?.setImageWithURL(posterImageURL)

        
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
            print(self.movies?.count)
            return self.movies?.count ?? 0   // ?? 0 is the default value
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("cellforRowAtIndexPath")
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath)
        if let movieCell = cell as? MovieTableViewCell {
            movieCell.posterImageView.image = nil   // explain this
        }
        
        return cell
        
    }
        
    
    func titleStringForMovieAtIndex(index: Int) -> String? {
        let movie = self.movies?[index]
        let title = movie?.valueForKeyPath("im:name.label") as? String
        return title
    }
    
    func directorStringForMovieAtIndex(index: Int) -> String? {
        let movie = self.movies?[index]
        let director = movie?.valueForKeyPath("im:artist.label") as? String
        return director
    }
    
    func summaryStringForMovieAtIndex(index: Int) -> String? {
        let movie = self.movies?[index]
        let summary = movie?.valueForKeyPath("summary.label") as? String
        return summary
    }
    
    func posterImageURLForMovieAtIndex(index: Int) -> NSURL {
        let movie = self.movies?[index]
        let posterImageURLArray = movie?.valueForKeyPath("im:image.label") as? [String]
        let posterImageURLString = posterImageURLArray?.last
        let posterImageURL = NSURL(string: posterImageURLString!)!
        return posterImageURL
    }
    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "movieDetailSegue" {
            let movDetailViewController = segue.destinationViewController as! MovieDetailViewController
            let selectedMovieRow = movieListTableView.indexPathForSelectedRow!.row
            movDetailViewController.movieTitle = self.titleStringForMovieAtIndex(selectedMovieRow)!
            movDetailViewController.director = self.directorStringForMovieAtIndex(selectedMovieRow)!
            movDetailViewController.summary = self.summaryStringForMovieAtIndex(selectedMovieRow)!
            movDetailViewController.imageURL = self.posterImageURLForMovieAtIndex(selectedMovieRow)
        }
        
        
    }
 

}
