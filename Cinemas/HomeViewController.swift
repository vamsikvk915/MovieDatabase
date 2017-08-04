//
//  HomeViewController.swift
//  Cinemas
//
//  Created by vamsi krishna reddy kamjula on 7/31/17.
//  Copyright © 2017 kvkr. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var segments: UISegmentedControl!
    @IBAction func actionOnSegmentSelect(_ sender: Any) {
        let urlString:String?
        switch (segments.selectedSegmentIndex) {
        case 0:
            // shows the now playing movie list
            urlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=38c202b89452edcd18696b9e9962f08a&language=en-US&page=1"
            parsingTheData(urlString: urlString!)
        case 1:
            // shows the latest movie list
            urlString = "https://api.themoviedb.org/3/discover/movie?api_key=38c202b89452edcd18696b9e9962f08a&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&year=2017"
            parsingTheData(urlString: urlString!)
        case 2:
            // shows the upcoming Movies list
            urlString = "https://api.themoviedb.org/3/movie/upcoming?api_key=38c202b89452edcd18696b9e9962f08a&language=en-US&page=1"
            parsingTheData(urlString: urlString!)
        default:
            return
        }
    }
    
    var movieTitle = [String]()
    var posterImages = [String]()
    var overviewOfMovie = [String]()
    var backdropPoster = [String]()
    var releaseDate = [String]()
    var movieID = [Double]()
    var averageVote = [Double]()
    
    var year:String?
    
    @IBAction func searchByYearButton(_ sender: Any) {
        year = yearTextField.text
        let urlString = "https://api.themoviedb.org/3/discover/movie?api_key=38c202b89452edcd18696b9e9962f08a&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&year=\(year!)"
        parsingTheData(urlString: urlString)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        /*Search for movie
         link:https://api.themoviedb.org/3/search/movie?api_key=38c202b89452edcd18696b9e9962f08a&language=en-US&query=\(searchTerm)&page=1&include_adult=false
         */
        
        let urlString:String?
        urlString = "https://api.themoviedb.org/3/movie/upcoming?api_key=38c202b89452edcd18696b9e9962f08a&language=en-US&page=1"
        parsingTheData(urlString: urlString!)
    }
    
    func parsingTheData(urlString: String) {
        let url = URL.init(string: urlString)
        let baseURLForImage = "http://image.tmdb.org/t/p/w780/"
        
        movieTitle.removeAll()
        posterImages.removeAll()
        overviewOfMovie.removeAll()
        backdropPoster.removeAll()
        releaseDate.removeAll()
        movieID.removeAll()
        averageVote.removeAll()
        
        do {
            let data = try Data.init(contentsOf: url!)
            let response = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            let results = response["results"] as! [[String:Any]]
            for temp in results {
                let movieName = temp["title"] as! String
                movieTitle.append(movieName)
                let poster = temp["poster_path"] as! String
                let posterURL = baseURLForImage + poster
                posterImages.append(posterURL)
                let overview = temp["overview"] as! String
                overviewOfMovie.append(overview)
                let wallposter = temp["backdrop_path"] as! String
                let backdropURL = baseURLForImage + wallposter
                backdropPoster.append(backdropURL)
                let release = temp["release_date"] as! String
                releaseDate.append(release)
                let id = temp["id"] as! Double
                movieID.append(id)
                let average = temp["vote_average"] as! Double
                averageVote.append(average)
            }
        }catch let error {
            print(error)
        }
        [self.myCollectionView.reloadData()]
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieTitle.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Movies", for: indexPath)
        
        let titleLabel = cell.viewWithTag(1) as! UILabel
        titleLabel.text = movieTitle[indexPath.row]
        
        let overviewLabel = cell.viewWithTag(2) as! UILabel
        overviewLabel.text = overviewOfMovie[indexPath.row]
        overviewLabel.numberOfLines = 0
        
        let poster = cell.viewWithTag(3) as! UIImageView
        let url = URL.init(string: posterImages[indexPath.row])
        do {
            let data = try Data.init(contentsOf: url!)
            let image = UIImage.init(data: data)
            poster.image = image
        }catch let error {
            print(error)
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moreDetails" {
            let destinationVC = segue.destination as! MoreDetailsViewController
            let cell = sender as? UICollectionViewCell
            let indexPath = self.myCollectionView.indexPath(for: cell!)
            
            destinationVC.title = movieTitle[indexPath!.row]
            destinationVC.movieID = movieID[indexPath!.row]
            destinationVC.dateReleased = releaseDate[indexPath!.row]
            destinationVC.movieOverview = overviewOfMovie[indexPath!.row]
            destinationVC.posterImage = posterImages[indexPath!.row]
            destinationVC.wallpaper = backdropPoster[indexPath!.row]
            destinationVC.averageRating = averageVote[indexPath!.row]
        }
    }
}
