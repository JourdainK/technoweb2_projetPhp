<?php
header('Content-Type: application/json');
require '../pgConnect.php';
require '../class/Connexion.class.php';
require '../class/Hydrate.class.php';
require '../class/produits.class.php';
$cnx = Connexion::getInstance($dsn,$user,$pass);

$prod = new produits($cnx);
$data[] = $prod->getProdByNom($_POST['nom_produit']);

print json_encode($data);