<?php
header ('Content-Type: application/json');

require '../pgConnect.php';
require '../class/Connexion.class.php';
require '../class/Hydrate.class.php';
require '../class/produits.class.php';
$cnx = Connexion::getInstance($dsn,$user,$pass);

$pr = new produits($cnx);
$prods = $pr->addProd($_POST['nom_produit'],$_POST['description'],$_POST['prix'],$_POST['id_categorie']);
print json_encode($prods);
