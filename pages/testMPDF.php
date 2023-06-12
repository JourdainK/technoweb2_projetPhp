<?php
require_once '../vendor/autoload.php';

require '../admin/lib/php/pgConnect.php';
require '../admin/lib/php/class/Connexion.class.php';
require '../admin/lib/php/class/Hydrate.class.php';
require '../admin/lib/php/class/produits.class.php';

$cnx = Connexion::getInstance($dsn,$user,$pass);

$prod = new produits($cnx);

$produits = $prod->getAllProduits();

$nbr = count($produits);



$mpdf = new \Mpdf\Mpdf();

$mpdf->WriteHTML('<h1>Nos Produits</h1>');

$mpdf->SetXY(20,30);

for($i=0;$i<$nbr;$i++){

    if($produits[$i]->id_categorie == 1){
        $mpdf->WriteHTML('Catégorie : DVD');
    }
    else if($produits[$i]->id_categorie == 2){
        $mpdf->WriteHTML('Catégorie : CD');
    }
    else{
        $mpdf->WriteHTML('Catégorie : Goodies');
    }

    $mpdf->WriteHTML('Description : '.$produits[$i]->nom_produit);
    $mpdf->WriteHTML('Resumé : '.$produits[$i]->description);
    $mpdf->WriteHTML('Prix : '.$produits[$i]->prix. ' €');

    //$mpdf->WriteHTML('Photo : ../'.$produits[$i]->photo);
    //image doesn't work, doesn't want to, manage once to show half pictures .... i give up, lost hours on these
    //$mpdf->WriteHTML('<img title="photo du produit" src="../'.$produits[$i]->photo.'">');
    //$mpdf->Image($produits[$i]->photo, 10, 10, 50, 50, 'jpg' or 'webp', '', true, false);

    $mpdf->WriteHTML('<br><br>');

}
$mpdf->showImageErrors = true;
$mpdf->debug = true;
$mpdf->Output();
