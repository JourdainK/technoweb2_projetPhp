<?php
header('Content-Type: application/json');
require '../pgConnect.php';
require '../class/Connexion.class.php';
require '../class/Hydrate.class.php';
require '../class/produits.class.php';
$cnx = Connexion::getInstance($dsn,$user,$pass);

$prod = new produits($cnx);
$prodFound = $prod->getProdByNom($_POST['nomInput']);