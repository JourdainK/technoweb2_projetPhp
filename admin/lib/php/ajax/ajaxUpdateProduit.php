<?php
header('Content-type: application/json');

require '../pgConnect.php';
require '../class/Connexion.class.php';
require '../class/Hydrate.class.php';
require '../class/produits.class.php';

$cnx = Connexion::getInstance($dsn,$user,$pass);

$prod = new produits($cnx);
$produits[] = $prod->updateProduit($_POST['champ'],$_POST['valeur'],$_POST['id_produit']);

print json_encode($produits);