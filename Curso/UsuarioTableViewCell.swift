//
//  UsuarioTableViewCell.swift
//  Curso
//
//  Created by Miguel Canobbio on 03/09/16.
//  Copyright © 2016 Canobbio. All rights reserved.
//

import UIKit

class UsuarioTableViewCell: UITableViewCell {

    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var edadLabel: UILabel!
    @IBOutlet weak var imagen: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
