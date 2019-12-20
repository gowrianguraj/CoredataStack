//
//  CustomTableViewCell.swift
//  Sample
//
//  Created by gowri anguraj on 22/10/19.
//  Copyright © 2019 gowri anguraj. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var tbldogName : UILabel!
    @IBOutlet weak var tblDescription : UILabel!
    @IBOutlet weak var tblDogAge : UILabel!
    @IBOutlet weak var tblImageUrl : UIImageView!
     var view :UIView?
    /*
    var albumModels:AlbumModels!{
        didSet{
            tbldogName.text = albumModels.dogName
            tblDescription.text = albumModels.description
            if let priceOfProduct = albumModels.age {
                tblDogAge.text = "Almost \(String(priceOfProduct)) years"
            }
            else{
                tblDogAge.text = "";
            }
            
            
            if let imageURL = URL(string: albumModels.url!){
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: imageURL)
                    if let data = data {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.tblImageUrl.image = image
                        }
                    }
                }
            }
        }
    }*/
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPhotoCellWith(dogs: Dogs) {
        
        DispatchQueue.main.async {
            self.tbldogName.text = dogs.dogName
            self.tblDescription.text = dogs.discription
            //self.tblDogAge.text = String(dogs.age)
            if let url = dogs.url {
                self.tblImageUrl.loadImageUsingCacheWithURLString(url, placeHolder: UIImage(named: "placeholder"))
            }
        }
    }

}
